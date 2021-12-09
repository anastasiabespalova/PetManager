//
//  CoreDataManager.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 28.08.2021.
//

import Foundation


import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Initializing and saving
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "PetManager")
        persistentContainer.loadPersistentStores { (description, error) in
                    if let error = error {
                        fatalError("Unable to initialize Core Data Stack \(error)")
                    }
                }
    }
    
    func saveContext () {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
       }
    
    

    func getAllActivePets() -> [Pet] {
        let request: NSFetchRequest<Pet> = Pet.fetchRequest(NSPredicate(format: "archived_ = FALSE"))
        do {
                   return try viewContext.fetch(request)
               } catch {
                   return []
               }
        }
    
    func getAllArchivedPets() -> [Pet] {
        let request: NSFetchRequest<Pet> = Pet.fetchRequest(NSPredicate(format: "archived_ = TRUE"))
        do {
                   return try viewContext.fetch(request)
               } catch {
                   return []
               }
        }
    
    func getAllPetsWithArchivedAttributes() -> [Pet] {
        let request: NSFetchRequest<Pet> = Pet.fetchRequest(NSPredicate(format: "archived_ = TRUE or archived_activities_ != %@ or ANY withActivityEntries_.archived_ = TRUE", ""))
        do {
                   return try viewContext.fetch(request)
               } catch {
                   return []
               }
        }
    
    func getActivitiesWithArchivedAttributes(petId: Int) -> [String] {
        var result: [String] = []
        if Pet.withId(petId, context: viewContext).archived_ == true {
            for activity in Pet.withId(petId, context: viewContext).active_activities_!.mentionedActivities {
                result.append(activity)
            }
            for activity in Pet.withId(petId, context: viewContext).archived_activities_!.mentionedActivities {
                result.append(activity)
            }
        } else {
        
            for activity in Pet.withId(petId, context: viewContext).archived_activities_!.mentionedActivities {
                result.append(activity)
            }
            
            let request: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "archived_ = TRUE and forPet_ = %@", Pet.withId(petId, context: viewContext)))
            for entry in try! viewContext.fetch(request) {
                if !result.contains(entry.activity_title_!) {
                    result.append(entry.activity_title_!)
                }
            }
        }
        return result
    }
    
    func getArchivedActivityEntries(petId: Int, activityTitle: String) -> [ActivityEntry_] {
        if Pet.withId(petId, context: viewContext).archived_ == true {
            let request: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "activity_title_ = %@ and forPet_ = %@", activityTitle, Pet.withId(petId, context: viewContext)))
            return try! viewContext.fetch(request)
        } else if Pet.withId(petId, context: viewContext).archived_ == false &&  (Pet.withId(petId, context: viewContext).archived_activities_!.contains(activityTitle) == true) {
            let request: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "activity_title_ = %@ and forPet_ = %@", activityTitle, Pet.withId(petId, context: viewContext)))
            return try! viewContext.fetch(request)
        } else {
            let request: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "activity_title_ = %@ and forPet_ = %@ and archived_ = TRUE", activityTitle, Pet.withId(petId, context: viewContext)))
            return try! viewContext.fetch(request)
        }
        
        
    }
    
    func getPetWithId(id: Int) -> Pet {
    let request: NSFetchRequest<Pet> = Pet.fetchRequest(NSPredicate(format: "id_ = %@", NSNumber(value: id)))
            if let pet = try! viewContext.fetch(request).first {
                return pet
            } else {
                return Pet()
            }
        }
    
    //func unarchiveActivityEntry(timestamp: Date) {
    func unarchiveActivityEntry(id: UUID) {
        //let activityEntry = ActivityEntry_.withTimestamp(timestamp, context: viewContext)
        let activityEntry = ActivityEntry_.withId(id: id, context: viewContext)
        if activityEntry.archived_ == true {
           // ActivityEntry_.makeUnarchived(timestamp: timestamp, context: viewContext)
            ActivityEntry_.makeUnarchived(id: id, context: viewContext)
        }
        if ((Pet.withId(activityEntry.forPet_!.id, context: viewContext).archived_activities_?.contains(activityEntry.activity_title_!)) == true) {
            Pet.withId(activityEntry.forPet_!.id, context: viewContext).active_activities_?.append("\(activityEntry.activity_title_!) ")
            Pet.withId(activityEntry.forPet_!.id, context: viewContext).archived_activities_? = (Pet.withId(activityEntry.forPet_!.id, context: viewContext).archived_activities_?.replacingOccurrences(of: "\(activityEntry.activity_title_!) ", with: ""))!
        }
        if (Pet.withId(activityEntry.forPet_!.id, context: viewContext).archived_ == true) {
            Pet.makeUnarchived(id: activityEntry.forPet_!.id, context: viewContext)
        }
        saveContext()
    }
    
    func unarchiveActivity(petId: Int, activityTitle: String) {

        let request: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "activity_title_ = %@ and forPet_ = %@", activityTitle, Pet.withId(petId, context: viewContext)))
        for activityEntry in try! viewContext.fetch(request) {
            if activityEntry.archived_ == true {
                //ActivityEntry_.makeUnarchived(timestamp: activityEntry.timestamp, context: viewContext)
                ActivityEntry_.makeUnarchived(id: activityEntry.id, context: viewContext)
            }
        }
        
        if ((Pet.withId(petId, context: viewContext).archived_activities_?.contains(activityTitle)) == true) {
            Pet.withId(petId, context: viewContext).active_activities_?.append("\(activityTitle) ")
            Pet.withId(petId, context: viewContext).archived_activities_? = (Pet.withId(petId, context: viewContext).archived_activities_?.replacingOccurrences(of: "\(activityTitle) ", with: ""))!
        }
        
        if (Pet.withId(petId, context: viewContext).archived_ == true) {
            Pet.makeUnarchived(id: petId, context: viewContext)
        }
        saveContext()
    }
    
    
    
    func addNewPet(petInfo: PetInfo) -> Pet {
        Pet.update(from: petInfo, context: viewContext)
        saveContext()
        return Pet.withId(petInfo.id, context: viewContext)
    }
    
    func updatePetInfo(petInfo: PetInfo) {
        Pet.update(from: petInfo, context: viewContext)
        saveContext()
    }
    
   
    
    
    /*   let documentURL = fileManager.urls(for: .documentDirectory,
                                             in: FileManager.SearchPathDomainMask.userDomainMask).first
    let documentPath = documentURL?.path
    
    let fileNames = try? fileManager.contentsOfDirectory(atPath: "\(documentPath ?? "")")
    print("all files in cache: \(String(describing: fileNames))")
    for fileName in fileNames! {
        
        if (fileName.hasSuffix(".png") || fileName.hasSuffix(".mp4"))
        {
            print(fileName)
            let filePathName = "\(String(describing: documentPath))/\(fileName)"
            try? fileManager.removeItem(atPath: filePathName)
        }
    }*/
    
    //func deleteActivityEntry(timestamp: Date) {
    func deleteActivityEntry(id: UUID) {
        print("delete activity entry")
        print("deleting id: \(id)")
        let requestForActivityEntries: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "id_ = %@", id as CVarArg))
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first
        
        requestForActivityEntries.includesPropertyValues = false
        let entries = try? viewContext.fetch(requestForActivityEntries)
        for object in entries! {
            for fileName in object.media_path_!.split(separator: " ") {
                let filePathName = documentURL!.appendingPathComponent(String(fileName))
                try? fileManager.removeItem(at: filePathName)
            }
            viewContext.delete(object)
            print("deleted entry")
                
        }
        try? viewContext.save()
    }
    
    func deleteActivityForPet(id: Int, activityTitle: String) {
     //   print("I'm here for petid \()")
        let requestForActivityEntries: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "forPet_ = %@ and activity_title_ = %@", Pet.withId(id, context: viewContext), activityTitle))
        requestForActivityEntries.includesPropertyValues = false
        let entries = try? viewContext.fetch(requestForActivityEntries)
        for object in entries! {
            deleteActivityEntry(id: object.id)
            //viewContext.delete(object)
            print("deleted entry")
        }
        
        if ((Pet.withId(id, context: viewContext).active_activities_?.contains(activityTitle)) == true) {
            Pet.withId(id, context: viewContext).inactive_activities_?.append("\(activityTitle) ")
            Pet.withId(id, context: viewContext).active_activities_? = (Pet.withId(id, context: viewContext).active_activities_?.replacingOccurrences(of: "\(activityTitle) ", with: ""))!
        }
        
        try? viewContext.save()
    }
    
    func getAllPoosAndPeesForWalk(activityEntryInfo: ActivityEntryInfo_) -> [ActivityEntryInfo_] {
        let requestForActivityEntries: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "forPet_ = %@ and bikeRideId_ = %@", Pet.withId(activityEntryInfo.petId, context: viewContext), activityEntryInfo.withBikeRide!.id as CVarArg))
        requestForActivityEntries.includesPropertyValues = false
        let entries = try? viewContext.fetch(requestForActivityEntries)
        var entryInfos: [ActivityEntryInfo_] = []
        for entry in entries! {
           // print("got entry with \(entry.bikeRideId_ ?? nil)")
            entryInfos.append(ActivityEntryInfo_(activityEntry: entry))
        }
        
        return entryInfos
    }

    func deletePetWIthId(id: Int)
            {
        let requestForActivityEntries: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "forPet_ = %@", Pet.withId(id, context: viewContext)))
        requestForActivityEntries.includesPropertyValues = false
        let entries = try? viewContext.fetch(requestForActivityEntries)
        for object in entries! {
            deleteActivityEntry(id: object.id)
            //viewContext.delete(object)
            print("deleted entry")
        }
        
        let fetchRequest: NSFetchRequest<Pet> = Pet.fetchRequest(NSPredicate(format: "id_ = %@", NSNumber(value: id)))
        fetchRequest.includesPropertyValues = false
        let objects = try? viewContext.fetch(fetchRequest)
        for object in objects! {
            viewContext.delete(object)
        }
        try? viewContext.save()
    }
    
    func deleteAllActivityEntries() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityEntry_")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
                   {
                    try viewContext.execute(deleteRequest)
                    try viewContext.save()
                   }
        catch
        {
            print ("There was an error")
        }
    }
    
    func deleteAllPets() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Pet")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
                   {
                    try viewContext.execute(deleteRequest)
                    try viewContext.save()
                   }
        catch
        {
            print ("There was an error")
        }
    }
    
    
    func archivePetWithId(id: Int) {
        Pet.makeArchived(id: id, context: viewContext)        
        saveContext()
    }
    
    func unarchivePetWithId(id: Int) {
        Pet.makeUnarchived(id: id, context: viewContext)
        saveContext()
    }
    
  //  func archiveActivityEntry(activityEntryTimestamp: Date) {
    func archiveActivityEntry(id: UUID) {
       // ActivityEntry_.makeArchived(timestamp: activityEntryTimestamp, context: viewContext)
        ActivityEntry_.makeArchived(id: id, context: viewContext)
        saveContext()
    }

    func addActivityEntry(activityEntry: ActivityEntryInfo_) {
        ActivityEntry_.update(from: activityEntry, context: viewContext)
      //  print(activityEntry.bikeRideId ?? 0)
        saveContext()
    }
    
    func getBikeRide(id: UUID) -> BikeRide? {
        let request: NSFetchRequest<BikeRide> = BikeRide.fetchRequest(NSPredicate(format: "id_ = %@" , id as CVarArg))
        do {
            return try viewContext.fetch(request).first ?? nil
               } catch {
                   return nil
               }
    }
    
    
    func getActivityEntriesForPet(activityTitle: String, petId: Int) -> [ActivityEntry_]{
        let request: NSFetchRequest<ActivityEntry_> = ActivityEntry_.fetchRequest(NSPredicate(format: "activity_title_ = %@ and forPet_ = %@ and archived_ = FALSE" , activityTitle, Pet.withId(petId, context: viewContext)))
        do {
                   return try viewContext.fetch(request)
               } catch {
                   return []
               }
        }
    
    func storeBikeRide(locations: [CLLocation?], speeds: [CLLocationSpeed?], distance: Double, elevations: [CLLocationDistance?], startTime: Date, time: Double, id: UUID) {
       // let context = .viewContext
        
        var latitudes: [CLLocationDegrees] = []
        var longitudes: [CLLocationDegrees] = []
        var speedsValidated: [CLLocationSpeed] = []
        var elevationsValidated: [CLLocationDistance] = []
        
        for location in locations {
            // Only include coordinates where neither latitude nor longitude is nil
            if let currentLatitude = location?.coordinate.latitude {
                if let currentLongitude = location?.coordinate.longitude {
                    latitudes.append(currentLatitude)
                    longitudes.append(currentLongitude)
                }
            }
        }
        
        for speed in speeds {
            // Only store non nil speeds
            if let currentSpeed = speed {
                speedsValidated.append(currentSpeed)
            }
        }
        
        for elevation in elevations {
            // Only store non nil altitudes
            if let currentElevation = elevation {
                elevationsValidated.append(currentElevation)
            }
        }
        
        let newBikeRide = BikeRide(context: viewContext)
        newBikeRide.cyclingLatitudes = latitudes
        newBikeRide.cyclingLongitudes = longitudes
        newBikeRide.cyclingSpeeds = speedsValidated
        newBikeRide.cyclingDistance = distance
        newBikeRide.cyclingElevations = elevationsValidated
        newBikeRide.cyclingStartTime = startTime
        newBikeRide.cyclingTime = time
        // Default category
        newBikeRide.cyclingRouteName = "Uncategorized"
        newBikeRide.id = id
        newBikeRide.objectWillChange.send()
        print("trying to save")
        do {
            //try viewContext.save()
            saveContext()
            print("Bike ride saved")
            print(newBikeRide)
        //} catch {
        //    print(error.localizedDescription)
        }
    }
    
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
