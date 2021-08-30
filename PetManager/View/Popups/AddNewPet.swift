//
//  AddNewPet.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 28.08.2021.
//

import SwiftUI

let allActivites: [Activity] = [Activity(title: "weight"), Activity(title: "parasites"), Activity(title: "vaccine"), Activity(title: "pee"), Activity(title: "pills"), Activity(title: "walk"), Activity(title: "training"), Activity(title: "cage"), Activity(title: "vomit"), Activity(title: "washing"), Activity(title: "food"), Activity(title: "poo"), Activity(title: "claws"), Activity(title: "water")]

struct AddNewPet: View {
    @EnvironmentObject var petViewModel: PetViewModel
    @Binding var showPopup: Bool

    @State var firstPage = true

    var body: some View {
        VStack {
            AddNewPetConstructor(/*petInfo: $petInfo, */showPopup: $showPopup, firstPage: $firstPage)
                    .environmentObject(petViewModel)
        }
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 350, height: 600)
        .background(Color.white)
        .cornerRadius(15.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}


struct AddNewPetConstructor: View {
    @EnvironmentObject var petViewModel: PetViewModel
    
    @Binding var showPopup: Bool
    @Binding var firstPage: Bool
    
    @State var name: String = ""
    @State var chip_id: String = ""
    @State var selectedGender = 0
    @State var neutred = 0
    @State var birthday = Date()
    @State var selections: [Int] = []
    @State var active_activities: String = ""
    @State private var date = Date()
    
    var body: some View {
        if firstPage {
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
                    
                    VStack{
                        Image("dog")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.orangeColor, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Text("Tap to change photo")
                            .font(.caption)
                    }
                    
                }
                
                HStack {
                    Text("Name ")
                    Spacer()
                    TextField(name == "" ? "Enter name here" : name, text: $name)
                        //Style your Text Field
                        .padding()
                        .background(Color.lightGreyColor)
                        .cornerRadius(5.0)
                        .padding()
                        .font(.system(size: 20))
                }
                
                Divider()
                
                HStack {
                    Text("Birthday ")
                    Spacer()
                    DatePicker(
                        "",
                        selection: $birthday,
                        displayedComponents: [.date]
                    )
                    
                }
                Divider()
                
                HStack {
                    Text("Gender")
                    Spacer()
                    Picker(selection: $selectedGender, label: Text(""), content: {
                        Text("Male").tag(0)
                        Text("Female").tag(1)
                        Text("Other").tag(2)
                    }).pickerStyle(SegmentedPickerStyle())
                }
                
                Divider()
                
                HStack {
                    Text("Chip id")
                    Spacer()
                    TextField(chip_id == "" ? "Enter chip id here" : chip_id, text: $chip_id)
                        .padding()
                        .background(Color.lightGreyColor)
                        .cornerRadius(5.0)
                        .padding()
                        .font(.system(size: 20))
                }
                
                Divider()
                
                HStack {
                    Text("Neutered")
                    Spacer()
                    Picker(selection: $neutred, label: Text(""), content: {
                        Text("Yes").tag(0)
                        Text("No").tag(1)
                    }).pickerStyle(SegmentedPickerStyle())
                }
            }
            Button(action: {
                self.firstPage = false
            }) {
                Text("Next")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())
            .padding()
        }
        } else {
            VStack {
                Spacer()
                VStack {
                    ZStack {
                        
                        Button(action: {
                            self.showPopup = false
                            self.firstPage = true
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
                            VStack {
                                Text("You can change selected activities")
                                Text("and its settings in profile")
                            }
                            .font(.caption)
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
                   
                    var gender = ""
                    if selectedGender == 0 {
                        gender = "Male"
                    } else if selectedGender == 1 {
                        gender = "Female"
                    } else {
                        gender = "Other"
                    }
                    
                    for selection in self.selections {
                        active_activities += allActivites[selection].title
                        active_activities += " "
                        
                    }

                    let petInfo = PetInfo(name: name, chip_id: chip_id, dateOfBirth: birthday, gender: gender, neutred: neutred == 0 ? true : false, active_activities: active_activities)

                    petViewModel.addNewPetWith(petInfo: petInfo)
                    
                   // petViewModel.deleteAllPets()
                    
                    self.showPopup = false
                    self.firstPage = true
                   
                }) {
                    Text("Done")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                }
                .buttonStyle(GradientButtonStyle())
                .padding()
            }
        }
    }
}

/*
struct SecondPageAddNewPet: View {
    @EnvironmentObject var petViewModel: PetViewModel
    @State private var date = Date()
    @Binding var showPopup: Bool
    
    @State var selections: [Int] = []
    @State var active_activities: String = ""
    @Binding var firstPage: Bool
    
    @Binding var petInfo: PetInfo
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack {
                    
                    Button(action: {
                        self.showPopup = false
                        self.firstPage = true
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
                        VStack {
                            Text("You can change selected activities")
                            Text("and its settings in profile")
                        }
                        .font(.caption)
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
                    
                    print("current active activities: \(active_activities)")
                }
                
                print("after for active activities: \(active_activities)")
                petInfo.active_activities = active_activities
                print("active activities: \(petInfo.active_activities)")
                
                
                petInfo.timestamp = date //TODO: add other activities
                print("inactive activities: \(petInfo.inactive_activities)")
                
                petViewModel.addNewPetWith(petInfo: petInfo)
                
                
               

                petInfo = PetInfo()
                
                //petViewModel.deleteAllPets()
                
                self.showPopup = false
                self.firstPage = true
               
            }) {
                Text("Done")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())
            .padding()
        }
    }
}
*/
