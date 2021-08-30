//
//  ArchiveView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 27.08.2021.
//

import SwiftUI

struct ArchiveView: View {
    @ObservedObject var petViewModel = PetViewModel()
    @State var selectedItems = Set<Int>()
    
    var body: some View {
        
        List(petViewModel.pets.indices, id: \.self, selection: $selectedItems) { index in
            //ForEach(petViewModel.pets.indices, id: \.self) { index in
                NavigationLink(destination: ArchivedActivities(pet: $petViewModel.pets[index])) {
                    HStack{
                        Image(petViewModel.pets[index].defaultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 3.2, height: 70)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(petViewModel.pets[index].name)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            Text("Here you can place description of a pet")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Some text")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                        }
                        Spacer(minLength: 0)
                    }
                }
                
            //}
        }
        .navigationBarItems(trailing: HStack {
                        if self.selectedItems.count != 0 {
                            Button("Unarchive") {
                                print("Sending selected... \(self.selectedItems)")
                                self.selectedItems.removeAll()
                            }
                        }
            if self.selectedItems.count == 0 {
                EditButton()}
                    })
       
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Pets list", displayMode: .inline)
         
        
    }

}


struct ArchivedActivities: View {
    @Binding var pet: PetInfo
    @State var selectedItems = Set<Int>()
    
    var body: some View {
        
        List(pet.archived_activities_array.indices, id: \.self, selection: $selectedItems) { index in
            
            NavigationLink(destination: ArchiveActivityEntries().environmentObject(ActivityHistoryViewModel(pet: pet, activity: pet.archived_activities_array[index]))) {
                HStack{
                    Image(pet.archived_activities_array[index].title)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 3.2, height: 40)
                    VStack {
                        Text(pet.archived_activities_array[index].title.capitalizingFirstLetter())
                        Text(pet.archived_activities_array[index].description)
                            .font(.caption)
                    }
                    
                    
                }
            }
            
        }
        .navigationBarItems(trailing: HStack {
            if self.selectedItems.count != 0 {
                Button("Unarchive") {
                    print("Sending selected... \(self.selectedItems)")
                    self.selectedItems.removeAll()
                }
            }
            if self.selectedItems.count == 0 {
                EditButton()}
        })
        
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Activities list", displayMode: .inline)
        
        
    }
    
}

struct ArchiveActivityEntries:  View {
    
    
    @EnvironmentObject var activityHistoryViewModel: ActivityHistoryViewModel
    @State var selectedItems = Set<Int>()
    
    var body: some View {
        List(activityHistoryViewModel.activityEntries.indices, id: \.self, selection: $selectedItems) { index in
            
            NavigationLink(destination: ActivityEntryViewFromList(activityEntry: activityHistoryViewModel.activityEntries[index])) {
                HStack{
                    Image(activityHistoryViewModel.activity.title)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 3.2, height: 40)
                    VStack {
                        Text(activityHistoryViewModel.activity.title.capitalizingFirstLetter())
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Text("date: \(activityHistoryViewModel.activityEntries[index].date)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("value: \(activityHistoryViewModel.activityEntries[index].value)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    
                }
            }
            
        }
        .navigationBarItems(trailing: HStack {
            if self.selectedItems.count != 0 {
                Button("Unarchive") {
                    print("Sending selected... \(self.selectedItems)")
                    self.selectedItems.removeAll()
                }
            }
            if self.selectedItems.count == 0 {
                EditButton()}
        })
        
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Activities list", displayMode: .inline)
    }
}


struct ActivityEntryViewFromList: View {
    
    let activityEntry: ActivityEntry
    var body: some View {
        Text("ActivityEntryViewFromList for \(activityEntry.date)")
    }
}
