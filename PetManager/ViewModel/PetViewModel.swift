//
//  PetViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 22.08.2021.
//

import Foundation
import CoreData

/*let allActivties = ["cage", "claws", "food", "parasites", "pee", "pills", "poo", "training", "vaccine", "vomit", "walk", "washing", "water", "weight"]*/

class PetViewModel: ObservableObject {
    
   
    
   // @Published var allPetsInfo: [PetInfo]  = []
    
    @Published var pets: [PetInfo] = []
    @Published var petsOnWalk: [PetInfo] = []
    
    init() {
        //let petInfo = PetInfo(id: 1, name: "Tomas", timestamp: Date(), active_activities: "walk, food", archived: false, archived_activities: "", inactive_activities: "", gender: "Other", neutred: false, chip_id: "", date_birth: Date())
       // CoreDataManager.shared.addNewPet(petInfo: petInfo)
      //  Pet.update(from: petInfo, context: CoreDataManager.shared.viewContext)
      /*  pets.append(Pet__(name: "Henry", dateOfBirth: nil, defaultImage: "cat",
                        activitiesWithFastAccess: [Activity(title: "vomit"), Activity(title: "washing"), Activity(title: "food"), Activity(title: "poo"), Activity(title: "claws"), Activity(title: "water")],
                        otherActivities: [Activity(title: "weight"), Activity(title: "pee"), Activity(title: "vaccine"), Activity(title: "pills"), Activity(title: "walk"), Activity(title: "training"), Activity(title: "cage")],
                        activities: [Activity(title: "weight"), Activity(title: "parasites"), Activity(title: "vaccine"), Activity(title: "pee"), Activity(title: "pills"), Activity(title: "walk"), Activity(title: "training"), Activity(title: "cage"), Activity(title: "vomit"), Activity(title: "washing"), Activity(title: "food"), Activity(title: "poo"), Activity(title: "claws"), Activity(title: "water")]))
        */
       /* pets.append(Pet__(name: "Tom", dateOfBirth: nil, defaultImage: "dog",
                        activitiesWithFastAccess: [VomitActivity(), WashingActivity(), FoodActivity(), PooActivity(), nil, WaterActivity()],
                        otherActivities: [WeightActivity(), ParasitesActivity()],
                        activities: [WeightActivity(), ParasitesActivity(), VaccineActivity(), PeeActivity(), PillsActivity(), WalkingActivity(), TrainingActivity(), CageActivity()]))*/
        pets.removeAll()
        pets = getAllPetsInfos()

    }
    // MARK: -Intents

    // add pet
    func addNewPetWith(petInfo: PetInfo) {
        print("active activities in view model: \(petInfo.active_activities)")
        pets.append(PetInfo(pet: CoreDataManager.shared.addNewPet(petInfo: petInfo)))
        
    }
    
    // get pet with ID
    
    // get all pets
    func getAllPetsInfos() -> [PetInfo] {
        var petInfos: [PetInfo] = []
        for pet in CoreDataManager.shared.getAllPets() {
            petInfos.append(PetInfo(pet: pet))
        }
        return petInfos
    }
    
    // delete pet with ID
    
    // delete all pets
    func deleteAllPets() {
        pets.removeAll()
        CoreDataManager.shared.deleteAllPets()
    }
    
   
    
    // get all archived pets
    // archive pet with ID
    // unarchive pet with ID
    
    
    // update pet info with ID
    
    // get pets on walk
    // add pet on walk
    // remove pets on walk
    
}


