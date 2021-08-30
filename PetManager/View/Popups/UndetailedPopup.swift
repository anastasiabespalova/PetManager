//
//  UndetailedPopup.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI

struct UndetailedPopup: View {
    let activity: Activity
    
    var body: some View {

         VStack(spacing: 10) {
            Image(activity.title)
                 .resizable()
                 .aspectRatio(contentMode: ContentMode.fit)
                 .frame(width: 100, height: 100)

            Text(activity.popupUndetailedTitle)
                 .foregroundColor(.black)
                 .fontWeight(.bold)

            Text(activity.popupUndetailedDescription)
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

