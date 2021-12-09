//
//  WalkInfoMenu.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI

struct WalkStartInfoMenu: View {
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                Circle()
                    .foregroundColor(.purple)
                    .frame(width: 60, height: 60)
            }
            .onTapGesture {
                if petWalkViewModel.pets.count > 1 {
                    petWalkViewModel.showingPopupForPetWalkSelection = true
                } else {
                    if petWalkViewModel.pets.count == 1 {
                        petWalkViewModel.petsOnWalk.append(petWalkViewModel.pets.first!)
                        petWalkViewModel.walkStarted = true
                    }
                }
            }
        }
        
    }
}

struct WalkProcessInfoMenu: View {
    let persistenceController = CoreDataManager.shared
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @StateObject var locationManager: LocationViewModel
    
    //@Binding var cyclingStartTime: Date
    //@Binding var timeCycling: TimeInterval
    
    @StateObject var cyclingStatus: CyclingStatus
    @StateObject var timer: TimerViewModel
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 100, height: 50)
                    .opacity(0.6)
                Text("\(Int(locationManager.cyclingTotalDistance)) m")
                    
            }
            
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.orange)
                    .frame(width: 50, height: 50)
            }
            .onTapGesture {
                petWalkViewModel.stopWalk()
                
                petWalkViewModel.timeCycling = timer.totalAccumulatedTime
                self.timer.stop()
                cyclingStatus.stoppedCycling()
                
                persistenceController.storeBikeRide(locations: locationManager.cyclingLocations,
                                                    speeds: locationManager.cyclingSpeeds,
                                                    distance: locationManager.cyclingTotalDistance,
                                                    elevations: locationManager.cyclingAltitudes,
                                                    startTime: petWalkViewModel.cyclingStartTime,
                                                    time: petWalkViewModel.timeCycling, id: locationManager.id)
                
                locationManager.clearLocationArray()
                locationManager.stopTrackingBackgroundLocation()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 100, height: 50)
                    .opacity(0.6)
                Text(formatTimeString(accumulatedTime: timer.totalAccumulatedTime))
            }
        }
    }
    
    
    
}


func formatTimeString(accumulatedTime: TimeInterval) -> String {
    let hours = Int(accumulatedTime) / 3600
    let minutes = Int(accumulatedTime) / 60 % 60
    let seconds = Int(accumulatedTime) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
}
