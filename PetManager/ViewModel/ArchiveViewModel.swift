//
//  ArchiveViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 01.09.2021.
//

import Foundation

class ArchiveViewModel: ObservableObject {
    @Published var archivedPets: [PetInfo] = []
    @Published var archivedActivitiesForPet: [Activity] = []
    @Published var archivedActivityEntriesForPetAndActivity: [ActivityEntryInfo_] = []
    
    var petId: Int = -1
    var activityTitle: String = ""
    
    
    init() {
        self.getPetsWithArchivedAttributes()
    }
    
    func getArchivedAttributesForPet(petId: Int) {
        archivedActivitiesForPet.removeAll()
        for activity in CoreDataManager.shared.getActivitiesWithArchivedAttributes(petId: petId) {
            archivedActivitiesForPet.append(Activity(title: activity))
        }
    }
    
    func getPetsWithArchivedAttributes() {
        archivedPets.removeAll()
        for pet in CoreDataManager.shared.getAllPetsWithArchivedAttributes() {
            archivedPets.append(PetInfo(pet: pet))
        }
    }
    
    func getActivitiesWithArchivedAttributes() {
        archivedActivitiesForPet.removeAll()
        for activity in CoreDataManager.shared.getActivitiesWithArchivedAttributes(petId: petId) {
            archivedActivitiesForPet.append(Activity(title: activity))
        }
       // print(archivedActivitiesForPet)
    }
    
    func getArchivedActivityEntries() {
        archivedActivityEntriesForPetAndActivity.removeAll()
        for activityEntry in CoreDataManager.shared.getArchivedActivityEntries(petId: petId, activityTitle: activityTitle) {
            archivedActivityEntriesForPetAndActivity.append(ActivityEntryInfo_(activityEntry: activityEntry))
           // print("got activity entry")
        }
    }
    
    func unarchiveActivity(petId: Int, activityTitle: String) {
        CoreDataManager.shared.unarchiveActivity(petId: petId, activityTitle: activityTitle)
        getArchivedActivityEntries()
    }
    
    
    
}
