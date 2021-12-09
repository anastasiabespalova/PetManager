//
//  FoodTapView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 21.08.2021.
//

import SwiftUI

struct ConnectionView: View {
    // MARK: - PROPERTIES
    let imageName: String
    
    // MARK: - BODY
    var body: some View {
        if imageName != "" {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .shadow(radius: 10)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                   // .clipShape(Circle())
                    
            }
          //  .overlay(Circle().stroke(Color.black, lineWidth: 3))
        }
    }
}

struct SmallConnectionView: View {
    // MARK: - PROPERTIES
    let imageName: String
    
    // MARK: - BODY
    var body: some View {
        if imageName != "" {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 65, height: 65)
                    //.shadow(radius: 10)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                   // .clipShape(Circle())
                    
            }
           // .overlay(Circle().stroke(Color.black, lineWidth: 3))
        } 
    }
}
/*
struct LargeConnectionView: View {
    // MARK: - PROPERTIES
    let imageName: String
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
               // .clipShape(Circle())
                .shadow(radius: 10)
              //  .overlay(Circle().stroke(Color.blue, lineWidth: 10))
            
            
        }
       
    }
}

*/

struct LargeConnectionView: View {
    // MARK: - PROPERTIES
    let image: UIImage
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            //Image(imageName)
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            
              //  .overlay(Circle().stroke(Color.blue, lineWidth: 10))
            
            
        }
       
    }
}

