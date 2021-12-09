//
//  ArchiveEntriesViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 02.09.2021.
//

import Foundation
class ArchiveEntriesViewModel: ObservableObject {
    @Published var archivedActivityEntriesForPetAndActivity: [ActivityEntryInfo_] = []
    
    var petId: Int
    var activityTitle: String = ""
    var unarchivingIndex: Int = -1
    
    init(petId: Int, activityTitle: String) {
        self.petId = petId
        self.activityTitle = activityTitle
        self.getArchivedActivityEntries()
    }
    
    
    func getArchivedActivityEntries() {
        archivedActivityEntriesForPetAndActivity.removeAll()
        for activityEntry in CoreDataManager.shared.getArchivedActivityEntries(petId: petId, activityTitle: activityTitle) {
            archivedActivityEntriesForPetAndActivity.append(ActivityEntryInfo_(activityEntry: activityEntry))
           // print("got activity entry")
        }
    }
    
    func unarchiveActivityEntry() {
       // CoreDataManager.shared.unarchiveActivityEntry(timestamp: archivedActivityEntriesForPetAndActivity[unarchivingIndex].timestamp)
        CoreDataManager.shared.unarchiveActivityEntry(id: archivedActivityEntriesForPetAndActivity[unarchivingIndex].id)
        getArchivedActivityEntries()
    }
}
