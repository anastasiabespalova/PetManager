//
//  Color.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 21.08.2021.
//
import SwiftUI

extension Color {
    //static let background = Color.init(red: 82/255, green: 82/255, blue: 191/255)
    static let purple = Color.init(red: 82/255, green: 82/255, blue: 191/255)
    static let background = Color.init(red: 246/255, green: 250/255, blue: 254/255)
    static let lightPurple = Color.init(red: 93/255, green: 91/255, blue: 198/255)
    static let orangeColor = Color.init(red: 240/255, green: 125/255, blue: 81/255)
    static let purpleGradient = LinearGradient(gradient: Gradient(colors: [lightPurple, background]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    static let orangeGradient = LinearGradient(gradient: Gradient(colors: [orangeColor, background]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let darkPurple = Color.init(red: 53/255, green: 46/255, blue: 138/255)
}
