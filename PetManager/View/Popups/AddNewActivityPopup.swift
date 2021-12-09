//
//  AddNewActivityPopup.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 09.09.2021.
//

import SwiftUI

struct AddNewActivityPopup: View {
    @State var selections: [Int] = []
    @State var active_activities: String = ""
    @State var inactive_activities: String = ""
    @State var archived_activities: String = ""
    @Binding var showPopup: Bool
    @StateObject var activityListViewModel: ActivityListViewModel
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack {
                    Button(action: {
                        self.showPopup = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .offset(y: -20)
                    .frame(width: 280, height: 40, alignment: .topTrailing)
                    .background(Color.white)
                    
                    VStack {
                        VStack {
                            Text("Select activities ")
                            Text("you want to track")
                        }
                        .font(.headline)
                    }
                    
                }
                List {
                    ForEach(allActivites.indices, id: \.self) { index in
                        MultipleSelectionRow(title: allActivites[index].title.capitalizingFirstLetter(), isSelected: self.selections.contains(index), image: allActivites[index].title) {
                            if self.selections.contains(index) {
                                self.selections.removeAll(where: { $0 == index })
                            }
                            else {
                                self.selections.append(index)
                            }
                        }
                    }
                }
                .frame(width: 300, height: 400)
                
            }
            Button(action: {
                
                for selection in self.selections {
                    active_activities += allActivites[selection].title
                    active_activities += " "
                }
                
                var inactive_activities = ""
                for activity_index in allActivites.indices {
                    if !self.selections.contains(activity_index) {
                        if activityListViewModel.petInfo.active_activities_array.contains(allActivites[activity_index]) {
                            archived_activities += allActivites[activity_index].title
                            archived_activities += " "
                        }
                        
                        else {
                            inactive_activities += allActivites[activity_index].title
                            inactive_activities += " "
                        }
                    }
                }
                
                activityListViewModel.petInfo.active_activities = active_activities
                activityListViewModel.petInfo.inactive_activities = inactive_activities
                activityListViewModel.petInfo.archived_activities = archived_activities
                
                activityListViewModel.updatePetInfo(petInfo: activityListViewModel.petInfo)
                activityListViewModel.update()
                
                
                self.showPopup = false
                self.selections.removeAll()
                
            }) {
                Text("Done")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())
            .padding()
        }
        .onAppear() {
            for index in allActivites.indices {
                if activityListViewModel.petInfo.active_activities_array.contains(allActivites[index]) {
                    selections.append(index)
                }
            }
           
        }
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 350, height: 550)
        .background(Color.white)
        .cornerRadius(15.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        
        
    }
}

