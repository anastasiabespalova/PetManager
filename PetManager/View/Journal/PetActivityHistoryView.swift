//
//  PetActivityHistoryView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI



struct PetActivityHistoryView: View {
    
    
    @Binding var activityEntryInfo_: ActivityEntryInfo_
    @State var showingPopupUndetailed = false
    @State var showingPopupDetailedDescriptionPhoto = false /*{
        didSet {
            activityHistoryViewModel.update()
        }
    }*/
    
    @State var showingPopupForWalkDetailed = false
    @State var showingPopupForWeightDetailed = false
    
    @Binding var selectedActivity: Activity
    
    @Binding var showActivities: Bool
    @Binding var showActivityHistory: Bool
    @Binding var showActivityHistoryEntry: Bool
    @Binding var activityEntryIndex: Int
    
    @State var showDeletionPopup = false
    @State var showArchivePopup = false
    
    @EnvironmentObject var activityHistoryViewModel: ActivityHistoryViewModel
    // @EnvironmentObject var petViewModel: PetViewModel
    
    @State var size = "Medium"
    @GestureState var isDragging = false
    
    @Binding var forward: Bool
    @State var petId: Int
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    @State var activityTestData = ActivityTestData()
    
    @State var viewId = UUID().uuidString
    var body: some View {
        ZStack {
            
            VStack {
                
                /*NavigationActivityHistoryHstack(showActivities: $showActivities,
                 showActivityHistory: $showActivityHistory,
                 activity: activityHistoryViewModel.activity,
                 forward: $forward)*/
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 115)
                        .foregroundColor(Color.white)
                        .opacity(0.2)
                    
                    
                    HStack {
                        Button(action: {
                            forward = false
                            showActivities = true
                            showActivityHistory = false
                            
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Image(activityHistoryViewModel.activity.title)
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(height: 50)
                        Spacer()
                            .frame(width: 30)
                        Text("\(activityHistoryViewModel.activity.title.capitalizingFirstLetter()) history")
                            .font(.largeTitle)
                            // .fontWeight(.bold)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    impactMed.impactOccurred()
                                    selectPopupForActivity(activity: activityHistoryViewModel.activity, isTapLong: false)
                                    
                                    activityHistoryViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(activity_title: selectedActivity.title, description: "", petId: petId))
                                    for activityEntry in activityHistoryViewModel.getActivityEntriesForPet(petId: petId, activityTitle: selectedActivity.title) {
                                        print(activityEntry.timestamp)
                                    }
                                    
                                    print(petId)
                                }
                                .onLongPressGesture {
                                    impactMed.impactOccurred()
                                    selectPopupForActivity(activity: activityHistoryViewModel.activity, isTapLong: true)
                                }
                        }
                        .buttonStyle(GradientButtonStyle())
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                .ignoresSafeArea()
                .shadow(radius: 10)
                .frame(height: 60)
                
                ScrollView {
                    VStack {
                        
                        if selectedActivity.title == "walk" {
                            
                            ZStack {
                                Color.red
                                    .cornerRadius(20)
                                
                                Color.orange
                                    .cornerRadius(20)
                                    .padding(.trailing, 65)
                                
                                // Buttons...
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showArchivePopup = true
                                        
                                    }) {
                                        Image(systemName: "archivebox")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 65)
                                        
                                    }
                                    
                                    Button(action: {
                                        showDeletionPopup = true
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 65)
                                        
                                    }
                                }
                                
                                
                                WalkActivityTracker(activityTestData: activityTestData)
                                    // drag gesture...
                                    .offset(x:  activityTestData.offset)
                                    .gesture(DragGesture()
                                                .updating($isDragging, body: {(value, state, _) in
                                                    state = true
                                                    onChanged(value: value, index: -1)
                                                })
                                                .onEnded({ (value) in onEnd(value: value, index: -1)
                                                    
                                                }))
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            
                        }
                        
                        ForEach(activityHistoryViewModel.activityEntries_.indices, id: \.self){index in
                            // Card View...
                            ZStack {
                                Color.red
                                    .cornerRadius(20)
                                
                                Color.orange
                                    .cornerRadius(20)
                                    .padding(.trailing, 65)
                                
                                // Buttons...
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showArchivePopup = true
                                        activityHistoryViewModel.archivingIndex = index
                                        
                                        if activityHistoryViewModel.archivingIndex >= 0 {
                                            activityHistoryViewModel.archiveActivityEntry(id: activityHistoryViewModel.archivingIndex)
                                            activityHistoryViewModel.archivingIndex = -1
                                        }
                                    }) {
                                        Image(systemName: "archivebox")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 65)
                                        
                                    }
                                    
                                    Button(action: {
                                        showDeletionPopup = true
                                        activityHistoryViewModel.deletingIndex = index
                                        
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 65)
                                        
                                    }
                                }
                                
                                
                                ActivityHistoryCardView(activityEntry: activityHistoryViewModel.activityEntries_[index])
                                    // drag gesture...
                                    .offset(x:  activityHistoryViewModel.activityEntries_[index].offset)
                                    .gesture(DragGesture()
                                                .updating($isDragging, body: {(value, state, _) in
                                                    state = true
                                                    onChanged(value: value, index: index)
                                                })
                                                .onEnded({ (value) in onEnd(value: value, index: index )
                                                    
                                                }))
                            }
                            .onTapGesture {
                                forward = true
                                activityEntryIndex = index
                                showActivityHistoryEntry = true
                                showActivityHistory = false
                                activityEntryInfo_ = activityHistoryViewModel.activityEntries_[activityEntryIndex]
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 100)
                }
            }
            // .transition(.asymmetric(insertion: .move(edge: forward ? .trailing : .leading), removal: .move(edge: forward ? .leading : .trailing)))
        } .id(viewId)
        // TODO: all possible popups for propeties
        
        .popup(isPresented: $showDeletionPopup, type: .`default`, closeOnTap: false) {
            DeletePopupForActivityEntry(showingPopup: $showDeletionPopup)
                .environmentObject(activityHistoryViewModel)
         }
        
        .popup(isPresented: $showArchivePopup, autohideIn: 1) {
            ArchivePopup()
        }
        
        
         .popup(isPresented: $showingPopupDetailedDescriptionPhoto, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopupForActivityHistoryView(showingPopup: $showingPopupDetailedDescriptionPhoto, petId: petId,
         activity: selectedActivity)
                .environmentObject(activityHistoryViewModel)
         }
        .popup(isPresented: $showingPopupUndetailed, autohideIn: 1) {
            UndetailedPopup(activity: selectedActivity)
        }
        
        //Weight popups
        .popup(isPresented: $showingPopupForWeightDetailed, type: .`default`, closeOnTap: false) {
            DetailedWeightPopup(showingPopupForWeightDetailed: $showingPopupForWeightDetailed)
        }
        
        .popup(isPresented: $showingPopupForWalkDetailed, type: .`default`, closeOnTap: false) {
            DetailedWalkPopupWithoutModelForActivityHistoryView(petId: petId, showingPopup: $showingPopupForWalkDetailed)
                .environmentObject(activityHistoryViewModel)
        }
        
    }

    
    func addCart(index: Int) {

        // Closing after added...
        withAnimation {
            activityHistoryViewModel.activityEntries_[index].offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int){
        if value.translation.width < 0 && isDragging {
            if index == -1 {
                activityTestData.offset = value.translation.width
            } else {
                activityHistoryViewModel.activityEntries_[index].offset = value.translation.width
            }
            
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int){
        
        withAnimation{
            if -value.translation.width >= 100 {
                if index == -1 {
                    activityTestData.offset = -130
                } else {
                    activityHistoryViewModel.activityEntries_[index].offset = -130
                }
                
            } else {
                if index == -1 {
                    activityTestData.offset = 0
                   
                } else {
                    activityHistoryViewModel.activityEntries_[index].offset = 0
                }
                
            }
        }
    }
    
    func selectPopupForActivity(activity: Activity?, isTapLong: Bool) {
        guard let activity = activity else {
            return
        }
        
        switch activity.title {
        case "food", "claws", "cage", "training", "parasites", "pee", "pills", "poo", "vaccine", "vomit", "washing", "water":
            if activity.detailedView || isTapLong == true{
                showingPopupDetailedDescriptionPhoto = true
            } else {
                showingPopupUndetailed = true
            }
        case "walk":
            if activity.detailedView || isTapLong == true{
                showingPopupForWalkDetailed = true
            } else {
                showingPopupUndetailed = true
            }
        case "weight":
            showingPopupForWeightDetailed = true
        default:
            showingPopupUndetailed = true
        }
    }
    
    
}

struct WalkActivityTracker: View {
    @State var selectedIndex: Int = 0
    
    @State var activityTestData: ActivityTestData
    
    var body: some View {
        //HStack{
            VStack(spacing: 16) {
                // Stats
                ActivityHistoryText(logs: activityTestData.testData, selectedIndex: $selectedIndex)
                
                // Graph
                ActivityGraph(logs: activityTestData.testData, selectedIndex: $selectedIndex)
                
            }.padding()
           // Spacer(minLength: 0)
      //  }
        .frame(height: 300)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
      //  .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
        
        
    }
}

struct ActivityHistoryCardView: View {
    
    var activityEntry: ActivityEntryInfo_
    
    var body: some View {
        HStack{
           // Image(activityEntry.activity.title)
           /* Image(activityEntry.activity_title)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)*/
               // .frame(width: UIScreen.main.bounds.width / 3.2, height: 80)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                   // Text(activityEntry.activity.title.capitalizingFirstLetter())
                   /* Text(activityEntry.activity_title.capitalizingFirstLetter())
                       // .fontWeight(.heavy)
                        .foregroundColor(.black) */
                    // Text("date: \(activityEntry.date)")
                    
                    HStack {
                        HStack {
                            Text(activityEntry.timestamp, style: .date)
                            Text(activityEntry.timestamp, style: .time)
                        }
                        Spacer()
                        if activityEntry.media_path != "" {
                            Text("Has media")
                                .foregroundColor(.gray)
                        }
                        
                        
                    }
                    .font(.caption)
                    //  .foregroundColor(.gray)
                    
                    //Text("value: \(activityEntry.value)")
                    if activityEntry.description != "" {
                        Text("\(activityEntry.description)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    
                    
                    /*Text("Some text")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)*/
            }
           
            }
            Spacer(minLength: 0)
        }
        .frame(height: 40)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
      //  .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
        
        
    }
}


/*
struct NavigationActivityHistoryHstack: View {
    @Binding var showActivities: Bool
    @Binding var showActivityHistory: Bool
    
    @State var activity: Activity
    
    @Binding var forward: Bool
    

    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 115)
                .foregroundColor(Color.white)
                .opacity(0.2)
                
                
            HStack {
                Button(action: {
                    forward = false
                    showActivities = true
                    showActivityHistory = false
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(width: 30)
                Text("\(activity.title.capitalizingFirstLetter()) history")
                    .font(.largeTitle)
                   // .fontWeight(.bold)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {
                    selectPopupForActivity(activity: activity, isTapLong: true)
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .buttonStyle(GradientButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .ignoresSafeArea()
        .shadow(radius: 10)
        .frame(height: 60)
        

        
    }
    
    
  
}
*/
