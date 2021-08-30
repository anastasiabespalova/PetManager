//
//  VomitPopups.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 24.08.2021.
//

import SwiftUI
import AVKit

//MARK: -Detailed



struct DetailedVomitPopup: View {
    @Binding var showingPopupForVomitDetailed: Bool
    @State var text: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
    
    var body: some View {
            VStack(spacing: 10) {
                
                ZStack {
                    Button(action: {
                        self.showingPopupForVomitDetailed = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .offset(y: -20)
                    .frame(width: 280, height: 40, alignment: .topTrailing)
                    .background(Color.white)
                    

                    Image("vomit")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(width: 100, height: 100)
                }

                Text("Vomit")
                    .foregroundColor(.black)
                    .fontWeight(.bold)

                Text("Ugggh :( You can describe it or take a photo or video for vet")
                    .font(.system(size: 16))
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
                     self.showingPopupForVomitDetailed = false
                 }) {
                         Text("Done")
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

struct UndetailedVomitPopup: View {

    var body: some View {

         VStack(spacing: 10) {
             Image("vomit")
                 .resizable()
                 .aspectRatio(contentMode: ContentMode.fit)
                 .frame(width: 100, height: 100)

             Text("Ugggh!!")
                 .foregroundColor(.black)
                 .fontWeight(.bold)

             Text("Hope it was by accident")
                 .font(.system(size: 12))
                 .foregroundColor(.black)
                 .multilineTextAlignment(.center)

         }
         .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
         .frame(width: 250, height: 280)
         .background(Color.white)
         .cornerRadius(15.0)
         .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}
