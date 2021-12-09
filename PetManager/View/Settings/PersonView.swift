//
//  PersonView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI


struct PersonView: View {
    @ObservedObject var petViewModel = PetViewModel()
   // @EnvironmentObject var petViewModel: PetViewModel
    var body: some View {
           NavigationView {
               List {
                
                    HStack {
                        Image("paw")
                            .resizable()
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome to settings")
                                .foregroundColor(.purple)
                                .fontWeight(.bold)
                            Text("Explore and expand the use of the app")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                
                        }
                        .multilineTextAlignment(.leading)
                    }
                    
                    Section(header: Text("Pet management")) {
                        NavigationLink(destination: ArchiveView()
                                        .environmentObject(petViewModel)) {
                            Label("Archive", systemImage: "archivebox")
                                .accentColor(.orange)
                        }
                        NavigationLink(destination: EditPetInfoView(petViewModel: petViewModel)
                                        .onAppear() {
                                            petViewModel.updateActivePets()
                                        }
                                        /*.environmentObject(petViewModel)*/) {
                            Label("Edit pet and activities", systemImage: "pencil")
                                .accentColor(.blue)
                        }
                        NavigationLink(destination: NotificationsView()) {
                            Label("Notifications", systemImage: "bell.badge")
                                .accentColor(.red)
                        }
                    }

                 
                Section(header: Text("Other")) {
                    Label("App usage", systemImage: "questionmark.circle")
                        .accentColor(.purple)
                    Label("Credits", systemImage: "person.2.fill")
                        .accentColor(.purple)
                }
                
                
                      
               }
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                           ToolbarItem(placement: .principal) {
                               HStack {
                                   Image(systemName: "person.crop.circle")
                                   Text("Profile and settings").font(.headline)
                               }
                           }
                       }
               .listStyle(InsetGroupedListStyle())
           }
           .navigationViewStyle(StackNavigationViewStyle())
           
       
    }
}
