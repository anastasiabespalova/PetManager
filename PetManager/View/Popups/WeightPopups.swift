//
//  WeightPopups.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 24.08.2021.
//

import SwiftUI

let array = ["kg", "grams", "lb", "ounce", "st"]


//MARK: -Detailed

struct DetailedWeightPopup: View {
    @Binding var showingPopupForWeightDetailed: Bool
    @State private var selection = "kg"
    @State var userInput = ""
    
    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                
                Button(action: {
                    self.showingPopupForWeightDetailed = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                .offset(y: -40)
                .frame(width: 250, height: 40, alignment: .topTrailing)
                .background(Color.white)

                Image("weight")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 100, height: 100)
            }
            

            Text("Weight")
                .foregroundColor(.black)
                .fontWeight(.bold)

            Text("It's time to weight! Select your measure and enter the value")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250)
            
            HStack {
                TextField("0", text: $userInput)
                           //Style your Text Field
                           .padding()
                    .background(Color.lightGreyColor)
                    .cornerRadius(5.0)
                           .padding()
                    .keyboardType(.decimalPad)
                    .font(.system(size: 20))
                    .frame(width: 200)
                
                
                
                Picker(selection, selection: $selection) {
                    ForEach(array, id: \.self) { word in
                        Text(word).tag(word)
                    }
                }
                .foregroundColor(.orangeColor)
               // .frame(width: 50)
                //.animation(nil)
                .pickerStyle(MenuPickerStyle())
                
            }
            
            Button(action: {
                
                
                self.showingPopupForWeightDetailed = false
            }) {
                    Text("Good job!")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())


        }
        
        //.padding(EdgeInsets(top: 70, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 300, height: 400)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}
