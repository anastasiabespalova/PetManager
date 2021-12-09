//
//  PetJournalView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 23.08.2021.
//

import SwiftUI

struct PetJournalView: View {
    
    @ObservedObject var petViewModel = PetViewModel()
    
    
    // hiding tabBar...
    init() {
        UITabBar.appearance().isHidden = true
    }

    
    @State var petIndex: Int = -1
    @State var selectedActivity: Activity = Activity(title: "poo")
    @State var activityEntryIndex: Int = 0
    
   // @State var push = false
    
    @State var activityEntryInfo_ = ActivityEntryInfo_()
    @State var showPets = true
    @State var showActivities = false
    @State var showActivityHistory = false
    @State var showActivityHistoryEntry = false
    
    @State var forward: Bool = true
    
    

          var body: some View {
              ZStack {
                //Show list with pets
                    if showPets {
                        Home(showPets: $showPets,
                             showActivities: $showActivities,
                             petIndex: $petIndex,
                             forward: $forward)
                        .environmentObject(petViewModel)
                        .zIndex(0)
                    }
                
                //Show list with pet's activities

                   if showActivities {
                        PetActivitiesView(showPets: $showPets,
                                          showActivities: $showActivities,
                                          showActivityHistory: $showActivityHistory,
                                          petIndex: $petIndex,
                                          selectedActivity: $selectedActivity,
                                          forward: $forward)
                            .environmentObject(petViewModel)
                            .zIndex(1)
                                
                        }
                
            //Show list with activity history
                   if showActivityHistory {
                        PetActivityHistoryView(
                            activityEntryInfo_: $activityEntryInfo_, selectedActivity: $selectedActivity, showActivities: $showActivities,
                            showActivityHistory: $showActivityHistory,
                            showActivityHistoryEntry: $showActivityHistoryEntry,
                            activityEntryIndex: $activityEntryIndex,
                            forward: $forward, petId: petViewModel.pets[petIndex].id)
                            .environmentObject(ActivityHistoryViewModel(pet: petViewModel.pets[petIndex],
                                                                        activity: selectedActivity))
                            .zIndex(2)
                    }
                
                //Show detailed activity entry
                if showActivityHistoryEntry {
                    PetActivityEntryView(
                        activityEntryInfo_: $activityEntryInfo_,
                        showActivityHistory: $showActivityHistory,
                        showActivityHistoryEntry: $showActivityHistoryEntry,
                        activityEntryIndex: $activityEntryIndex,
                        forward: $forward
                        )
                        .environmentObject(ActivityHistoryViewModel(pet: petViewModel.pets[petIndex], activity: selectedActivity))
                        .zIndex(3)
                    .onDisappear() {
                        petViewModel.addActivityEntry(activityEntry: activityEntryInfo_)
                    }
                }
                
                  
              }
              //.transition(.slide)
              .animation(.spring(blendDuration: 0.5))
          }
        
}


struct Home: View {
    
    @EnvironmentObject var petViewModel: PetViewModel
    
    @State var size = "Medium"
    @GestureState var isDragging = false

    @Binding var showPets: Bool
    @Binding var showActivities: Bool
    
    @Binding var petIndex: Int
    @Binding var forward: Bool
    
    
    @State var showAddNewPet = false
    @State var showDeletionPopupForPet = false
    @State var showArchivePopupForPet = false
    
    
    var body: some View {
        
            VStack {
               
                NavigationHstack(showAddNewPet: $showAddNewPet)
                ScrollView {
                    VStack(alignment: .leading, spacing: 0){
                        
                        ForEach(petViewModel.pets.indices, id: \.self) {index in
                            if index < petViewModel.pets.count {
                                PetItem(showArchivePopupForPet: $showArchivePopupForPet, showDeletionPopupForPet: $showDeletionPopupForPet, index: index, forward: $forward, showActivities: $showActivities, showPets: $showPets, petIndex: $petIndex)
                            }
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 100)
                }
            }
          //  .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            .popup(isPresented: $showDeletionPopupForPet, type: .`default`, closeOnTap: false) {
                DeletePopup(deletedObject: petIndex >= 0 && petIndex < petViewModel.pets.count  ? "\(petViewModel.pets[petIndex].name)" : "", showingPopup: $showDeletionPopupForPet, object: "Pet")
                        .environmentObject(petViewModel)
               
                
            }
        
            .popup(isPresented: $showArchivePopupForPet, autohideIn: 1) {
                ArchivePopup()
                    .environmentObject(petViewModel)
            }
        
            .popup(isPresented: $showAddNewPet, type: .`default`, closeOnTap: false) {
                
                AddNewPet(showPopup: $showAddNewPet)
                    .environmentObject(petViewModel)
            }
        
    }
    

    func addCart(index: Int) {

        // Closing after added...
        withAnimation {
            petViewModel.pets[index].offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int){
        if value.translation.width < 0 && isDragging {
            petViewModel.pets[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int){
        withAnimation{
            if -value.translation.width >= 100 {
                petViewModel.pets[index].offset = -130
            } else {
                petViewModel.pets[index].offset = 0
            }
        }
    }
    
}

struct PetItem: View {
    
    @Binding var showArchivePopupForPet: Bool
    @Binding var showDeletionPopupForPet: Bool
    @GestureState var isDragging: Bool = false
    
    @State var index: Int
    
    @Binding var forward: Bool
    @Binding var showActivities: Bool
    @Binding var showPets: Bool
    @Binding var petIndex: Int
    
    @EnvironmentObject var petViewModel: PetViewModel
    
    
    @ViewBuilder var body: some View {
        // Card View...
        VStack{
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
                        showArchivePopupForPet = true
                        petViewModel.archivingIndex = index
                        
                        if petViewModel.archivingIndex >= 0 {
                            petViewModel.archivePetWithId(id: petViewModel.pets[petViewModel.archivingIndex].id)
                            petViewModel.archivingIndex = -1
                        }
                    }) {
                        Image(systemName: "archivebox")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 65)
                        
                    }
                    
                    Button(action: {
                        showDeletionPopupForPet = true
                        petViewModel.deletingIndex = index
                       // petIndex = index
                    }) {
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 65)
                        
                    }
                }
                
                if index < petViewModel.pets.count {
                PetCardView(pet: petViewModel.pets[index])
                    // drag gesture...
                    .offset(x: petViewModel.pets[index].offset)
                    .gesture(DragGesture()
                                .updating($isDragging, body: {(value, state, _) in
                                    state = true
                                    onChanged(value: value, index: index)
                                })
                                .onEnded({ (value) in onEnd(value: value, index: index )
                                    
                                }))
                }
            }
            
            .onTapGesture {
                forward = true
                showActivities = true
                showPets = false
                petIndex = index
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    func addCart(index: Int) {

        // Closing after added...
        withAnimation {
            petViewModel.pets[index].offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int){
        if value.translation.width < 0 && isDragging {
            petViewModel.pets[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int){
        withAnimation{
            if -value.translation.width >= 100 {
                petViewModel.pets[index].offset = -130
            } else {
                petViewModel.pets[index].offset = 0
            }
        }
    }
}

struct PetCardView: View {
    
    var pet: PetInfo
    
    var body: some View {
        HStack{
           /* Image(pet.defaultImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 3.2, height: 100)*/
            
            Image(uiImage: pet.photo!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            
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
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
      //  .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
        
    }
}

struct NavigationHstack: View {
    @Binding var showAddNewPet: Bool
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 115)
                //.frame(height: 100)
                .foregroundColor(Color.white)
                .opacity(0.2)
                
                
            HStack {
                /*Button(action: {}) {
                    Image(systemName: "")
                        .font(.title)
                        .foregroundColor(.white)
                }*/
                Spacer()
                    .frame(width: 30)
                Text("My pets")
                    .font(.title2)
                    .fontWeight(.bold)
                   // .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {
                    showAddNewPet = true
                }) {
                    Image(systemName: "plus")
                      //  .font(.title)
                        .foregroundColor(.white)
                }
                .buttonStyle(GradientButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top)
           // .padding(.bottom, 10)
        }
        .ignoresSafeArea()
        //.background(BackgroundBlurView())
       // .backgroundColor = .clear
        .shadow(radius: 10)
        .frame(height: 60)
        //.frame(height: 48)
       // .background(Color.clear)
        //.opacity(0.3)
        
    }
}

