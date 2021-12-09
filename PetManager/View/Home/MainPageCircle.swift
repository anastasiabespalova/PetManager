//
//  MainPageCircle.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 22.08.2021.
//

import SwiftUI
import CoreData


struct MainPageCircle: View {
     @StateObject var petViewModel = PetViewModel()
     @State private var currentTab = 0
   // @EnvironmentObject var petViewModel: PetViewModel
    @State private var selectedTab = 0
    
    var body: some View {
       // VStack {
           // ZStack {
                TabView(selection: $selectedTab.animation()) {
                    ForEach(petViewModel.pets, id: \.self.id) { pet in
                        CircleNavigation(pet: pet, petViewModel: petViewModel)
                                .onAppear() {
                                    petViewModel.updateActivePets()
                                }
                                //.environmentObject(petViewModel)
                    }
                }
                .onAppear() {
                    petViewModel.updateActivePets()
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .id(petViewModel.pets.count)
               /* .frame(
                    width: UIScreen.main.bounds.width ,
                   // height: UIScreen.main.bounds.height - 83
                )*/
                
           // }
            
           /* }.onAppear() {
                petViewModel.updateActivePets()
            }*/
            //.frame()

        
        .modifier(DismissingKeyboard())
      //  .edgesIgnoringSafeArea(.all)
        //.offset(y: -20)
       
    }
    
   
}
