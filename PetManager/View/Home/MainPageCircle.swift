//
//  MainPageCircle.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 22.08.2021.
//

import SwiftUI
import CoreData


struct MainPageCircle: View {
    @ObservedObject var petViewModel = PetViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            
            ZStack {

                TabView(selection: $selectedTab.animation()) {
                    ForEach(0..<petViewModel.pets.count) { index in
                        CircleNavigation(pet: $petViewModel.pets[index])
                            .offset(y: -20)
                    }
                }
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

                .frame(
                    width: UIScreen.main.bounds.width ,
                    height: UIScreen.main.bounds.height - 83
                )
                
            }

        }
        .modifier(DismissingKeyboard())
        .edgesIgnoringSafeArea(.all)
        
       
    }
    
   
}
