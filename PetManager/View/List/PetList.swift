//
//  PetList.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 02.09.2021.
//

import SwiftUI

struct PetList: View {
    //   @EnvironmentObject var petViewModel: PetViewModel
    @StateObject var petViewModel = PetViewModel()
    @State var showAddNewPet = false
    @State var showDeletionPopupForPet = false
    @State var showArchivePopupForPet = false
    
    @State var editMode: EditMode = .inactive
    
    @State var selectKeeper = Set<PetInfo>()
    var body: some View {
        NavigationView {
            
            List(selection: $selectKeeper) {
                Section {
                    ForEach(petViewModel.pets, id: \.self.id) {pet in
                    NavigationLink(destination: ActivityListView(activityListViewModel: ActivityListViewModel(petId: pet.id))) {
                        HStack {
                            Image(uiImage: pet.photo!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 5)
                            Spacer()
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(pet.name)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("Gender: \(pet.gender)")
                                    Spacer()
                                    if pet.neutred == true {
                                        Text("Neutred")
                                    } else {
                                        Text("Not neutred")
                                    }
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                HStack {
                                    Text("Birthday: ")
                                    Text(pet.date_birth, style: .date)
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                if pet.chip_id != "" {
                                    Text("Chip id: \(pet.chip_id)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                            }
                            .multilineTextAlignment(.leading)
                            Spacer(minLength: 0)
                        }
                        .padding()
                    }
                }
                .onDelete(perform: delete)
                }
              /*  Section {
                    HStack {
                        Button(action: {
                            showAddNewPet = true
                        }) {
                            HStack {
                                Image(systemName: "plus")
                            }
                           
                        }
                        .buttonStyle(GradientButtonStyle())
                        
                    Text("Add new pet")
                        .foregroundColor(.orangeColor)
                        .font(.body)
                }
                }*/
                
            }
            .navigationBarItems(trailing: HStack {
               // EditButton()
                editButton
              /*  if self.selectKeeper.count != 0 {
                                    Button("Archive") {
                                        for selection in selectKeeper {
                                            petViewModel.archivePetWithId(id: selection.id)
                                        }
                                       
                                        selectKeeper.removeAll()
                                        petViewModel.updateActivePets()
                                        showArchivePopupForPet = true
                                       
                                       // print("Sending selected... \(self.selectKeeper)")
                                    }
                                }*/
                
            })
            .environment(\.editMode, self.$editMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showAddNewPet = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(GradientButtonStyle())
                }
            }
            
            .navigationTitle("Your pets")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(InsetGroupedListStyle())
        }
        
        .onAppear() {
            petViewModel.updateActivePets()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .popup(isPresented: $showAddNewPet, type: .`default`, closeOnTap: false) {
            AddNewPet(showPopup: $showAddNewPet)
                .environmentObject(petViewModel)
                .onDisappear() {
                    petViewModel.updateActivePets()
                }
        }
        .popup(isPresented: $showDeletionPopupForPet, type: .`default`, closeOnTap: false) {
            DeletePopup(deletedObject: petViewModel.deletingIndex >= 0 && petViewModel.deletingIndex < petViewModel.pets.count  ? "\(petViewModel.pets[petViewModel.deletingIndex].name)" : "", showingPopup: $showDeletionPopupForPet, object: "Pet")
                .environmentObject(petViewModel)
            
            
        }
        
        .popup(isPresented: $showArchivePopupForPet, autohideIn: 1) {
            ArchivePopup()
                .environmentObject(petViewModel)
        }
        
        
        
    }
    
    private var editButton: some View {
            Button(action: {
               
                
                if editMode == .active {
                    if selectKeeper.count > 0 {
                        showArchivePopupForPet = true
                    }
                    for selection in selectKeeper {
                        petViewModel.archivePetWithId(id: selection.id)
                    }
                   
                    selectKeeper.removeAll()
                    petViewModel.updateActivePets()
                }
                
                self.editMode.toggle()
                self.selectKeeper = Set<PetInfo>()
                
            }) {
                Text(self.editMode.title)
            }
        }
    
    func delete(at offsets: IndexSet) {
        petViewModel.deletingIndex = offsets.first ?? 0
        showDeletionPopupForPet = true
    }
}


extension EditMode {
    var title: String {
        self == .active ? "Archive" : "Edit"
    }

    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}
