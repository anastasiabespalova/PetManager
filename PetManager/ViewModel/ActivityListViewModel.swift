//
//  ActivityListViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 03.09.2021.
//

import Foundation

class ActivityListViewModel: ObservableObject {
    @Published var petInfo: PetInfo
    
    @Published var deletingIndex: Int = -1
    @Published var deletingActivityTitle: String = ""
    
    init(petId: Int) {
        self.petInfo = PetInfo(pet: CoreDataManager.shared.getPetWithId(id: petId))
    }
    
    func update() {
        self.petInfo = PetInfo(pet: CoreDataManager.shared.getPetWithId(id: petInfo.id))
    }
    
    func deleteActivityForPet(petId: Int, activityTitle: String) {
        
        CoreDataManager.shared.deleteActivityForPet(id: petInfo.id, activityTitle: activityTitle)
        
        //self.updateActivePets()
        if self.petInfo.active_activities_array.contains(where: {$0.title == activityTitle}
         ) {
            self.petInfo.active_activities_array.removeAll(where: {$0.title == activityTitle})
            self.petInfo.active_activities = self.petInfo.active_activities.replacingOccurrences(of: "\(activityTitle) ", with: "")
            self.petInfo.inactive_activities_array.append(Activity(title: activityTitle))
            self.petInfo.inactive_activities.append("\(activityTitle) ")
            self.updatePetInfo(petInfo: self.petInfo)
        }
        self.petInfo = PetInfo(pet: CoreDataManager.shared.getPetWithId(id: petInfo.id))
    }
    
    func updatePetInfo(petInfo: PetInfo) {
        print("updated")
        print("name: \(petInfo.name)")
        print("active activities: \(petInfo.active_activities)")
        CoreDataManager.shared.updatePetInfo(petInfo: petInfo)
    }
    
    func archiveActivityWithId(activity: Activity) {
        if self.petInfo.active_activities_array.contains(where: {$0.title == activity.title}) {
            self.petInfo.archived_activities_array.append(activity)
            self.petInfo.archived_activities.append("\(activity.title) ")
            self.petInfo.active_activities = self.petInfo.active_activities.replacingOccurrences(of: "\(activity.title) ", with: "")
            self.petInfo.active_activities_array.removeAll(where: {$0.title == activity.title})
            self.updatePetInfo(petInfo: self.petInfo)
        }
    }
}
