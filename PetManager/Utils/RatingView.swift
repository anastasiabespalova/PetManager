//
//  RatingView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI

struct RatingView: View {

    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    //var offImage: Image?
    //var onImage = Image(systemName: "star.fill")
    var offImage = Image("star_contour")
    var onImage = Image("star")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}
