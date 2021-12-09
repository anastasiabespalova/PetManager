//
//  ContentView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 21.08.2021.
//
import SwiftUI
import MapKit

struct SyncView<Content: View>: View {
    @Binding var selection: Int
    var tag: Int
    var content: () -> Content
    @ViewBuilder
    var body: some View {
        if selection == tag {
            content()
        } else {
            Spacer()
        }
    }
}

struct ContentView: View {
   // @ObservedObject var petViewModel = PetViewModel()
    @State var selection = 0
  //  @State private var cyclingStartTime = Date()
  //  @State private var timeCycling = 0.0
   // @ObservedObject var petViewModel = PetViewModel()
    var body: some View {
    
        
        TabView(selection: $selection) {
            SyncView(selection: $selection, tag: 0) {
            MainPageCircle()
            }
               // .environmentObject(petViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0) 
            SyncView(selection: $selection, tag: 1) {
           PetList()
            }
             //   .environmentObject(petViewModel)
            //PetJournalView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
                .tag(1)
            WalkView(/*cyclingStartTime: $cyclingStartTime, timeCycling: $timeCycling*/)
               // .environmentObject(petViewModel)
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Walk")
                }
                .tag(2)
            PersonView()
               // .environmentObject(petViewModel)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(.orangeColor)
            .onAppear() {
                UITabBar.appearance().barTintColor = .white
            }
    }
}

struct TopFrameView: Shape {
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 53.22, y: 4.36))
        for (to, controlPoint1, controlPoint2) in [(CGPoint(x: 60.83, y: 13.06), CGPoint(x: 57.76, y: 7.77), CGPoint(x: 60.14, y: 11.68)), (CGPoint(x: 68.43, y: 22.84), CGPoint(x: 63, y: 17.4), CGPoint(x: 65.05, y: 20.96)), (CGPoint(x: 75.16, y: 23.98), CGPoint(x: 70.49, y: 23.98), CGPoint(x: 75.16, y: 23.98))] {
            bezierPath.addCurve(to: to, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
        bezierPath.addLine(to: CGPoint(x: 0.84, y: 23.98))
        for (to, controlPoint1, controlPoint2) in [(CGPoint(x: 7.57, y: 22.84), CGPoint(x: 0.84, y: 23.98), CGPoint(x: 5.51, y: 23.98)), (CGPoint(x: 15.17, y: 13.06), CGPoint(x: 10.95, y: 20.96), CGPoint(x: 13, y: 17.4)), (CGPoint(x: 22.78, y: 4.36), CGPoint(x: 15.86, y: 11.68), CGPoint(x: 18.24, y: 7.77)), (CGPoint(x: 36.38, y: -0), CGPoint(x: 27.58, y: 0.77), CGPoint(x: 33.55, y: 0.1)), (CGPoint(x: 38, y: 0), CGPoint(x: 37.39, y: -0.04), CGPoint(x: 38, y: 0)), (CGPoint(x: 53.22, y: 4.36), CGPoint(x: 38, y: 0), CGPoint(x: 46.7, y: -0.53))] {
            bezierPath.addCurve(to: to, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
        bezierPath.close()
        return Path(bezierPath.cgPath)
    }
}
struct TabItemDescription {
    var imageName: String
    var title: String
    func iconView(_ foregroundColor: Color) -> some View { Image(systemName: imageName).font(.system(size: 24)).foregroundColor(foregroundColor) }
    func labelView(_ foregroundColor: Color) -> some View { Text(title).font(.system(size: 9, weight: .bold)).foregroundColor(foregroundColor) }
}
enum Defs {
    static let tabItems: [TabItemDescription] = [.init(imageName: "house.fill", title: "HOME"), .init(imageName: "list.dash", title: "LIST"), .init(imageName: "leaf.fill", title: "WALK"), .init(imageName: "person.fill", title: "PROFILE")]
    static let accentColor = Color.init(red: 82/255, green: 82/255, blue: 191/255)
    static let backgroundColor = Color(UIColor(red: 0.945, green: 0.969, blue: 0.984, alpha: 1.000))
    static let topFrameSize = CGSize(width: 75, height: 24)
    static let tabbarHeight = CGFloat(49)
    static let bottomSafeArea = CGFloat(40)
    static let iconCircleEdge = CGFloat(40)
    static let labelOffset = CGSize(width: 0, height: 32)
    static let bottomSafeAreaOffset = CGSize(width: 0, height: Defs.bottomSafeArea * 0.5)
}

/*struct ContentView: View {
    @State var selectedIndex = 0
   // @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack {
            
            Rectangle()
                   .fill(Color.purpleGradient)
                //.fill(Color.background)
                 .edgesIgnoringSafeArea(.all)
            
            switch selectedIndex {
            case 0:
               // CircleNavigation()
            MainPageCircle()
            case 1:
                PetJournalView()
                //Text("List")
            case 2:
               WalkView()
            case 3:
                PersonView()
            default:
                Text("default")
            }
            
            //Text("Hello, World!") // main contents example
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0){
                        //ForEach(0..<3) { (index) in
                        ForEach(0..<4) { (index) in
                            VStack(spacing: 0) {
                                Spacer()
                                Rectangle()
                                    .foregroundColor( .clear )
                                    .frame(width: Defs.iconCircleEdge, height: Defs.iconCircleEdge)
                                    .overlay(
                                        ZStack {
                                            Defs.tabItems[index].iconView(.white).opacity(self.selectedIndex == index ? 1.0 : 0.0)
                                            Defs.tabItems[index].iconView(Defs.accentColor).opacity(self.selectedIndex != index ? 1.0 : 0.0)
                                        }
                                    )
                                    .background(
                                        ZStack {
                                            Defs.tabItems[index].labelView(.black).opacity(self.selectedIndex == index ? 1.0 : 0.0)
                                            Defs.tabItems[index].labelView(.clear).opacity(self.selectedIndex != index ? 1.0 : 0.0)
                                        }.offset(Defs.labelOffset)
                                    )
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(height: self.selectedIndex == index ? 26 : 5)
                            }
                            .frame(width: proxy.size.width * 0.25)
                            //.frame(width: proxy.size.width * 0.333)
                            .contentShape( Rectangle() )
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7) ) { self.selectedIndex = index }
                            }
                        }
                    }
                    .background(
                        Rectangle()
                            .frame(height: Defs.topFrameSize.height + Defs.tabbarHeight + Defs.bottomSafeArea)
                            .overlay(
                                Circle()
                                    .foregroundColor(Defs.accentColor)
                                    .frame(width: Defs.iconCircleEdge, height: Defs.iconCircleEdge)
                                   // .offset(CGSize(width: CGFloat(self.selectedIndex - 1) * (proxy.size.width * 0.333), height: -29))
                                    .offset(CGSize(width: CGFloat(self.selectedIndex - 1) * (proxy.size.width * 0.25) - 47, height: -29))
                            )
                            .foregroundColor(.white)
                            .offset(Defs.bottomSafeAreaOffset)
                            .mask(
                                VStack(spacing: 0) {
                                    TopFrameView()
                                        .frame(width: Defs.topFrameSize.width, height: Defs.topFrameSize.height)
                                       // .offset(CGSize(width: CGFloat(self.selectedIndex - 1) * (proxy.size.width * 0.333), height: 0))
                                        .offset(CGSize(width: CGFloat(self.selectedIndex - 1) * (proxy.size.width * 0.25) - 47, height: 0))
                                    Rectangle()
                                        .frame(height: Defs.tabbarHeight + Defs.bottomSafeArea)
                                }.offset(Defs.bottomSafeAreaOffset)
                            )
                            .shadow(color: Color.black.opacity(0.3) , radius: 15, x: 0, y: 0)
                    )
                    .frame(height: Defs.topFrameSize.height + Defs.tabbarHeight)
                }
            }.ignoresSafeArea(edges: [.trailing, .leading])
            //.offset(y: -5)
           // .edgesIgnoringSafeArea(.all)
        }.background(Defs.backgroundColor)
        
    }
}
*/
