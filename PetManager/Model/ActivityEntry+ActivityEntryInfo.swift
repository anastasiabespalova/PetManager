//
//  ActivityEntry+ActivityEntryInfo.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 31.08.2021.
//

import CoreData
import Combine
import SwiftUI
import MapKit
import CoreLocation

extension ActivityEntry_: Comparable {
    static public func < (lhs: ActivityEntry_, rhs: ActivityEntry_) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
    
    static public func == (lhs: ActivityEntry_, rhs: ActivityEntry_) -> Bool {
        lhs.timestamp == rhs.timestamp
    }

    
    static func withId(id: UUID, context: NSManagedObjectContext) -> ActivityEntry_ {
        let request = fetchRequest(NSPredicate(format: "id_ = %@", id as CVarArg))
        let entries = (try? context.fetch(request)) ?? []
        if let entry = entries.first {
            // if found, return it
            return entry
        } else {
            let entry = ActivityEntry_(context: context)
            entry.id = id
           // entry.timestamp = timestamp
            return entry
        }
    }
    
    
   // static func makeArchived(timestamp: Date, context: NSManagedObjectContext) {
    static func makeArchived(id: UUID, context: NSManagedObjectContext) {
       // let entry = self.withTimestamp(timestamp, context: context)
        let entry = self.withId(id: id, context: context)
        entry.archived_ = true
        entry.objectWillChange.send()
        try? context.save()
    }
    
  //  static func makeUnarchived(timestamp: Date, context: NSManagedObjectContext) {
    static func makeUnarchived(id: UUID, context: NSManagedObjectContext) {
      //  let entry = self.withTimestamp(timestamp, context: context)
        let entry = self.withId(id: id, context: context)
        entry.archived_ = false
        entry.objectWillChange.send()
        try? context.save()
    }
    
    static func update(from info: ActivityEntryInfo_, context: NSManagedObjectContext) {
       // let timestamp = info.timestamp
       // let entry = self.withTimestamp(timestamp, context: context)
        let id = info.id
        let entry = self.withId(id: id, context: context)
        entry.activity_title_ = info.activity_title
        entry.archived_ = info.archived
        entry.description_ = info.description
        entry.media_path_ = info.media_path
        entry.timestamp_ = info.timestamp
        
        entry.longitude_ = info.longitude ?? 0
        entry.latitude_ = info.latitude ?? 0
        entry.bikeRideId_ = info.bikeRideId
        
        entry.forPet_ = Pet.withId(info.petId, context: context)
        //print(info.withBikeRide ?? "no bike ride")
        entry.withBikeRide_ = info.withBikeRide
        entry.objectWillChange.send()
        try? context.save()
    }
    
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<ActivityEntry_> {
        let request = NSFetchRequest<ActivityEntry_>(entityName: "ActivityEntry_")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: false)]
        request.predicate = predicate
        return request
    }
    
    public var timestamp: Date {
        get { timestamp_! } // TODO: maybe protect against when app ships?
        set { timestamp_ = newValue }
    }
    
    public var id: UUID {
        get { id_! } // TODO: maybe protect against when app ships?
        set { id_ = newValue }
    }
}


struct ActivityEntryInfo_: Hashable, Comparable {

    var activity_title: String
    var archived: Bool
    var timestamp: Date
    var description: String
    var petId: Int
    var media_path: String
    var offset: CGFloat = 0
    var id: UUID
    
    var withBikeRideId: UUID?
    var withBikeRide: BikeRide?
    
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    var bikeRideId: UUID?
    
    init() {
        timestamp = Date()
        activity_title = ""
        archived = false
        description = ""
        petId = 0
        media_path = ""
        id = UUID()
    }
    
    init(activity_title: String, description: String, petId: Int) {
        self.timestamp = Date()
        self.activity_title = activity_title
        self.archived = false
        self.description = description
        self.petId = petId
        self.media_path = ""
        self.id = UUID()
       // self.media_path = media_path
    }
    
    init(activity_title: String, description: String, petId: Int, timestamp: Date, media_path: String) {
        self.timestamp = timestamp
        self.activity_title = activity_title
        self.archived = false
        self.description = description
        self.petId = petId
        self.media_path = media_path
        self.id = UUID()
       // self.media_path = media_path
    }
    
    init(activity_title: String, description: String, petId: Int, timestamp: Date, media_path: String, bikeRideId: UUID) {
        self.timestamp = timestamp
        self.activity_title = activity_title
        self.archived = false
        self.description = description
        self.petId = petId
        self.media_path = media_path
        self.id = UUID()
        self.withBikeRideId = bikeRideId
       // self.media_path = media_path
    }
    

    init(activity_title: String, description: String, petId: Int, timestamp: Date, media_path: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, bikeId: UUID ) {
        self.timestamp = timestamp
        self.activity_title = activity_title
        self.archived = false
        self.description = description
        self.petId = petId
        self.media_path = media_path
        self.id = UUID()
        
        self.longitude = longitude
        self.latitude = latitude
        self.bikeRideId = bikeId
       // self.media_path = media_path
    }
    
    init(activity_title: String, petId: Int, latitude: CLLocationDegrees, longitude: CLLocationDegrees, bikeId: UUID ) {
        self.timestamp = Date()
        self.activity_title = activity_title
        self.archived = false
        self.description = ""
        self.petId = petId
        self.media_path = ""
        self.id = UUID()
        
        self.longitude = longitude
        self.latitude = latitude
        self.bikeRideId = bikeId
    }
    
    init(activity_title: String, petId: Int, timestamp: Date, latitude: CLLocationDegrees, longitude: CLLocationDegrees, bikeId: UUID ) {
        self.timestamp = timestamp
        self.activity_title = activity_title
        self.archived = false
        self.description = ""
        self.petId = petId
        self.media_path = ""
        self.id = UUID()
        
        self.longitude = longitude
        self.latitude = latitude
        self.bikeRideId = bikeId
    }
    
    init(activityEntry: ActivityEntry_) {
        self.timestamp = activityEntry.timestamp
        self.activity_title = activityEntry.activity_title_!
        self.archived = activityEntry.archived_
        self.description = activityEntry.description_!
        self.petId = activityEntry.forPet_!.id
        self.media_path = activityEntry.media_path_ ?? ""
        self.id = activityEntry.id
        
        self.withBikeRide = activityEntry.withBikeRide_
        self.withBikeRideId = self.withBikeRide?.id
        
        self.latitude = activityEntry.latitude_
        self.longitude = activityEntry.longitude_
        self.bikeRideId = activityEntry.bikeRideId_
       // print(self.withBikeRide ?? "no bike ride")
    }
    
    
    
    func hash(into hasher: inout Hasher) { hasher.combine(timestamp) }
    static func == (lhs: ActivityEntryInfo_, rhs: ActivityEntryInfo_) -> Bool { lhs.timestamp == rhs.timestamp }
    static func < (lhs: ActivityEntryInfo_, rhs: ActivityEntryInfo_) -> Bool { lhs.timestamp < rhs.timestamp }
}
