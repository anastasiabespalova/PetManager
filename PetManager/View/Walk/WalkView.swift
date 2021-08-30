//
//  WalkView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI
import MapKit
import ConfettiSwiftUI


struct WalkView: View {
    
    @State var counter:Int = 1

    @ObservedObject var petViewModel = PetViewModel()
    
    @State var walkStarted: Bool = false
    @State var moreThenOnePet: Bool = false
    
    @State var showingPopupForPetWalkSelection = false
    @State var showingPopupForWalkEnded = false

    @State var showingUndetailedWalkPooPopup = false
    @State var showingUndetailedPooPopup = false
    @State var showingDetailedWalkPooPopup = false
    @State var showingDetailedPooPopup = false
    @State var showingUndetailedWalkPeePopup = false
    @State var showingUndetailedPeePopup = false
    @State var showingDetailedWalkPeePopup = false
    @State var showingDetailedPeePopup = false
        
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
               WalkMap(coordinate: CLLocationCoordinate2D(latitude: 55.7522200, longitude:  37.6155600))
                    .edgesIgnoringSafeArea(.all)
                
                WalkActivitiesMenu(walkStarted: $walkStarted,
                                   moreThenOnePet: $moreThenOnePet,
                                   showingUndetailedWalkPooPopup: $showingUndetailedWalkPooPopup,
                                   showingUndetailedPooPopup: $showingUndetailedPooPopup,
                                   showingDetailedWalkPooPopup: $showingDetailedWalkPooPopup,
                                   showingDetailedPooPopup: $showingDetailedPooPopup,
                                   showingUndetailedWalkPeePopup: $showingUndetailedWalkPeePopup,
                                   showingUndetailedPeePopup: $showingUndetailedPeePopup,
                                   showingDetailedWalkPeePopup: $showingDetailedWalkPeePopup,
                                   showingDetailedPeePopup: $showingDetailedPeePopup)
                    .padding(20)
            }
            if walkStarted {
                WalkProcessInfoMenu(walkStarted: $walkStarted,
                                    showWalkEndedPopup: $showingPopupForWalkEnded)
                    .environmentObject(petViewModel)
                    .offset(y: -80)
            }
            else {
                WalkStartInfoMenu(walkStarted: $walkStarted,
                                  showingPopupForPetWalkSelection: $showingPopupForPetWalkSelection)
                    .environmentObject(petViewModel)
                    .offset(y: -80)
            }
           
        }
        
        
        
        .popup(isPresented: $showingPopupForPetWalkSelection, type: .`default`, closeOnTap: false) {
            SelectPetForAWalkPopup(walkStarted: $walkStarted,
                                   moreThenOnePet: $moreThenOnePet,
                                   showingPopupForPetWalkSelection: $showingPopupForPetWalkSelection)
                .environmentObject(petViewModel)

        }
        
        .popup(isPresented: $showingPopupForWalkEnded, type: .`default`, closeOnTap: false) {
            DetailedWalkPopup(moreThenOnePet: $moreThenOnePet,
                              showingPopupForWalkDetailed: $showingPopupForWalkEnded)
                .environmentObject(petViewModel)

        }
        
        
        
        .popup(isPresented: $showingUndetailedWalkPooPopup, type: .`default`, closeOnTap: false) {
            UndetailedPooPeeWalkPopup(showingPopup: $showingUndetailedWalkPooPopup, activity: /*PooActivity()*/Activity(title: "poo"))
                .environmentObject(petViewModel)
        }
        .popup(isPresented: $showingDetailedWalkPooPopup, type: .`default`, closeOnTap: false) {
            DetailedPooPeeWalkPopup(showingPopup: $showingDetailedWalkPooPopup, activity: Activity(title: "poo"))
                .environmentObject(petViewModel)
        }
        .popup(isPresented: $showingUndetailedPooPopup, autohideIn: 1) {
            UndetailedPopup(activity: Activity(title: "poo"))
        }
        .popup(isPresented: $showingDetailedPooPopup, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopup(showingPopup:  $showingDetailedPooPopup, activity: Activity(title: "poo"))
        }
        
        
        .popup(isPresented: $showingUndetailedWalkPeePopup, type: .`default`, closeOnTap: false) {
            UndetailedPooPeeWalkPopup(showingPopup: $showingUndetailedWalkPeePopup, activity: Activity(title: "pee"))
                .environmentObject(petViewModel)
        }
        .popup(isPresented: $showingDetailedWalkPeePopup, type: .`default`, closeOnTap: false) {
            DetailedPooPeeWalkPopup(showingPopup: $showingDetailedWalkPeePopup, activity: Activity(title: "pee"))
                .environmentObject(petViewModel)
        }
        .popup(isPresented: $showingUndetailedPeePopup, autohideIn: 1) {
            UndetailedPopup(activity: Activity(title: "pee"))
        }
        .popup(isPresented: $showingDetailedPeePopup, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopup(showingPopup:  $showingDetailedPeePopup, activity: Activity(title: "pee"))
        }
        
        
    }
}


