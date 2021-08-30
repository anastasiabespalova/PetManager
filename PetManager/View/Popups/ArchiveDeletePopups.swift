//
//  ArchiveDeletePopups.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import Foundation
import SwiftUI

struct DeletePopup: View {
    
    @State var deletedObject: String
    
    @Binding var showingPopup: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                
                Button(action: {
                    self.showingPopup = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                .offset(y: -40)
                .frame(width: 250, height: 40, alignment: .topTrailing)
                .background(Color.white)

                Image("trash")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 100, height: 100)
            }
            

            Text("Are you sure you want to delete?")
                .foregroundColor(.black)
                .fontWeight(.bold)

            Text("You are about to delete data about \(deletedObject). This data will never, ever be available. Do you really want it?")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250)
        
        HStack {
            Button(action: {
                self.showingPopup = false
            }) {
                    Text("Cancel ")
                        .font(.system(size: 16))
                        .foregroundColor(.orangeColor)
                        .fontWeight(.bold)
                        .frame(width: 70)
                
            }
            .buttonStyle(WhiteGradientButtonStyle())
            
            
            Button(action: {
                self.showingPopup = false
            }) {
                    Text("Delete")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 70)
                
            }
            .buttonStyle(GradientButtonStyle())
            
        }
            
            


        }
        
        //.padding(EdgeInsets(top: 70, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 300, height: 300)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}


struct ArchivePopup: View {

    
    var body: some View {

         VStack(spacing: 10) {
            Image("archive")
                 .resizable()
                 .aspectRatio(contentMode: ContentMode.fit)
                 .frame(width: 100, height: 100)

            Text("Archived!")
                 .foregroundColor(.black)
                 .fontWeight(.bold)

            Text("You can restore archived elements in settings")
                 .font(.system(size: 12))
                 .foregroundColor(.black)
                 .multilineTextAlignment(.center)

         }
         .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
         .frame(width: 250, height: 250)
         .background(Color.white)
         .cornerRadius(15.0)
         .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}
