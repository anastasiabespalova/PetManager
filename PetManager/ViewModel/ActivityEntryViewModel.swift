//
//  ActivityEntryViewModel.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 03.09.2021.
//

import SwiftUI

class ActivityEntryViewModel: ObservableObject {
    @Published var entryInfo: ActivityEntryInfo_
    @Published var poosAndPeesDuringWalk: [ActivityEntryInfo_] = []
    
    init(entry: ActivityEntryInfo_) {
        self.entryInfo = entry
        
        if entryInfo.withBikeRide != nil {
            getAllPoosAndPees()
        }
    }
    
    func update() {
        CoreDataManager.shared.addActivityEntry(activityEntry: entryInfo)
    }
    
    func getAllPoosAndPees() {
        poosAndPeesDuringWalk = CoreDataManager.shared.getAllPoosAndPeesForWalk(activityEntryInfo: entryInfo)
    }
    
    
}
