//
//  ArchiveView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 27.08.2021.
//

import SwiftUI

struct ArchiveView: View {
    @EnvironmentObject var petViewModel: PetViewModel
    @ObservedObject var archiveViewModel = ArchiveViewModel()
    //@ObservedObject var petViewModel = PetViewModel()
    @State var selectedItems = Set<Int>()
    @State var isEditing = false
    
    var body: some View {

     List(archiveViewModel.archivedPets.indices, id: \.self, selection: $selectedItems) { index in
            //ForEach(petViewModel.pets.indices, id: \.self) { index in
                NavigationLink(destination: ArchivedPetActivities(pet: $archiveViewModel.archivedPets[index])
                                .environmentObject(archiveViewModel).onAppear {
                                    archiveViewModel.petId = archiveViewModel.archivedPets[index].id
                                    archiveViewModel.getActivitiesWithArchivedAttributes()
                                }) {
                    HStack{
                       /* Image(petViewModel.archivedPets[index].defaultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 3.2, height: 70)*/
                        Image(uiImage: archiveViewModel.archivedPets[index].photo!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            .shadow(radius: 5)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(archiveViewModel.archivedPets[index].name)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            HStack {
                                Text("Gender: \(archiveViewModel.archivedPets[index].gender)")
                                Spacer()
                                if archiveViewModel.archivedPets[index].neutred == true {
                                    Text("Neutred")
                                } else {
                                    Text("Not neutred")
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Text("Birthday: ")
                                Text(archiveViewModel.archivedPets[index].date_birth, style: .date)
                            }
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            if archiveViewModel.archivedPets[index].chip_id != "" {
                                Text("Chip id: \(archiveViewModel.archivedPets[index].chip_id)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
 
                        }
                        Spacer(minLength: 0)
                    }
                    
                    .padding(5)
                }
                
                
            //}
        }
     
        .navigationBarItems(trailing: HStack {
                        if self.selectedItems.count != 0 {
                            Button("Unarchive") {
                                print("Sending selected... \(self.selectedItems)")
                                petViewModel.unarchiveSelected(selectedItems: selectedItems)
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


struct ArchivedPetActivities: View {
    @Binding var pet: PetInfo
  //  @State var selectedItems = Set<Int>()
    @State var selectedItems = Set<Activity>()
    @EnvironmentObject var archiveViewModel: ArchiveViewModel
    
    /*  init(pet: Binding<PetInfo>) {
        self._pet = pet
        archiveViewModel.petId = self.pet.id
        archiveViewModel.getActivitiesWithArchivedAttributes()
    }*/
    var body: some View {
        Section {
           // List(archiveViewModel.archivedActivitiesForPet.indices, id: \.self, selection: $selectedItems) { index in
            List(archiveViewModel.archivedActivitiesForPet, id: \.self, selection: $selectedItems) { activity in
                
                NavigationLink(destination: ArchiveActivityEntries().environmentObject(ArchiveEntriesViewModel(petId: pet.id, activityTitle: activity.title))/*.onAppear{
                    print("on Appear")
                    archiveViewModel.petId = pet.id
                    archiveViewModel.getArchivedActivityEntries()
                }*/) {
                    HStack{
                       // Image(archiveViewModel.archivedActivitiesForPet[index].title)
                        Image(activity.title)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 3.2, height: 40)
                        VStack {
                            //Text(archiveViewModel.archivedActivitiesForPet[index].title.capitalizingFirstLetter())
                            Text(activity.title.capitalizingFirstLetter())
                           // Text(archiveViewModel.archivedActivitiesForPet[index].description)
                            Text(activity.description)
                                .font(.caption)
                        }
                        
                        
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
             .navigationBarItems(trailing: HStack {
                if self.selectedItems.count != 0 {
                    Button("Unarchive") {
                        for item in self.selectedItems {
                            archiveViewModel.unarchiveActivity(petId: pet.id, activityTitle: //archiveViewModel.archivedActivitiesForPet[item].title)
                                                                item.title)
                        }
                        print("Sending selected... \(self.selectedItems)")
                        self.selectedItems.removeAll()
                        archiveViewModel.getArchivedAttributesForPet(petId: pet.id)
                    }
                }
                if self.selectedItems.count == 0 {
                    EditButton()}
            })
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Activities list", displayMode: .inline)
        }

        
        
    }
    
}

struct ArchiveActivityEntries:  View {
    @EnvironmentObject var archiveEntriesViewModel: ArchiveEntriesViewModel
   // @EnvironmentObject var archiveViewModel: ArchiveViewModel
    //@EnvironmentObject var activityHistoryViewModel: ActivityHistoryViewModel
    @State var selectedItems = Set<Int>()
    
    var body: some View {
        List(archiveEntriesViewModel.archivedActivityEntriesForPetAndActivity.indices, id: \.self, selection: $selectedItems) { index in
            
            NavigationLink(destination: ActivityEntryViewFromList(activityEntry: archiveEntriesViewModel.archivedActivityEntriesForPetAndActivity[index])) {
                HStack{
                    Image(archiveEntriesViewModel.archivedActivityEntriesForPetAndActivity[index].activity_title)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 3.2, height: 40)
                    VStack {
                        Text(archiveEntriesViewModel.archivedActivityEntriesForPetAndActivity[index].activity_title.capitalizingFirstLetter())
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Text("date: \(archiveEntriesViewModel.archivedActivityEntriesForPetAndActivity[index].timestamp)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("value: \(archiveEntriesViewModel.archivedActivityEntriesForPetAndActivity[index].description)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    
                }
            }
            
        }
        .navigationBarItems(trailing: HStack {
            if self.selectedItems.count != 0 {
                Button("Unarchive") {
                    for item in self.selectedItems {
                        archiveEntriesViewModel.unarchivingIndex = item
                        archiveEntriesViewModel.unarchiveActivityEntry()
                    }
                    print("Sending selected... \(self.selectedItems)")
                    self.selectedItems.removeAll()
                }
            }
            if self.selectedItems.count == 0 {
                EditButton()}
        })
        
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Activity entries list", displayMode: .inline)
    }
}


struct ActivityEntryViewFromList: View {
    
    let activityEntry: ActivityEntryInfo_
    var body: some View {
        Text("ActivityEntryViewFromList for \(activityEntry.timestamp)")
    }
}
