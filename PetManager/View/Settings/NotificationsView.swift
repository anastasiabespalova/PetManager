//
//  NotificationsView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 27.08.2021.
//
import SwiftUI

var demoData = ["Phil Swanson", "Karen Gibbons", "Grant Kilman", "Wanda Green"]

struct NotificationsView : View {
    @State var selectKeeper = Set<String>()

    var body: some View {
       // NavigationView {
            List(demoData, id: \.self, selection: $selectKeeper){ name in
                Text(name)
            }
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Selection Demo \(selectKeeper.count)"))
       // }
    }
}
