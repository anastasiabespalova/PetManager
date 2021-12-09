//
//  PetEditViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 03.09.2021.
//

import Foundation
class PetEditViewModel: ObservableObject {
    @Published var petInfo: PetInfo
    init(petInfo: PetInfo) {
        self.petInfo = petInfo
    }
    
    func updatePetInfo() {
      
        CoreDataManager.shared.updatePetInfo(petInfo: petInfo)
    }
    
    
    func updateActivities(activities: [(Activity, Bool)]) {
        for activity in activities {
            if activity.1 == true {
                if petInfo.inactive_activities.contains(activity.0.title) == true {
                    petInfo.inactive_activities_array.removeAll(where: {$0.title == activity.0.title})
                    petInfo.inactive_activities = petInfo.inactive_activities.replacingOccurrences(of: "\(activity.0.title) ", with: "")
                    petInfo.active_activities_array.append(activity.0)
                    petInfo.active_activities.append("\(activity.0.title) ")
                } else if petInfo.archived_activities.contains(activity.0.title) == true {
                    petInfo.archived_activities_array.removeAll(where: {$0.title == activity.0.title})
                    petInfo.archived_activities = petInfo.archived_activities.replacingOccurrences(of: "\(activity.0.title) ", with: "")
                    petInfo.active_activities_array.append(activity.0)
                    petInfo.active_activities.append("\(activity.0.title) ")
                }
            } else {
                if petInfo.active_activities_array.contains(activity.0) {
                    petInfo.active_activities_array.removeAll(where: {$0.title == activity.0.title})
                    petInfo.active_activities = petInfo.active_activities.replacingOccurrences(of: "\(activity.0.title) ", with: "")
                    petInfo.archived_activities_array.append(activity.0)
                    petInfo.archived_activities.append("\(activity.0.title) ")
                }
            }
            
        }
        updatePetInfo()
    }
    
}
