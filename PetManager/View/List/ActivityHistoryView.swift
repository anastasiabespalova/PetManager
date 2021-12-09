//
//  ActivityHistoryView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 03.09.2021.
//
import SwiftUI

struct ActivityHistoryView: View {

    @State var showingPopupUndetailed = false
    @State var showingPopupDetailedDescriptionPhoto = false
    @State var showingPopupForWalkDetailed = false
    @State var showingPopupForWeightDetailed = false
    @State var showDeletionPopup = false
    
    @StateObject var activityHistoryViewModel: ActivityHistoryViewModel
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    var body: some View {
        
        List {
            ForEach(activityHistoryViewModel.activityEntries_, id: \.self.id) {entry in
                NavigationLink(destination: ActivityEntryView(activityEntryViewModel: ActivityEntryViewModel(entry: entry))
                                .onDisappear() {
                                    activityHistoryViewModel.update()
                                }) {
                    if activityHistoryViewModel.activity.title != "walk" {
                        CommonActivityEntryPreview(activityHistoryViewModel: activityHistoryViewModel, entry: entry)
                    } else {
                        WalkActivityEntryPreview(activityHistoryViewModel: activityHistoryViewModel, entry: entry)
                    }
                
            }
            }
            .onDelete(perform: delete)
           
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                        impactMed.impactOccurred()
                        selectPopupForActivity(activity: activityHistoryViewModel.activity, isTapLong: true)
                }) {
                    Image(systemName: "plus")
                        
                }
                .buttonStyle(GradientButtonStyle())
            }
        }
        .navigationTitle("\(activityHistoryViewModel.activity.title.capitalizingFirstLetter()) entries")
        .navigationBarTitleDisplayMode(.large)
        .listStyle(InsetGroupedListStyle())
        
        
        
        .popup(isPresented: $showingPopupDetailedDescriptionPhoto, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopupForActivityHistoryView(showingPopup: $showingPopupDetailedDescriptionPhoto, petId: activityHistoryViewModel.pet.id,
                                                                activity: activityHistoryViewModel.activity)
               .environmentObject(activityHistoryViewModel)
        }
       .popup(isPresented: $showingPopupUndetailed, autohideIn: 1) {
           UndetailedPopup(activity: activityHistoryViewModel.activity)
       }
       
       //Weight popups
       .popup(isPresented: $showingPopupForWeightDetailed, type: .`default`, closeOnTap: false) {
           DetailedWeightPopup(showingPopupForWeightDetailed: $showingPopupForWeightDetailed)
       }
       
       .popup(isPresented: $showingPopupForWalkDetailed, type: .`default`, closeOnTap: false) {
           DetailedWalkPopupWithoutModelForActivityHistoryView(petId: activityHistoryViewModel.pet.id, showingPopup: $showingPopupForWalkDetailed)
               .environmentObject(activityHistoryViewModel)
       }
        
        .popup(isPresented: $showDeletionPopup, type: .`default`, closeOnTap: false) {
            DeletePopupForActivityEntry(showingPopup: $showDeletionPopup)
                .environmentObject(activityHistoryViewModel)
                
         }
        
        
    }
    
    func delete(at offsets: IndexSet) {
        activityHistoryViewModel.deletingIndex = offsets.first!
        showDeletionPopup = true
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

struct CommonActivityEntryPreview:  View {
    @StateObject var activityHistoryViewModel: ActivityHistoryViewModel
    @State var entry: ActivityEntryInfo_
    var body: some View {
        HStack{
            Image(activityHistoryViewModel.activity.title)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(entry.timestamp, style: .date)
                        .fontWeight(.bold)
                    Text(entry.timestamp, style: .time)
                        .fontWeight(.bold)
                }
                
                if entry.description != "" {
                    Text(entry.description)
                        .font(.callout)
                }
                
                if entry.media_path != "" {
                    Text("Has media files")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
}

struct WalkActivityEntryPreview:  View {
    @StateObject var activityHistoryViewModel: ActivityHistoryViewModel
    @State var entry: ActivityEntryInfo_
    var body: some View {
        HStack{
            Image(activityHistoryViewModel.activity.title)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(entry.timestamp, style: .date)
                        .fontWeight(.bold)
                    Text(entry.timestamp, style: .time)
                        .fontWeight(.bold)
                }
                
                if entry.description != "" {
                    Text(entry.description)
                        .font(.callout)
                }
                
              /*  if entry.withBikeRide != nil {
                    MapSnapshotView(location: calculateCenter(latitudes: entry.withBikeRide!.cyclingLatitudes, longitudes: entry.withBikeRide!.cyclingLongitudes),
                                    span: calculateSpan(latitudes: entry.withBikeRide!.cyclingLatitudes, longitudes: entry.withBikeRide!.cyclingLongitudes),
                                    coordinates: setupCoordinates(latitudes: entry.withBikeRide!.cyclingLatitudes, longitudes: entry.withBikeRide!.cyclingLongitudes))
                        .frame(width: 100, height: 100)
                }*/
                HStack {
                    
                    if entry.withBikeRide != nil {
                        Text("Has walk track")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    if entry.media_path != "" {
                        Text("Has media files")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
               
                
            }
        }
    }
}
