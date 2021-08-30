//
//  ActivityEntry.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import Foundation
import SwiftUI

struct ActivityEntry {
    var activity: Activity
    var pet: PetInfo
    
    var date: String = "01.12.2021"
    var value: String
    
    var offset: CGFloat = 0
    
    // var rate: Int?
    // var description: String?
    // var weightValue: Double?
    // var weightMeasure: ? from enum
    // var media: ?
}
