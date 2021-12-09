//
//  PetManagerApp.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 21.08.2021.
//

import SwiftUI

extension UserDefaults {

    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }

}

@main
struct PetManagerApp: App {
   // let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .onAppear() {
                     let userDefaults = UserDefaults.standard
                    if !userDefaults.valueExists(forKey: "MaxID") {
                        UserDefaults.standard.set(1, forKey: "Key")
                    }
                    //fullDeletion()
                }
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
              }
        //WindowGroup {
          //  ContentView()
           //     .environment(\.managedObjectContext, persistenceController.container.viewContext)
       // }
    }
}

func fullDeletion() {
    CoreDataManager.shared.deleteAllActivityEntries()
    CoreDataManager.shared.deleteAllPets()
    let fileManager = FileManager.default
    
     let documentURL = fileManager.urls(for: .documentDirectory,
                                             in: FileManager.SearchPathDomainMask.userDomainMask).first
    
   // let documentURL = fileManager.urls(for: .documentDirectory,
                          //                   in: FileManager.SearchPathDomainMask.userDomainMask).first
    let documentPath = documentURL?.path
    let fileNames = try? fileManager.contentsOfDirectory(atPath: "\(documentPath ?? "")")
    print("all files in cache: \(String(describing: fileNames))")
    for fileName in fileNames! {
        
        if (fileName.hasSuffix(".png") || fileName.hasSuffix(".mp4") || fileName.hasSuffix(".mov"))
        {
            let filePathName = documentURL!.appendingPathComponent(fileName)
            try! fileManager.removeItem(at: filePathName)
        }
    }
    let files = try? fileManager.contentsOfDirectory(atPath: "\(String(describing: documentPath))")
    print("all files in cache after deleting images: \(String(describing: files))")
}


