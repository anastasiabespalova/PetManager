//
//  FoodPopups.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 24.08.2021.
//

import SwiftUI
import AVFoundation


class PlayViewModel {
    private var audioPlayer: AVAudioPlayer!
    func play() {
        let sound = Bundle.main.path(forResource: "sounds/1100", ofType: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        self.audioPlayer.play()
    }
}

//MARK: -Detailed

struct DetailedFoodPopup: View {
    @Binding var showingPopupForFoodDetailed: Bool
    @State var text: String = ""
    let vm = PlayViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                
                Button(action: {
                    self.showingPopupForFoodDetailed = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                .offset(y: -40)
                .frame(width: 250, height: 40, alignment: .topTrailing)
                .background(Color.white)

                Image("food")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 100, height: 100)
            }
            

            Text("Food")
                .foregroundColor(.black)
                .fontWeight(.bold)

            Text("Enter meal data or serving weight. You can check the history of feeding in the pet journal")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250)
            
            TextEditorView(text: $text)
                .frame(width: 250, height: 125)
            
            Button(action: {
                
                if text == "1100" {
                    self.vm.play()
                }
                
                self.showingPopupForFoodDetailed = false
            }) {
                    Text("Bon Appetit!")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())


        }
        
        //.padding(EdgeInsets(top: 70, leading: 20, bottom: 40, trailing: 20))
        .frame(width: 300, height: 450)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}

//MARK: -Undetailed

struct UndetailedFoodPopup: View {

    var body: some View {

         VStack(spacing: 10) {
             Image("food")
                 .resizable()
                 .aspectRatio(contentMode: ContentMode.fit)
                 .frame(width: 100, height: 100)

             Text("MMM tasty!!")
                 .foregroundColor(.black)
                 .fontWeight(.bold)

             Text("Meal info saved")
                 .font(.system(size: 12))
                 .foregroundColor(.black)
                 .multilineTextAlignment(.center)

         }
         .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
         .frame(width: 250, height: 260)
         .background(Color.white)
         .cornerRadius(15.0)
         .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
     }
}
