//
//  PetViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 22.08.2021.
//

import Foundation
import CoreData


enum ActivityState {
    case active
    case inactive
    case archived
}

class PetViewModel: ObservableObject {

    @Published var pets: [PetInfo] = []
    @Published var petsOnWalk: [PetInfo] = []
    @Published var deletingIndex: Int = -1
    @Published var archivingIndex: Int = -1
    @Published var deletingActivityTitle: String = ""
    @Published var archivedPets: [PetInfo] = []
    var unarchivingId: Int = -1
    
    init() {
        pets.removeAll()
        pets = getAllActivePetsInfos()
        archivedPets.removeAll()
        archivedPets = getAllArchivedPetsInfos()

    }
    // MARK: -Intents
    
    func addActivityEntry(activityEntry: ActivityEntryInfo_) {
        CoreDataManager.shared.addActivityEntry(activityEntry: activityEntry)
    }
    
    func getActivityEntriesForPet(petId: Int, activityTitle: String) -> [ActivityEntry_] {
        return CoreDataManager.shared.getActivityEntriesForPet(activityTitle: activityTitle, petId: petId)
    }

    //update active pets
    func updateActivePets() {
        pets.removeAll()
        pets = getAllActivePetsInfos()
    }
    
    // add pet
    func addNewPetWith(petInfo: PetInfo) {
        pets.append(PetInfo(pet: CoreDataManager.shared.addNewPet(petInfo: petInfo)))
        pets.removeAll()
        pets = getAllActivePetsInfos()
    }
    
    // get pet with ID
    func getPetWithId(id: Int) -> PetInfo {
        return PetInfo(pet: CoreDataManager.shared.getPetWithId(id: id))
    }
    
    // get all pets
    func getAllActivePetsInfos() -> [PetInfo] {
        var petInfos: [PetInfo] = []
        for pet in CoreDataManager.shared.getAllActivePets() {
            petInfos.append(PetInfo(pet: pet))
        }
        return petInfos
    }
    
    // delete pet with ID
    func deletePetWIthId(id: Int) {
        CoreDataManager.shared.deletePetWIthId(id: id)
        self.updateActivePets()
    }
    
    
    
    func deleteActivityForPet(petId: Int, activityTitle: String) {
        
        CoreDataManager.shared.deleteActivityForPet(id: pets[petId].id, activityTitle: activityTitle)
        self.updateActivePets()
       /* if self.pets[petId].active_activities_array.contains(where: {$0.title == activityTitle}
         ) {
            self.pets[petId].active_activities_array.removeAll(where: {$0.title == activityTitle})
            self.pets[petId].active_activities = self.pets[petId].active_activities.replacingOccurrences(of: "\(activityTitle) ", with: "")
            self.pets[petId].inactive_activities_array.append(Activity(title: activityTitle))
            self.pets[petId].inactive_activities.append("\(activityTitle) ")
            self.updatePetInfo(petInfo: self.pets[petId])
        }*/
    }
    
    // delete all pets
    func deleteAllPets() {
        pets.removeAll()
        CoreDataManager.shared.deleteAllPets()
    }

    // get all archived pets
    func getAllArchivedPetsInfos() -> [PetInfo] {
        var petInfos: [PetInfo] = []
        for pet in CoreDataManager.shared.getAllArchivedPets() {
            petInfos.append(PetInfo(pet: pet))
        }
        return petInfos
    }
    
    // archive pet with ID
    func archivePetWithId(id: Int) {
        CoreDataManager.shared.archivePetWithId(id: id)
        pets.removeAll()
        pets = getAllActivePetsInfos()
        archivedPets.removeAll()
        archivedPets = getAllArchivedPetsInfos()
    }
    
    // unarchive selected pets
    func unarchiveSelected(selectedItems: Set<Int>) {
        
        for index in selectedItems {
            CoreDataManager.shared.unarchivePetWithId(id: archivedPets[index].id)
        }
        pets.removeAll()
        pets = getAllActivePetsInfos()
        archivedPets.removeAll()
        archivedPets = getAllArchivedPetsInfos()
    }
    
    // update pet info
    func updatePetInfo(petInfo: PetInfo) {
        print("updated")
        print("name: \(petInfo.name)")
        print("active activities: \(petInfo.active_activities)")
        CoreDataManager.shared.updatePetInfo(petInfo: petInfo)
        pets.removeAll()
        pets = getAllActivePetsInfos()
    }
    
    // change IDs to change order
    func changeOrder() {
        
    }
    
   /* f value == true {
         if petEditViewModel.petInfo.inactive_activities.contains(activities[index].0.title) == true {
             petEditViewModel.petInfo.inactive_activities_array.removeAll(where: {$0.title == activities[index].0.title})
             petEditViewModel.petInfo.inactive_activities = petEditViewModel.petInfo.inactive_activities.replacingOccurrences(of: "\(activities[index].0.title) ", with: "")
             petEditViewModel.petInfo.active_activities_array.append(activities[index].0)
             petEditViewModel.petInfo.active_activities.append("\(activities[index].0.title) ")
         } else if petEditViewModel.petInfo.archived_activities.contains(activities[index].0.title) == true {
             petEditViewModel.petInfo.archived_activities_array.removeAll(where: {$0.title == activities[index].0.title})
             petEditViewModel.petInfo.archived_activities = petEditViewModel.petInfo.archived_activities.replacingOccurrences(of: "\(activities[index].0.title) ", with: "")
             petEditViewModel.petInfo.active_activities_array.append(activities[index].0)
             petEditViewModel.petInfo.active_activities.append("\(activities[index].0.title) ")
         }
     } else {
         if petEditViewModel.petInfo.active_activities.contains(activities[index].0.title) {
             petEditViewModel.petInfo.active_activities_array.removeAll(where: {$0.title == activities[index].0.title})
             petEditViewModel.petInfo.active_activities = petEditViewModel.petInfo.active_activities.replacingOccurrences(of: "\(activities[index].0.title) ", with: "")
             petEditViewModel.petInfo.archived_activities_array.append(activities[index].0)
             petEditViewModel.petInfo.archived_activities.append("\(activities[index].0.title) ")
    */
    
    
    func archiveActivityWithId(petIndex: Int, id: Int) {
        if self.pets[petIndex].active_activities_array.contains(where: {$0.title == self.pets[petIndex].active_activities_array[id].title}) {
            self.pets[petIndex].archived_activities_array.append(self.pets[petIndex].active_activities_array[id])
            self.pets[petIndex].archived_activities.append("\(self.pets[petIndex].active_activities_array[id].title) ")
            self.pets[petIndex].active_activities = self.pets[petIndex].active_activities.replacingOccurrences(of: "\(self.pets[petIndex].active_activities_array[id].title) ", with: "")
            self.pets[petIndex].active_activities_array.removeAll(where: {$0.title == self.pets[petIndex].active_activities_array[id].title})
            self.updatePetInfo(petInfo: self.pets[petIndex])
        }
    }
    
    
    
    // get pets on walk
    // add pet on walk
    // remove pets on walk
    
}


