//
//  ActivityTracker.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI

struct ActivityLog {
    var distance: Double // Miles
    var duration: Double // Seconds
    var elevation: Double // Feet
    var date: Date
}

struct ActivityGraph: View {
    
    var logs: [ActivityLog]
    @Binding var selectedIndex: Int
    
    @State var lineOffset: CGFloat = 8 // Vertical line offset
    @State var selectedXPos: CGFloat = 8 // User X touch location
    @State var selectedYPos: CGFloat = 0 // User Y touch location
    @State var isSelected: Bool = false // Is the user touching the graph
    
    init(logs: [ActivityLog], selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex

        let curr = Date() // Today's Date
        let sortedLogs = logs.sorted { (log1, log2) -> Bool in
            log1.date > log2.date
        } // Sort the logs in chronological order
        
        var mergedLogs: [ActivityLog] = []

        for i in 0..<12 { // Loop back for the past 12 weeks

            var weekLog: ActivityLog = ActivityLog(distance: 0, duration: 0, elevation: 0, date: Date())

            for log in sortedLogs {
                // If log is within specific week, then add to weekly total
                if log.date.distance(to: curr.addingTimeInterval(TimeInterval(-604800 * i))) < 604800 && log.date < curr.addingTimeInterval(TimeInterval(-604800 * i)) {
                    weekLog.distance += log.distance
                    weekLog.duration += log.duration
                    weekLog.elevation += log.elevation
                }
            }

            mergedLogs.insert(weekLog, at: 0)
        }

        self.logs = mergedLogs
    }
    
    var body: some View {
        drawGrid()
            .opacity(0.2)
            .overlay(drawActivityGradient(logs: logs))
            .overlay(drawActivityLine(logs: logs))
            .overlay(drawLogPoints(logs: logs))
            .overlay(addUserInteraction(logs: logs))
    }
    
    func drawGrid() -> some View {
        VStack(spacing: 0) {
            Color.black.frame(height: 1, alignment: .center)
            HStack(spacing: 0) {
                Color.clear
                    .frame(width: 8, height: 100)
                ForEach(0..<11) { i in
                    Color.black.frame(width: 1, height: 100, alignment: .center)
                    Spacer()

                }
                Color.black.frame(width: 1, height: 100, alignment: .center)
                Color.clear
                    .frame(width: 8, height: 100)
            }
            Color.black.frame(height: 1, alignment: .center)
        }
    }
    
    func drawActivityGradient(logs: [ActivityLog]) -> some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 82/255, blue: 0), .white]), startPoint: .top, endPoint: .bottom)
            .padding(.horizontal, 8)
            .padding(.bottom, 1)
            .opacity(0.8)
            .mask(
                GeometryReader { geo in
                    Path { p in
                        // Used for scaling graph data
                        let maxNum = logs.reduce(0) { (res, log) -> Double in
                            return max(res, log.distance)
                        }

                        let scale = geo.size.height / CGFloat(maxNum)

                        //Week Index used for drawing (0-11)
                        var index: CGFloat = 0

                        // Move to the starting y-point on graph
                        p.move(to: CGPoint(x: 8, y: geo.size.height - (CGFloat(logs[Int(index)].distance) * scale)))

                        // For each week draw line from previous week
                        for _ in logs {
                            if index != 0 {
                                p.addLine(to: CGPoint(x: 8 + ((geo.size.width - 16) / 11) * index, y: geo.size.height - (CGFloat(logs[Int(index)].distance) * scale)))
                            }
                            index += 1
                        }

                        // Finally close the subpath off by looping around to the beginning point.
                        p.addLine(to: CGPoint(x: 8 + ((geo.size.width - 16) / 11) * (index - 1), y: geo.size.height))
                        p.addLine(to: CGPoint(x: 8, y: geo.size.height))
                        p.closeSubpath()
                    }
                }
            )
    }
    
    func drawActivityLine(logs: [ActivityLog]) -> some View {
        GeometryReader { geo in
            Path { p in
                let maxNum = logs.reduce(0) { (res, log) -> Double in
                    return max(res, log.distance)
                }

                let scale = geo.size.height / CGFloat(maxNum)
                var index: CGFloat = 0

                p.move(to: CGPoint(x: 8, y: geo.size.height - (CGFloat(logs[0].distance) * scale)))

                for _ in logs {
                    if index != 0 {
                        p.addLine(to: CGPoint(x: 8 + ((geo.size.width - 16) / 11) * index, y: geo.size.height - (CGFloat(logs[Int(index)].distance) * scale)))
                    }
                    index += 1
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
            .foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
        }
    }
    
    func drawLogPoints(logs: [ActivityLog]) -> some View {
        GeometryReader { geo in

            let maxNum = logs.reduce(0) { (res, log) -> Double in
                return max(res, log.distance)
            }

            let scale = geo.size.height / CGFloat(maxNum)

            ForEach(logs.indices) { i in
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
                    .background(Color.white)
                    .cornerRadius(5)
                    .offset(x: 8 + ((geo.size.width - 16) / 11) * CGFloat(i) - 5, y: (geo.size.height - (CGFloat(logs[i].distance) * scale)) - 5)
            }
        }
    }
    
    func addUserInteraction(logs: [ActivityLog]) -> some View {
        
        GeometryReader { geo in

            let maxNum = logs.reduce(0) { (res, log) -> Double in
                return max(res, log.distance)
            }

            let scale = geo.size.height / CGFloat(maxNum)

            ZStack(alignment: .leading) {
                // Line and point overlay code from before
                Color(red: 251/255, green: 82/255, blue: 0)
                                .frame(width: 2)
                                .overlay(
                                    Circle()
                                        .frame(width: 24, height: 24, alignment: .center)
                                        .foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
                                        .opacity(0.2)
                                        .overlay(
                                            Circle()
                                                .fill()
                                                .frame(width: 12, height: 12, alignment: .center)
                                                .foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
                                        )
                                        .offset(x: 0, y: isSelected ? 12 - (selectedYPos * scale) : 12 - (CGFloat(logs[selectedIndex].distance) * scale))
                                    , alignment: .bottom)

                                .offset(x: isSelected ? lineOffset : 8 + ((geo.size.width - 16) / 11) * CGFloat(selectedIndex), y: 0)
                                .animation(Animation.spring().speed(4))
                
                // Drag Gesture Code
                Color.white.opacity(0.1)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { touch in
                                let xPos = touch.location.x
                                self.isSelected = true
                                let index = (xPos - 8) / (((geo.size.width - 16) / 11))

                                if index > 0 && index < 11 {
                                    let m = (logs[Int(index) + 1].distance - logs[Int(index)].distance)
                                    self.selectedYPos = CGFloat(m) * index.truncatingRemainder(dividingBy: 1) + CGFloat(logs[Int(index)].distance)
                                }


                                if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < 11 {
                                    self.selectedIndex = Int(index) + 1
                                } else {
                                    self.selectedIndex = Int(index)
                                }
                                //
                                if self.selectedIndex >= 12 {
                                    self.selectedIndex = 11
                                }
                                self.selectedXPos = min(max(8, xPos), geo.size.width - 8)
                                self.lineOffset = min(max(8, xPos), geo.size.width - 8)
                            }
                            .onEnded { touch in
                                let xPos = touch.location.x
                                self.isSelected = false
                                let index = (xPos - 8) / (((geo.size.width - 16) / 11))

                                if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < 11 {
                                    self.selectedIndex = Int(index) + 1
                                } else {
                                    self.selectedIndex = Int(index)
                                }
                                //
                                if self.selectedIndex >= 12 {
                                    self.selectedIndex = 11
                                }
                            }
                    )
            
        }
        }
    }
    
}

struct ActivityHistoryText: View {
    
    var logs: [ActivityLog]
    var mileMax: Int
    
    @Binding var selectedIndex: Int
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter
    }
    
    init(logs: [ActivityLog], selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex

        let curr = Date() // Today's Date
        let sortedLogs = logs.sorted { (log1, log2) -> Bool in
            log1.date > log2.date
        } // Sort the logs in chronological order
        
        var mergedLogs: [ActivityLog] = []

        for i in 0..<12 {

            var weekLog: ActivityLog = ActivityLog(distance: 0, duration: 0, elevation: 0, date: Date())

            for log in sortedLogs {
                if log.date.distance(to: curr.addingTimeInterval(TimeInterval(-604800 * i))) < 604800 && log.date < curr.addingTimeInterval(TimeInterval(-604800 * i)) {
                    weekLog.distance += log.distance
                    weekLog.duration += log.duration
                    weekLog.elevation += log.elevation
                }
            }

            mergedLogs.insert(weekLog, at: 0)
        }

        self.logs = mergedLogs
        self.mileMax = Int(mergedLogs.max(by: { $0.distance < $1.distance })?.distance ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(dateFormatter.string(from: logs[selectedIndex].date.addingTimeInterval(-604800))) - \(dateFormatter.string(from: logs[selectedIndex].date))".uppercased())
                .font(Font.body.weight(.heavy))
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Distance")
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.5))
                    Text(String(format: "%.2f mi", logs[selectedIndex].distance))
                        .font(Font.system(size: 20, weight: .medium, design: .default))
                }
                
                Color.gray
                    .opacity(0.5)
                    .frame(width: 1, height: 30, alignment: .center)
                    
                VStack(alignment: .leading, spacing: 4) {
                    Text("Time")
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.5))
                    Text(String(format: "%.0fh", logs[selectedIndex].duration / 3600) + String(format: " %.0fm", logs[selectedIndex].duration.truncatingRemainder(dividingBy: 3600) / 60))
                        .font(Font.system(size: 20, weight: .medium, design: .default))
                }
                
                Color.gray
                    .opacity(0.5)
                    .frame(width: 1, height: 30, alignment: .center)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Elevation")
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.5))
                    Text(String(format: "%.0f ft", logs[selectedIndex].elevation))
                        .font(Font.system(size: 20, weight: .medium, design: .default))
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("LAST 12 WEEKS")
                    .font(Font.caption.weight(.heavy))
                    .foregroundColor(Color.black.opacity(0.7))
                Text("\(mileMax) mi")
                    .font(Font.caption)
                    .foregroundColor(Color.black.opacity(0.5))
            }.padding(.top, 10)
        }
    }
}
    

struct ActivityTestData {
    var testData: [ActivityLog] = []
    let formatter = DateFormatter()
    
    var offset: CGFloat = 0
    
    init() {
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
       
        self.testData.append(ActivityLog(distance: 4.51, duration: 5000, elevation: 121, date: formatter.date(from: "2021/08/06 22:31")!))
        self.testData.append(ActivityLog(distance: 4.01, duration: 5000, elevation: 121, date: formatter.date(from: "2021/08/07 22:31")!))
        self.testData.append(ActivityLog(distance: 5.01, duration: 500, elevation: 121, date: formatter.date(from: "2021/08/08 22:31")!))
        self.testData.append(ActivityLog(distance: 6.01, duration: 800, elevation: 150, date: formatter.date(from: "2021/08/10 22:31")! ))
        self.testData.append(ActivityLog(distance: 1.01, duration: 50, elevation: 12, date: formatter.date(from: "2021/08/14 22:31")! ))
        self.testData.append(ActivityLog(distance: 8.01, duration: 600, elevation: 40, date: formatter.date(from: "2021/08/20 22:31")! ))
        self.testData.append(ActivityLog(distance: 10.01, duration: 700, elevation: 220, date: formatter.date(from: "2021/08/21 22:31")! ))
    }
}
