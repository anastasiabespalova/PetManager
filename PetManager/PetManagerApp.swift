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
                }
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
              }
        //WindowGroup {
          //  ContentView()
           //     .environment(\.managedObjectContext, persistenceController.container.viewContext)
       // }
    }
}
