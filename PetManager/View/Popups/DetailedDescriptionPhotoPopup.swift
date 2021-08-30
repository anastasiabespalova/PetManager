//
//  DetailedDescriptionPhotoPopup.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import Foundation
import SwiftUI


struct DetailedDescriptionPhotoPopup: View {
    @Binding var showingPopup: Bool
    @State var text: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
    
    let activity: Activity
    
    var body: some View {
            VStack(spacing: 10) {
                
                ZStack {
                    Button(action: {
                        self.showingPopup = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .offset(y: -20)
                    .frame(width: 280, height: 40, alignment: .topTrailing)
                    .background(Color.white)
                    

                    Image(activity.title)
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(width: 100, height: 100)
                }

                Text(activity.popupDetailedTitle)
                    .foregroundColor(.black)
                    .fontWeight(.bold)

                Text(activity.popupDetailedDescription)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .frame(width: 300)
                
                TextEditorView(text: $text)
                    .frame(width: 330, height: 125)
                
                
                HStack {
                    TakePhotoView()
                        .environmentObject(mediaItems)
                    
                    MediaScrollView()
                        .environmentObject(mediaItems)
                }
                .frame(width: 300, height: 65)
                    
                Button(action: {
                     self.showingPopup = false
                 }) {
                    Text(activity.popupButton)
                             .font(.system(size: 16))
                             .foregroundColor(.white)
                             .fontWeight(.bold)
                     
                 }
                .offset(y: 8)
                // .offset(y: -75)
               //  .frame(width: 270, height: 40, alignment: .topTrailing)
                 .buttonStyle(GradientButtonStyle())
                
               
            }
            .modifier(DismissingKeyboard())
            .frame(width: 350, height: 500)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
           
    }
    
   
}
