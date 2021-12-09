//
//  WalkPopups.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI

struct DetailedWalkPopup: View {
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var locationManager: LocationViewModel

    @State var rating: Int = 0
    @State var text: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
  
    var body: some View {
       

            VStack(spacing: 10) {
                
                ZStack {

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
                    
                    petWalkViewModel.showingPopupForWalkEnded = false
                    petWalkViewModel.moreThenOnePet = false
                    let timestamp = Date()
                    let media_path =  mediaItems.store(timestamp: timestamp)
                    
                    for pet in petWalkViewModel.petsOnWalk{
                        petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(activity_title: "walk", description: text, petId: pet.id, timestamp: timestamp, media_path: media_path, bikeRideId: locationManager.id))
                    }
                   
                    petWalkViewModel.petsOnWalk.removeAll()
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

struct DetailedWalkPopupWithoutModelForActivityHistoryView: View {
    @EnvironmentObject var activityHistoryViewModel: ActivityHistoryViewModel
    @State var petId: Int
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
                    activityHistoryViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(activity_title: "walk", description: text, petId: petId))
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
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @State var petId: Int
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
                    petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(activity_title: "walk", description: text, petId: petId))
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
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var locationManager: LocationViewModel
    
    @State var text: String = ""
    let activity: Activity

    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                
                Button(action: {
                    petWalkViewModel.showingUndetailedWalkPooPopup = false
                    petWalkViewModel.showingUndetailedWalkPeePopup = false
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
                ForEach(petWalkViewModel.petsOnWalk, id: \.id) { item in
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
                petWalkViewModel.showingUndetailedWalkPooPopup = false
                petWalkViewModel.showingUndetailedWalkPeePopup = false
                for id in self.selections {
                    print("id: \(id)")
                    let timestamp = Date()
                    petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(
                                                        activity_title: activity.title,
                                                       // description: text,
                                                        petId: id,
                                                       // petId: petWalkViewModel.petsOnWalk[petId].id,
                                                        timestamp: timestamp,
                                                        //media_path: media_path,
                                                        latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                                        longitude: (locationManager.lastLocation?.coordinate.longitude)!,
                                                        bikeId: locationManager.id))
                }
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
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var locationManager: LocationViewModel
    
    //@Binding var showingPopup: Bool
    @State var text: String = ""
    @ObservedObject var mediaItems = PickedMediaItems()
    let activity: Activity
    
    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                
                Button(action: {
                    petWalkViewModel.showingDetailedWalkPooPopup = false
                    petWalkViewModel.showingDetailedWalkPeePopup = false
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
                ForEach(petWalkViewModel.petsOnWalk, id: \.id) { item in
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
                petWalkViewModel.showingDetailedWalkPooPopup = false
                petWalkViewModel.showingDetailedWalkPeePopup = false
                for id in self.selections {
                   //self.showingPopup = false
                    let timestamp = Date()
                    let media_path =  mediaItems.store(timestamp: timestamp)
                    petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(
                                                        activity_title: activity.title,
                                                        description: text,
                                                        petId: id,
                                                        timestamp: timestamp,
                                                        media_path: media_path,
                                                        latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                                        longitude: (locationManager.lastLocation?.coordinate.longitude)!,
                                                        bikeId: locationManager.id))
                }
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


struct UndetailedPopupForWalk: View {
    let activity: Activity
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var locationManager: LocationViewModel
    
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
        /* .onAppear() {
            if petWalkViewModel.petsOnWalk.count != 0 {
                petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(
                                                    activity_title: activity.title,
                                                    petId: petWalkViewModel.petsOnWalk[0].id,
                                                    latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                                    longitude: (locationManager.lastLocation?.coordinate.longitude)!,
                                                    bikeId: locationManager.id))
                print("i'm here")
            } else {
                print("i'm there")
            }
            
         }*/
         .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
         .frame(width: 250, height: 250)
         .background(Color.white)
         .cornerRadius(15.0)
         .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
         
    }
}

struct DetailedDescriptionPhotoPopupForWalk: View {
    @Binding var showingPopup: Bool
    //@State var petId: Int
    
    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var locationManager: LocationViewModel
    
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
                    let timestamp = Date()
                    let media_path =  mediaItems.store(timestamp: timestamp)
                    petWalkViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(
                                                        activity_title: activity.title,
                                                        description: text,
                                                        petId: petWalkViewModel.petsOnWalk[0].id,
                                                        timestamp: timestamp,
                                                        media_path: media_path,
                                                        latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                                        longitude: (locationManager.lastLocation?.coordinate.longitude)!,
                                                        bikeId: locationManager.id))
                    
                 }) {
                    Text(activity.popupButton)
                             .font(.system(size: 16))
                             .foregroundColor(.white)
                             .fontWeight(.bold)
                     
                 }
                .offset(y: 8)
                // .offset(y: -75)
                .frame(maxWidth: .infinity)
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


