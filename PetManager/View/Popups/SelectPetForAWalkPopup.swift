//
//  SelectPetForAWalkPopup.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI



struct SelectPetForAWalkPopup: View {
    
    @State var selections: [Int] = []
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    
    
    //@Binding var walkStarted: Bool
   // @Binding var moreThenOnePet: Bool
   // @Binding var showingPopupForPetWalkSelection: Bool
    @State var text: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                
                Button(action: {
                    petWalkViewModel.showingPopupForPetWalkSelection = false
                    selections.removeAll()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                .offset(y: -40)
                .frame(width: 250, height: 40, alignment: .topTrailing)
                .background(Color.white)

                Image("walk")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 100, height: 100)
            }
            
            Text("Going for a walk")
                .foregroundColor(.black)
                .fontWeight(.bold)

            Text("Select pets that are going for a walk now")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250)
            
            List {
                ForEach(petWalkViewModel.pets, id: \.id) { item in
                    MultipleSelectionRow(title: item.name, isSelected: self.selections.contains(item.id), image: item.defaultImage) {
                        if self.selections.contains(item.id) {
                            self.selections.removeAll(where: { $0 == item.id })
                        }
                        else {
                            self.selections.append(item.id)
                        }
                    }
                }
            }
            .frame(width: 200, height: 80)
            
            Button(action: {
                petWalkViewModel.showingPopupForPetWalkSelection = false
                for item in selections {
                    for pet in petWalkViewModel.pets {
                        if pet.id == item {
                            petWalkViewModel.petsOnWalk.append(pet)
                            print("appended")
                        }
                    }
                }
                if petWalkViewModel.petsOnWalk.count > 1 {
                    petWalkViewModel.walkStarted = true
                    petWalkViewModel.moreThenOnePet = true
                } else if petWalkViewModel.petsOnWalk.count == 1 {
                    petWalkViewModel.walkStarted = true
                }
                selections.removeAll()
            }) {
                    Text("Let's go!")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())


        }
        
        .frame(minWidth: 270, idealWidth: 270, maxWidth: 270, minHeight: 350, idealHeight: 350, maxHeight: 350, alignment: .center)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}


struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var image: String
    var action: () -> Void
   

    var body: some View {
        Button(action: self.action) {
            HStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 20, height: 20)
                Text(self.title)
                    Spacer()
                    Image(systemName: self.isSelected ? "checkmark.circle.fill" : "circle")
                    //Image(systemName: "checkmark")
               // }
            }
        }
    }
}
