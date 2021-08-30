//
//  EditPetInfoView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 27.08.2021.
//

import SwiftUI

struct EditPetInfoView: View {
    @ObservedObject var petViewModel = PetViewModel()
    
    var body: some View {
        
        List {
            ForEach(petViewModel.pets.indices, id: \.self) { index in
                NavigationLink(destination: EditConcretePetView(pet: $petViewModel.pets[index])) {
                    HStack{
                        Image(petViewModel.pets[index].defaultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 3.2, height: 70)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(petViewModel.pets[index].name)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            Text("Here you can place description of a pet")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Some text")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                        }
                        Spacer(minLength: 0)
                    }
                }
                
            }
            .onMove(perform: move)
            .onDelete(perform: removeRows)
        }
        
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Pets list", displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        
        
    }
    
    func removeRows(at offsets: IndexSet) {
        petViewModel.pets.remove(atOffsets: offsets)
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        petViewModel.pets.move(fromOffsets: source, toOffset: destination)
    }
}


struct EditConcretePetView: View {
    @State private var isOn = false

    @Binding var pet: PetInfo
    @State private var date = Date()
    
    @State var isEditing = false
    
    @State var selectedGender = 0
    @State var neutred = 0
    
    @State var chip_id: String = ""

    var body: some View {

        List {
            Section {
                VStack {
                    VStack {
                        
                            Image(pet.defaultImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.orangeColor, lineWidth: 4))
                                .shadow(radius: 10)
                        
                        Text("Tap to change photo")
                            .font(.caption)
                    }
                    .padding()
                   
                    HStack {
                        Text("Name ")
                           // .fontWeight(.heavy)
                        Spacer()
                        TextField(pet.name, text: $pet.name)
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
                            selection: $date,
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
                ForEach(pet.active_activities_array.indices, id: \.self) { index in
                    // Text(pet.activities[index].title)
                    NavigationLink(destination: ActivityEditView()) {
                        //VStack {
                            HStack {
                                Image(pet.active_activities_array[index].title)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    Text(pet.active_activities_array[index].title.capitalizingFirstLetter())
                                    Spacer()
                                    if index < 6 {
                                        Text("Fast access")
                                            .font(.caption)
                                            .frame(alignment: .trailing)
                                    }
                               
                                
                                Toggle("", isOn: $isOn)
                                          //  .toggleStyle(.button)
                                          //  .tint(.mint)
                            }
                            .frame(height: 40)
                           /* Text(pet.activities[index].description)
                                .font(.caption)*/
                        //}
                    }
                }
                
                .onMove(perform: move)
                .deleteDisabled(true)
               // .onDelete(perform: removeRows)
            }
           
            
        }
        .navigationBarTitle("\(pet.name) settings")
        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
        .listStyle(InsetGroupedListStyle())
        
        
        
        
    }
    
    func removeRows(at offsets: IndexSet) {
        pet.active_activities_array.remove(atOffsets: offsets)
    }
    
    
    func move(from source: IndexSet, to destination: Int) {
        pet.active_activities_array.move(fromOffsets: source, toOffset: destination)
    }
    
}


struct ActivityEditView: View {
    var body: some View {
        Text("activity")
    }
}
