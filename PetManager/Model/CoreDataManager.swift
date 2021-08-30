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

    func getAllPets() -> [Pet] {
        let request: NSFetchRequest<Pet> = Pet.fetchRequest()
        do {
                   return try viewContext.fetch(request)
               } catch {
                   return []
               }
        }
    
    func addNewPet(petInfo: PetInfo) -> Pet {
        Pet.update(from: petInfo, context: viewContext)
        saveContext()
        return Pet.withId(petInfo.id, context: viewContext)
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

}
