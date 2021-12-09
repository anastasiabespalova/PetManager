//
//  ActivityListView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 03.09.2021.
//

import SwiftUI
import Introspect

struct ActivityListView: View {
    @State var editMode: EditMode = .inactive
    @State var selectKeeper = Set<Activity>()
    @StateObject var activityListViewModel: ActivityListViewModel
    @State var showDeletionPopup = false
    @State var selectActivitiesPopup = false
    @State var isEditing = false
    @State private var lastHostingView: UIView!
    var body: some View {
        List(selection: $selectKeeper) {
            Section {
            ForEach(activityListViewModel.petInfo.active_activities_array, id: \.self) {activity in
                NavigationLink(destination: ActivityHistoryView(activityHistoryViewModel: ActivityHistoryViewModel(pet: activityListViewModel.petInfo, activity: activity))) {
                    HStack{
                        Image(activity.title)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 50)
                        //Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text(activity.title.capitalizingFirstLetter())
                                .fontWeight(.bold)
                            Text(activity.description)
                                .font(.caption)
                        }
                        
                        
                    }
                }
            }
            .onDelete(perform: delete)
            }
            if editMode == .active {
                Section{
                    HStack {
                        Button(action: {
                            selectActivitiesPopup = true
                        }) {
                            HStack {
                                Image(systemName: "plus")
                            }
                           
                        }
                        .buttonStyle(GradientButtonStyle())
                        
                    Text("Add new activity for pet")
                        .foregroundColor(.orangeColor)
                        .font(.body)
                }
                    }

            }
                       
        }
        .environment(\.editMode, self.$editMode)
        .navigationBarItems(trailing:
              editButton
        )
        .navigationTitle("\(activityListViewModel.petInfo.name)'s activities")
        .navigationBarTitleDisplayMode(.large)

        .listStyle(InsetGroupedListStyle())
        
        
        
    
        .popup(isPresented: $showDeletionPopup, type: .`default`, closeOnTap: false) {
            DeletePopupForActivity(deletedObject: activityListViewModel.deletingIndex >= 0 && activityListViewModel.deletingIndex < activityListViewModel.petInfo.active_activities_array.count  ? "\(activityListViewModel.petInfo.active_activities_array[activityListViewModel.deletingIndex].title)" : "", showingPopup: $showDeletionPopup, object: "Activity")
                .environmentObject(activityListViewModel)
            
            
        }
        
        .popup(isPresented: $selectActivitiesPopup, type: .`default`, closeOnTap: false) {
            AddNewActivityPopup(showPopup: $selectActivitiesPopup, activityListViewModel: activityListViewModel)
               // .environmentObject(activityListViewModel)
            
        }
        
        
    }
    
    
    func delete(at offsets: IndexSet) {
        activityListViewModel.deletingIndex = offsets.first ?? 0
        activityListViewModel.deletingActivityTitle = activityListViewModel.petInfo.active_activities_array[activityListViewModel.deletingIndex].title
        showDeletionPopup = true
    }
    
    
    
    private var editButton: some View {
        Button(action: {
            if editMode == .active {
                for selection in selectKeeper {
                    activityListViewModel.archiveActivityWithId(activity: selection)
                 }
                
                selectKeeper.removeAll()
                activityListViewModel.update()
                
            }
            self.editMode.toggle()
            self.selectKeeper = Set<Activity>()
            
            
        }) {
            Text(self.editMode.title)
        }
    }
}

