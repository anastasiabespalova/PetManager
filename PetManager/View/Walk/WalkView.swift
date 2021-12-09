//
//  WalkView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI
import MapKit
import ConfettiSwiftUI
import CoreLocation


struct WalkView: View {
    @StateObject var timer = TimerViewModel()
    
    let persistenceController = CoreDataManager.shared
    //@State var counter: Int = 1

    @ObservedObject var petWalkViewModel = PetWalkViewModel()
    
   

    @StateObject var locationManager = LocationViewModel.locationManager
    @StateObject var cyclingStatus = CyclingStatus()
    
    // check if they initialize when it is unsupposed
    // previously they initialized in ContentView
    // now they are in PetWalkViewModel
    //@State var cyclingStartTime = Date()
   // @State var timeCycling: TimeInterval = 0.0
    
    @State var mapCentered: Bool = true
    
        
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                MapView(locationManager: locationManager,
                        centerMapOnLocation: $mapCentered)
                    .environmentObject(cyclingStatus)
                    .environmentObject(petWalkViewModel)
                    .edgesIgnoringSafeArea(.all)
                
                
                WalkActivitiesMenu()
                    .padding(20)
                    .environmentObject(petWalkViewModel)
                    .environmentObject(locationManager)
                
            }
            if petWalkViewModel.walkStarted {
                WalkProcessInfoMenu(locationManager: locationManager,
                                    /* cyclingStartTime: $cyclingStartTime,
                                    timeCycling: $timeCycling,*/
                                    cyclingStatus: cyclingStatus,
                                    timer: timer)
                    .environmentObject(petWalkViewModel)
                    .onAppear() {
                        startCycling()
                    }
                    .offset(y: -30)
            }
            else {
                WalkStartInfoMenu()
                    .environmentObject(petWalkViewModel)
                    .offset(y: -30)
            }
           
        }
        
        .popup(isPresented: $petWalkViewModel.showingPopupForPetWalkSelection, type: .`default`, closeOnTap: false) {
            SelectPetForAWalkPopup()
                .environmentObject(petWalkViewModel)
            

        }
        
        .popup(isPresented: $petWalkViewModel.showingPopupForWalkEnded, type: .`default`, closeOnTap: false) {
            DetailedWalkPopup()
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)

        }
        
        
    
        .popup(isPresented: $petWalkViewModel.showingUndetailedWalkPooPopup, type: .`default`, closeOnTap: false) {
            UndetailedPooPeeWalkPopup(activity: Activity(title: "poo"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }
        .popup(isPresented: $petWalkViewModel.showingDetailedWalkPooPopup, type: .`default`, closeOnTap: false) {
            DetailedPooPeeWalkPopup(activity: Activity(title: "poo"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }

        .popup(isPresented: $petWalkViewModel.showingUndetailedWalkPeePopup, type: .`default`, closeOnTap: false) {
            UndetailedPooPeeWalkPopup(activity: Activity(title: "pee"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }
        .popup(isPresented: $petWalkViewModel.showingDetailedWalkPeePopup, type: .`default`, closeOnTap: false) {
            DetailedPooPeeWalkPopup(activity: Activity(title: "pee"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }
        
        .popup(isPresented: $petWalkViewModel.showingUndetailedPooPopup, autohideIn: 1) {
            UndetailedPopupForWalk(activity: Activity(title: "poo"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }
        .popup(isPresented: $petWalkViewModel.showingUndetailedPeePopup, autohideIn: 1) {
            UndetailedPopupForWalk(activity: Activity(title: "pee"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }
        
        .popup(isPresented: $petWalkViewModel.showingDetailedPooPopup, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopupForWalk(showingPopup: $petWalkViewModel.showingDetailedPooPopup,
                                          activity: Activity(title: "poo"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }
        
        .popup(isPresented: $petWalkViewModel.showingDetailedPeePopup, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopupForWalk(showingPopup: $petWalkViewModel.showingDetailedPeePopup,
                                          activity: Activity(title: "pee"))
                .environmentObject(petWalkViewModel)
                .environmentObject(locationManager)
        }

    }
    
    func startCycling() {
        cyclingStatus.startedCycling()
        
        petWalkViewModel.cyclingStartTime = Date()
        petWalkViewModel.timeCycling = 0.0
        self.timer.start()
    }
    

}


