//
//  EditPetInfoView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 27.08.2021.
//

import SwiftUI

struct EditPetInfoView: View {
    // @ObservedObject var petEditViewModel = PetEditViewModel()
    @StateObject var petViewModel: PetViewModel
    var body: some View {
        
        List {
            ForEach(petViewModel.pets, id: \.self) { pet in
                NavigationLink(destination: EditConcretePetView(
                                petEditViewModel: PetEditViewModel(petInfo: pet), activities: formActivityStateArrayFrom(petInfo: pet))
                               //.environmentObject(PetEditViewModel(petInfo: petViewModel.pets[index]))
                               .onDisappear() {
                               petViewModel.updateActivePets()}) {
                    HStack{
                        // Image(petViewModel.pets[index].defaultImage)
                        Image(uiImage: pet.photo!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        //.resizable()
                        //.aspectRatio(contentMode: .fit)
                        // .frame(width: UIScreen.main.bounds.width / 3.2, height: 70)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(pet.name)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            HStack {
                                Text("Gender: \(pet.gender)")
                                Spacer()
                                if pet.neutred == true {
                                    Text("Neutred")
                                } else {
                                    Text("Not neutred")
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Text("Birthday: ")
                                Text(pet.date_birth, style: .date)
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            if pet.chip_id != "" {
                                Text("Chip id: \(pet.chip_id)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(5)
                        Spacer(minLength: 0)
                    }
                }
                
            }
            
            .onMove(perform: move)
            .onDelete(perform: removeRows)
        }
        .onAppear() {
            petViewModel.updateActivePets()
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Pets list", displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        
        
    }
    
    func removeRows(at offsets: IndexSet) {
        petViewModel.deletingIndex = offsets.first!
        if petViewModel.deletingIndex >= 0 {
            petViewModel.deletePetWIthId(id: petViewModel.pets[petViewModel.deletingIndex].id)
        }
        petViewModel.deletingIndex = -1
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        petViewModel.pets.move(fromOffsets: source, toOffset: destination)
    }
}

func formActivityStateArrayFrom(petInfo: PetInfo) -> [(Activity, Bool)]  {
    var activityStateArray: [(Activity, Bool)] = []
    for activity in petInfo.active_activities_array {
        activityStateArray.append((activity, true))
    }
    for activity in petInfo.inactive_activities_array {
        activityStateArray.append((activity, false))
    }
    for activity in petInfo.archived_activities_array {
        activityStateArray.append((activity, false))
    }
    return activityStateArray
}

struct EditConcretePetView: View {
    @StateObject var petEditViewModel: PetEditViewModel
    @State private var isOn = false
    @State var isEditing = false
    
    
    @State var activities: [(Activity, Bool)]
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var body: some View {
        
        List {
            Section {
                VStack {
                    VStack {
                        //  Image(uiImage: pet.photo!)
                        Image(uiImage: petEditViewModel.petInfo.photo!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .onTapGesture { self.shouldPresentActionScheet = true }
                            .sheet(isPresented: $shouldPresentImagePicker) {
                                /* SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker) */
                                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: $petEditViewModel.petInfo.photo, isPresented: self.$shouldPresentImagePicker)
                            }
                        
                        Text("Tap to change photo")
                            .font(.caption)
                    }
                    .padding()
                    
                    HStack {
                        Text("Name ")
                        // .fontWeight(.heavy)
                        Spacer()
                        TextField(petEditViewModel.petInfo.name, text: $petEditViewModel.petInfo.name)
                            //Style your Text Field
                            .padding()
                            .background(Color.lightGreyColor)
                            .cornerRadius(5.0)
                            .padding()
                            .font(.system(size: 20))
                        // .frame(width: 200)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Birthday ")
                        Spacer()
                        DatePicker(
                            "",
                            //selection: $date,
                            selection: $petEditViewModel.petInfo.date_birth,
                            displayedComponents: [.date]
                        )
                        
                    }
                    Divider()
                    
                    HStack {
                        Text("Gender")
                        Spacer()
                        Picker(selection: $petEditViewModel.petInfo.gender, label: Text(""), content: {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                            Text("Other").tag("Other")
                        }).pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Chip id")
                        Spacer()
                        // TextField(chip_id == "" ? "Enter chip id here" : chip_id, text: $chip_id)
                        TextField(petEditViewModel.petInfo.chip_id == "" ? "Enter chip id here" : petEditViewModel.petInfo.chip_id, text: $petEditViewModel.petInfo.chip_id)
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
                        Picker(selection: $petEditViewModel.petInfo.neutred, label: Text(""), content: {
                            Text("Yes").tag(true)
                            Text("No").tag(false)
                        }).pickerStyle(SegmentedPickerStyle())
                        /*  Picker(selection: $neutred, label: Text(""), content: {
                         Text("Yes").tag(0)
                         Text("No").tag(1)
                         }).pickerStyle(SegmentedPickerStyle())
                         .onChange(of: neutred){ value in
                         if value == 0 {
                         pet.neutred = true
                         } else {
                         pet.neutred = false
                         }
                         }*/
                        
                    }
                }
                
                
            }
            
            Section(header: HStack {
                Text("All posible activities")
                Spacer()
                Button(action: {
                    self.isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                        .frame(width: 40)
                }
                .buttonStyle(GradientButtonStyle())
            }) {
                ForEach(activities.indices, id: \.self) { index in
                    HStack {
                        Image(activities[index].0.title)
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(activities[index].0.title.capitalizingFirstLetter())
                        Spacer()
                        if index < 6 && activities[index].1 {
                            Text("Fast access")
                                .font(.caption)
                                .frame(alignment: .trailing)
                        }
                        
                        Toggle("", isOn: $activities[index].1)
                            .onChange(of: activities[index].1) { value in
                                petEditViewModel.updateActivities(activities: activities)
                               /* if value == true {
                                    if petEditViewModel.petInfo.inactive_activities.contains(activities[index].0.title) == true {
                                        petEditViewModel.petInfo.inactive_activities_array.removeAll(where: {$0.title == activities[index].0.title})
                                        petEditViewModel.petInfo.inactive_activities = petEditViewModel.petInfo.inactive_activities.replacingOccurrences(of: "\(activities[index].0.title) ", with: "")
                                        petEditViewModel.petInfo.active_activities_array.append(activities[index].0)
                                        petEditViewModel.petInfo.active_activities.append("\(activities[index].0.title) ")
                                    } else if petEditViewModel.petInfo.archived_activities.contains(activities[index].0.title) == true {
                                        petEditViewModel.petInfo.archived_activities_array.removeAll(where: {$0.title == activities[index].0.title})
                                        petEditViewModel.petInfo.archived_activities = petEditViewModel.petInfo.archived_activities.replacingOccurrences(of: "\(activities[index].0.title) ", with: "")
                                        petEditViewModel.petInfo.active_activities_array.append(activities[index].0)
                                        petEditViewModel.petInfo.active_activities.append("\(activities[index].0.title) ")
                                    }
                                } else {
                                    if petEditViewModel.petInfo.active_activities.contains(activities[index].0.title) {
                                        petEditViewModel.petInfo.active_activities_array.removeAll(where: {$0.title == activities[index].0.title})
                                        petEditViewModel.petInfo.active_activities = petEditViewModel.petInfo.active_activities.replacingOccurrences(of: "\(activities[index].0.title) ", with: "")
                                        petEditViewModel.petInfo.archived_activities_array.append(activities[index].0)
                                        petEditViewModel.petInfo.archived_activities.append("\(activities[index].0.title) ")
                                    }
                                    
                                }*/
                            }
                    }
                    .frame(height: 40)
                    /* Text(pet.activities[index].description)
                     .font(.caption)*/
                    //}
                }
                .onMove(perform: move)
                .deleteDisabled(true)
            }
            
        }
        
        
        
    
    //.padding(.bottom, 40)
    .navigationBarTitle("\(petEditViewModel.petInfo.name) settings")
    .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
    .listStyle(InsetGroupedListStyle())
    .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
    self.shouldPresentImagePicker = true
    self.shouldPresentCamera = true
    }), ActionSheet.Button.default(Text("Photo Library"), action: {
    self.shouldPresentImagePicker = true
    self.shouldPresentCamera = false
    }), ActionSheet.Button.cancel()])
    }
    .onDisappear() {
    print("disappear")
    print(petEditViewModel.petInfo.name)
    petEditViewModel.updatePetInfo()
    }
    
}


func move(from source: IndexSet, to destination: Int) {
    activities.move(fromOffsets: source, toOffset: destination)
    var new_active_activity_string  = ""
    var new_active_activity_array: [Activity] = []
    for activity in activities {
        if activity.1 == true {
            new_active_activity_string += "\(activity.0.title) "
            new_active_activity_array.append(Activity(title: activity.0.title))
        }
    }
    petEditViewModel.petInfo.active_activities = new_active_activity_string
    petEditViewModel.petInfo.active_activities_array = new_active_activity_array
    
}

}


struct ActivityEditView: View {
    var body: some View {
        Text("activity")
    }
}
