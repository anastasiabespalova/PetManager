//
//  Pet.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 28.08.2021.
//

import CoreData
import Combine
import SwiftUI

extension Pet: Comparable {

    
    static func withId(_ id: Int, context: NSManagedObjectContext) -> Pet {
        // look up icao in Core Data
        let request = fetchRequest(NSPredicate(format: "id_ = %@", NSNumber(value: id)))
        let pets = (try? context.fetch(request)) ?? []
        if let pet = pets.first {
            // if found, return it
            return pet
        } else {
            // if not, create one and fetch from FlightAware
            let pet = Pet(context: context)
            pet.id = id
            //PetInfoRequest.fetch(id) { petInfo in
            //    self.update(from: petInfo, context: context)
            //}
            return pet
        }
    }
    

   // private static var flightAwareRequest: PetRequest!
   // private static var flightAwareResultsCancellable: AnyCancellable?

    static func update(from info: PetInfo, context: NSManagedObjectContext) {
        let id = info.id
        let pet = self.withId(id, context: context)
        pet.name_ = info.name
        pet.active_activities_ = info.active_activities
        print(info.active_activities)
        pet.inactive_activities_ = info.inactive_activities
        pet.archived_activities_ = info.archived_activities
        pet.archived_ = info.archived
        pet.timestamp_ = info.timestamp
        pet.gender_ = info.gender
        pet.neutered_ = info.neutred
        pet.chip_id_ = info.chip_id
        pet.date_birth_ = info.date_birth
        pet.objectWillChange.send()
        try? context.save()
    }

    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Pet> {
        let request = NSFetchRequest<Pet>(entityName: "Pet")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: true)]
        request.predicate = predicate
        return request
    }

  /*  var flightsTo: Set<Flight> {
        get { (flightsTo_ as? Set<Flight>) ?? [] }
        set { flightsTo_ = newValue as NSSet }
    }
    var flightsFrom: Set<Flight> {
        get { (flightsFrom_ as? Set<Flight>) ?? [] }
        set { flightsFrom_ = newValue as NSSet }
    } */

    public var id: Int {
        get { Int(id_) } // TODO: maybe protect against when app ships?
        set { id_ = Int16(newValue) }
    }

 /*   var friendlyName: String {
        let friendly = AirportInfo.friendlyName(name: self.name ?? "", location: self.location ?? "")
        return friendly.isEmpty ? icao : friendly
    }*/

   // public var id: String { icao }

    static public func < (lhs: Pet, rhs: Pet) -> Bool {
        lhs.id < rhs.id
    }
}


struct PetInfo: Hashable, Identifiable, Comparable {
    var defaultImage = "cat"
    
    var id: Int
    var name: String
    var timestamp: Date
    var active_activities: String
    var archived: Bool
    var archived_activities: String
    var inactive_activities: String
    
    var gender: String
    var neutred: Bool
    var chip_id: String
    var date_birth: Date
    
    var active_activities_array: [Activity] = []
    var inactive_activities_array: [Activity] = []
    var archived_activities_array: [Activity] = []
    
    var offset: CGFloat = 0
    
    init() {
        id =  UserDefaults.standard.integer(forKey: "MaxID") + 1
        UserDefaults.standard.set(id, forKey: "MaxID")
        name = ""
        timestamp = Date()
        active_activities = ""
        archived = false
        archived_activities = ""
        inactive_activities = ""
        gender = "Other"
        neutred = false
        chip_id = ""
        date_birth = Date()
    }
    
    init(pet: Pet) {
        id = pet.id
        name = pet.name_ ?? ""
        timestamp = pet.timestamp_ ?? Date()
        active_activities = pet.active_activities_ ?? ""
        archived = pet.archived_
        archived_activities = pet.archived_activities_ ?? ""
        inactive_activities = pet.inactive_activities_ ?? ""
        
        gender = pet.gender_ ?? ""
        neutred = pet.neutered_
        chip_id = pet.chip_id_ ?? ""
        date_birth = pet.date_birth_ ?? Date()
        
        for activity in active_activities.mentionedActivities {
            active_activities_array.append(Activity(title: activity))
        }
        
        for activity in inactive_activities.mentionedActivities {
            inactive_activities_array.append(Activity(title: activity))
        }
        
        for activity in archived_activities.mentionedActivities {
            archived_activities_array.append(Activity(title: activity))
        }

    }

    init(name: String, chip_id: String, dateOfBirth: Date, gender: String, neutred: Bool, active_activities: String) {
        self.id =  UserDefaults.standard.integer(forKey: "MaxID") + 1
        UserDefaults.standard.set(id, forKey: "MaxID")
        
        self.timestamp = Date()
        self.name = name
        self.chip_id = chip_id
        self.date_birth = dateOfBirth
        self.gender = gender
        self.neutred = neutred
        self.active_activities = active_activities
        
        self.archived = false
        self.archived_activities = ""
        self.inactive_activities = ""
        
        
    }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: PetInfo, rhs: PetInfo) -> Bool { lhs.id == rhs.id }
    static func < (lhs: PetInfo, rhs: PetInfo) -> Bool { lhs.timestamp < rhs.timestamp }
}
