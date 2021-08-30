//
//  ActivityHistoryViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import Foundation

class ActivityHistoryViewModel: ObservableObject {
    
    var pet: PetInfo
    var activity: Activity
    
    
    @Published var activityEntries: [ActivityEntry] = []
    
    init(pet: PetInfo, activity: Activity) {
        self.pet = pet
        self.activity = activity
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "02.10.2021", value: "5.2"))
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "09.10.2021", value: "5.31"))
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "16.10.2021", value: "5.1"))
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "23.10.2021", value: "5.2"))
    }
    
    // MARK: -Intents:
    // get all active activity entries
    // get all archived activity entries
    
    // add activity entry
    // delete activity entry
    // archive activity entry
    
    // update activity entry
}
