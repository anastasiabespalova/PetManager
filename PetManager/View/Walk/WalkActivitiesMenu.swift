//
//  WalkActivitiesMenu.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI

struct WalkActivitiesMenu: View {
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var locationManager: LocationViewModel
    
    var body: some View {
        HStack() {
            SmallConnectionView(imageName: Activity(title: "poo").title)
            .onTapGesture {
                impactMed.impactOccurred()
                if petWalkViewModel.walkStarted && petWalkViewModel.moreThenOnePet {
                    petWalkViewModel.showingUndetailedWalkPooPopup = true
                } else if petWalkViewModel.walkStarted {
                    petWalkViewModel.showingUndetailedPooPopup = true
                    if petWalkViewModel.petsOnWalk.count != 0 {
                        petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(
                                                            activity_title: "poo",
                                                            petId: petWalkViewModel.petsOnWalk[0].id,
                                                            latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                                            longitude: (locationManager.lastLocation?.coordinate.longitude)!,
                                                            bikeId: locationManager.id))
                    }
                }
            }
            .onLongPressGesture {
                impactMed.impactOccurred()
                if petWalkViewModel.walkStarted && petWalkViewModel.moreThenOnePet {
                    petWalkViewModel.showingDetailedWalkPooPopup = true
                } else if petWalkViewModel.walkStarted {
                    petWalkViewModel.showingDetailedPooPopup = true
                }
            }
            SmallConnectionView(imageName: Activity(title: "pee").title)
            .onTapGesture {
                impactMed.impactOccurred()
                if petWalkViewModel.walkStarted && petWalkViewModel.moreThenOnePet {
                    petWalkViewModel.showingUndetailedWalkPeePopup = true
                } else if petWalkViewModel.walkStarted {
                    petWalkViewModel.showingUndetailedPeePopup = true
                    if petWalkViewModel.petsOnWalk.count != 0 {
                        petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(
                                                            activity_title: "pee",
                                                            petId: petWalkViewModel.petsOnWalk[0].id,
                                                            latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                                            longitude: (locationManager.lastLocation?.coordinate.longitude)!,
                                                            bikeId: locationManager.id))
                    }
                }
            }
            .onLongPressGesture {
                impactMed.impactOccurred()
                if petWalkViewModel.walkStarted && petWalkViewModel.moreThenOnePet {
                    petWalkViewModel.showingDetailedWalkPeePopup = true
                } else if petWalkViewModel.walkStarted {
                    petWalkViewModel.showingDetailedPeePopup = true
                }
            }
            
            SmallConnectionView(imageName: "camera")
            .onTapGesture {
                impactMed.impactOccurred()
            }
            .onLongPressGesture {
                impactMed.impactOccurred()
            }
        }
    }
}


