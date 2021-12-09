//
//  PetWalkViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 10.09.2021.
//

import Foundation

class PetWalkViewModel: ObservableObject {
    @Published var pets: [PetInfo] = []
    @Published var petsOnWalk: [PetInfo] = []
    
    @Published var showingUndetailedWalkPooPopup = false
   // @Published var showingUndetailedPooPopup = false
    @Published var showingDetailedWalkPooPopup = false
   // @Published var showingDetailedPooPopup = false
    @Published var showingUndetailedWalkPeePopup = false
   // @Published var showingUndetailedPeePopup = false
    @Published var showingDetailedWalkPeePopup = false
   // @Published var showingDetailedPeePopup = false
    
    @Published var showingDetailedPooPopup = false
    @Published var showingDetailedPeePopup = false
    @Published var showingUndetailedPeePopup = false
    @Published var showingUndetailedPooPopup = false
    
    @Published var walkStarted: Bool = false
    @Published var moreThenOnePet: Bool = false
    
    @Published var showingPopupForPetWalkSelection = false
    @Published var showingPopupForWalkEnded = false
    @Published var showingPopupForWalkDetailed = false
    
    @Published var cyclingStartTime = Date()
    @Published var timeCycling: TimeInterval = 0.0
    
    //@Published var showWalkEndedPopup = false
    
    init() {
        pets.removeAll()
        pets = getAllActivePetsInfos()
    }
    
    func stopWalk() {
        self.walkStarted = false
        self.showingPopupForWalkEnded = true
        objectWillChange.send()
    }
    
    func updateActivePets() {
        pets.removeAll()
        pets = getAllActivePetsInfos()
    }
    
    func getAllActivePetsInfos() -> [PetInfo] {
        var petInfos: [PetInfo] = []
        for pet in CoreDataManager.shared.getAllActivePets() {
            petInfos.append(PetInfo(pet: pet))
        }
        return petInfos
    }
    
    func addActivityEntry(activityEntry: ActivityEntryInfo_) {
        var activityEntryCopy = activityEntry
        if activityEntryCopy.withBikeRideId != nil {
            activityEntryCopy.withBikeRide = CoreDataManager.shared.getBikeRide(id: activityEntryCopy.withBikeRideId!)
        }
        CoreDataManager.shared.addActivityEntry(activityEntry: activityEntryCopy)
    }
    
}
