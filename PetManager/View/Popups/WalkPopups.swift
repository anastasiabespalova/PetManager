//
//  WalkPopups.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI
import ConfettiSwiftUI

struct DetailedWalkPopup: View {
    
    @EnvironmentObject var petViewModel: PetViewModel
    
    @Binding var moreThenOnePet: Bool

    @State var rating: Int = 0
    
    @Binding var showingPopupForWalkDetailed: Bool
    @State var text: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
    
    var body: some View {
       

            VStack(spacing: 10) {
                
                ZStack {
                    Button(action: {
                        self.showingPopupForWalkDetailed = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .offset(y: -20)
                    .frame(width: 280, height: 40, alignment: .topTrailing)
                    .background(Color.white)
                    

                    Image("walk")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(width: 100, height: 100)
                }

                Text("Walk finished")
                    .foregroundColor(.black)
                    .fontWeight(.bold)

                Text("You can rate or describe your walk and load photos")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 300)
                
                RatingView(rating: $rating)
                
               
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
                    self.showingPopupForWalkDetailed = false
                    petViewModel.petsOnWalk.removeAll()
                    moreThenOnePet = false
                 }) {
                         Text("Time to have a rest!")
                             .font(.system(size: 16))
                             .foregroundColor(.white)
                             .fontWeight(.bold)
                     
                 }
                .offset(y: 8)
                 .buttonStyle(GradientButtonStyle())
                
               
            }
            .modifier(DismissingKeyboard())
            .frame(width: 350, height: 550)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
           
    }
    
   
}

struct DetailedWalkPopupWithoutModel: View {
    
    @State var rating: Int = 0
    
    @Binding var showingPopup: Bool
    @State var text: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
    
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
                    

                    Image("walk")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(width: 100, height: 100)
                }

                Text("Walk finished")
                    .foregroundColor(.black)
                    .fontWeight(.bold)

                Text("You can rate or describe your walk and load photos")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(width: 300)
                
                RatingView(rating: $rating)
                
               
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
                         Text("Time to have a rest!")
                             .font(.system(size: 16))
                             .foregroundColor(.white)
                             .fontWeight(.bold)
                     
                 }
                .offset(y: 8)
                 .buttonStyle(GradientButtonStyle())
                
               
            }
            .modifier(DismissingKeyboard())
            .frame(width: 350, height: 550)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
           
    }
    
   
}

struct UndetailedPooPeeWalkPopup: View {
    @State var selections: [Int] = []
    
    @EnvironmentObject var petViewModel: PetViewModel
    
    @Binding var showingPopup: Bool
    @State var text: String = ""
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
                .offset(y: -40)
                .frame(width: 250, height: 40, alignment: .topTrailing)
                .background(Color.white)

                Image(activity.title)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 100, height: 100)
            }
            
            Text("Great!")
                .foregroundColor(.black)
                .fontWeight(.bold)

            Text("Select a pet or pets who did it")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250)
            
            List {
                ForEach(petViewModel.petsOnWalk, id: \.id) { item in
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
            .frame(width: 200, height: 100)
            
            Button(action: {
                self.showingPopup = false
                self.selections.removeAll()
            }) {
                    Text("Done")
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

//MARK: -Detailed for a walk
struct DetailedPooPeeWalkPopup: View {
    @State var selections: [Int] = []
    
    @EnvironmentObject var petViewModel: PetViewModel
    
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
                .frame(width: 250, height: 40, alignment: .topTrailing)
                .background(Color.white)

                Image(activity.title)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 100, height: 100)
            }
            
            Text("Great!")
                .foregroundColor(.black)
                .fontWeight(.bold)

            Text("Something wrong? You can describe it or take a photo or video for vet. Select a pet or pets who did it")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 250)
            
            List {
                ForEach(petViewModel.petsOnWalk, id: \.id) { item in
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
            .frame(width: 200, height: 100)
            
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
                self.selections.removeAll()
            }) {
                    Text("Done")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                
            }
            .buttonStyle(GradientButtonStyle())


        }
        .frame(width: 350, height: 550)
        //.frame(minWidth: 270, idealWidth: 270, maxWidth: 270, minHeight: 450, idealHeight: 450, maxHeight: 450, alignment: .center)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
    }
}


