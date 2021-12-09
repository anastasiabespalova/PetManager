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
    
    @Published var archivingIndex: Int = -1
    @Published var deletingIndex: Int = -1
    @Published var deletingUUID: UUID = UUID()
    
    @Published var activityEntries_: [ActivityEntryInfo_] = []
   // @Published var activityEntries: [ActivityEntry] = []
    
    init(pet: PetInfo, activity: Activity) {
        self.pet = pet
        self.activity = activity
        
        activityEntries_.removeAll()
        
        for activityEntry in getActivityEntriesForPet(petId: pet.id, activityTitle: activity.title) {
            activityEntries_.append(ActivityEntryInfo_(activityEntry: activityEntry))
        }
        
        /*activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "02.10.2021", value: "5.2"))
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "09.10.2021", value: "5.31"))
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "16.10.2021", value: "5.1"))
        activityEntries.append(ActivityEntry(activity: activity, pet: self.pet, date: "23.10.2021", value: "5.2"))*/
    }
    
    // MARK: -Intents:
    
    func addActivityEntry(activityEntry: ActivityEntryInfo_) {
        CoreDataManager.shared.addActivityEntry(activityEntry: activityEntry)
        activityEntries_.removeAll()
        for activityEntry in getActivityEntriesForPet(petId: pet.id, activityTitle: activity.title) {
            
            activityEntries_.append(ActivityEntryInfo_(activityEntry: activityEntry))
        }
        print("added")
    }
    
    func getActivityEntriesForPet(petId: Int, activityTitle: String) -> [ActivityEntry_] {
        return CoreDataManager.shared.getActivityEntriesForPet(activityTitle: activityTitle, petId: petId)
    }
    
    func update() {
        activityEntries_.removeAll()
        
        for activityEntry in getActivityEntriesForPet(petId: pet.id, activityTitle: activity.title) {
            
            activityEntries_.append(ActivityEntryInfo_(activityEntry: activityEntry))
        }
    }
    
    func archiveActivityEntry(id: Int) {
       // CoreDataManager.shared.archiveActivityEntry(activityEntryTimestamp: activityEntries_[id].timestamp)
        CoreDataManager.shared.archiveActivityEntry(id: activityEntries_[id].id)
        self.update()
    }
    
    func deleteActivityEntry(id: Int) {
        CoreDataManager.shared.deleteActivityEntry(id: activityEntries_[id].id)
        self.update()
    }
    
    
    // get all active activity entries
    // get all archived activity entries
    
    // add activity entry
    // delete activity entry
    // archive activity entry
    
    // update activity entry
}
