//
//  SwiftUIView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 21.08.2021.
//

import SwiftUI
import AVFoundation



struct CircleNavigation: View {
    @Binding var pet: PetInfo
   // @Binding var pet: Pet__
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    // all possible popups
    @State var showingPopupForFoodDetailed = false
    @State var showingPopupForFoodUndetailed = false
    
    @State var showingPopupForVomitDetailed = false
    @State var showingPopupForVomitUndetailed = false
    
    @State var showingPopupForPooDetailed = false
    @State var showingPopupForPooUndetailed = false
    
    
    
    
    // TODO: for training (like for walk) and for customizable medicines
    @State var showingPopupUndetailed = false
    @State var showingPopupDetailedDescriptionPhoto = false
    
    @State var showingPopupForWalkDetailed = false
    @State var showingPopupForWeightDetailed = false
    
    
    @State var selectedActivity: Activity = Activity(title: "poo")
    
    
    @State var text: String = ""
 
    var body: some View {

            VStack {
                Text("\(pet.name)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                ZStack {
                    
                    LargeConnectionView(imageName: pet.defaultImage)
                    
                    HStack {
                        if pet.active_activities_array.count > 0 {
                        ConnectionView(imageName: pet.active_activities_array[0].title)
                            .rotationEffect(.degrees(-30))
                            .onTapGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity:  pet.active_activities_array[0], isTapLong: false)
                                selectedActivity = pet.active_activities_array[0]
                            }
                            .onLongPressGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[0], isTapLong: true)
                                selectedActivity = pet.active_activities_array[0]
                            }
                        }
                        Spacer()
                        if pet.active_activities_array.count > 1 {
                        ConnectionView(imageName: pet.active_activities_array[1].title)
                            .rotationEffect(.degrees(-30))
                            .onTapGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[1], isTapLong: false)
                                selectedActivity = pet.active_activities_array[1]
                            }
                            .onLongPressGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[1], isTapLong: true)
                                selectedActivity = pet.active_activities_array[1]
                            }
                        }
                    } //: HSTACK
                    .rotationEffect(.degrees(30))
                    
                    HStack {
                        if pet.active_activities_array.count > 2 {
                        ConnectionView(imageName: pet.active_activities_array[2].title)
                            .rotationEffect(.degrees(-90))
                            .onTapGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[2], isTapLong: false)
                                selectedActivity = pet.active_activities_array[2]
                            }
                            .onLongPressGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[2], isTapLong: true)
                                selectedActivity = pet.active_activities_array[2]
                            }
                        }
                        Spacer()
                        if pet.active_activities_array.count > 3 {
                            ConnectionView(imageName: pet.active_activities_array[3].title)
                                .rotationEffect(.degrees(-90))
                                .onTapGesture {
                                    impactMed.impactOccurred()
                                    selectPopupForActivity(activity: pet.active_activities_array[3], isTapLong: false)
                                    selectedActivity = pet.active_activities_array[3]
                                }
                                .onLongPressGesture {
                                    impactMed.impactOccurred()
                                    selectPopupForActivity(activity: pet.active_activities_array[3], isTapLong: true)
                                    selectedActivity = pet.active_activities_array[3]
                                }
                        }
                       
                    } //: HSTACK
                    .rotationEffect(.degrees(90))
                    
                    HStack {
                        if pet.active_activities_array.count > 4 {
                        ConnectionView(imageName: pet.active_activities_array[4].title)
                            .rotationEffect(.degrees(30))
                            .onTapGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[4], isTapLong: false)
                                selectedActivity = pet.active_activities_array[4]
                            }
                            .onLongPressGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[4], isTapLong: true)
                                selectedActivity = pet.active_activities_array[4]
                            }
                        }
                        Spacer()
                        if pet.active_activities_array.count > 5 {
                        ConnectionView(imageName: pet.active_activities_array[5].title)
                            .rotationEffect(.degrees(30))
                            .onTapGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[5], isTapLong: false)
                                selectedActivity = pet.active_activities_array[5]
                            }
                            .onLongPressGesture {
                                impactMed.impactOccurred()
                                selectPopupForActivity(activity: pet.active_activities_array[5], isTapLong: true)
                                selectedActivity = pet.active_activities_array[5]
                            }
                        }
                            
                    } //: HSTACK
                    .rotationEffect(.degrees(-30))
                    
                } //: ZSTACK
                .frame(width: 340, height: 340)
                
                Text("Other needs")
                    .foregroundColor(.white)
                
                ScrollView(.horizontal) {
                    HStack {
                        if pet.active_activities_array.count > 6 {
                        ForEach(6..<pet.active_activities_array.count) { index in
                            SmallConnectionView(imageName: pet.active_activities_array[index].title)
                              //  .rotationEffect(.degrees(-90))
                                .onTapGesture {
                                    impactMed.impactOccurred()
                                    selectPopupForActivity(activity: pet.active_activities_array[index], isTapLong: false)
                                    selectedActivity = pet.active_activities_array[index]
                                    
                                }
                                .onLongPressGesture {
                                    impactMed.impactOccurred()
                                    selectPopupForActivity(activity: pet.active_activities_array[index], isTapLong: true)
                                    selectedActivity = pet.active_activities_array[index]
                                }
                        }
                        }
                    }
                }
                .padding()
                
            }
            
        // TODO: all possible popups for propeties
            
        .popup(isPresented: $showingPopupDetailedDescriptionPhoto, type: .`default`, closeOnTap: false) {
            DetailedDescriptionPhotoPopup(showingPopup: $showingPopupDetailedDescriptionPhoto,
                                            activity: selectedActivity)
        }
            .popup(isPresented: $showingPopupUndetailed, autohideIn: 1) {
                UndetailedPopup(activity: selectedActivity)
            }
        
            //Weight popups
        .popup(isPresented: $showingPopupForWeightDetailed, type: .`default`, closeOnTap: false) {
            DetailedWeightPopup(showingPopupForWeightDetailed: $showingPopupForWeightDetailed)
        }
        
            .popup(isPresented: $showingPopupForWalkDetailed, type: .`default`, closeOnTap: false) {
                DetailedWalkPopupWithoutModel(showingPopup: $showingPopupForWalkDetailed)
            }

            
    /*        //Food Popups
        .popup(isPresented: $showingPopupForFoodDetailed, type: .`default`, closeOnTap: false) {
            DetailedFoodPopup(showingPopupForFoodDetailed: $showingPopupForFoodDetailed)
        }
        .popup(isPresented: $showingPopupForFoodUndetailed, autohideIn: 1) {
            UndetailedFoodPopup()
        }
            
            //Vomit Popups
        .popup(isPresented: $showingPopupForVomitDetailed, type: .`default`, closeOnTap: false) {
            DetailedVomitPopup(showingPopupForVomitDetailed: $showingPopupForVomitDetailed)
        }
        .popup(isPresented: $showingPopupForVomitUndetailed, autohideIn: 1) {
            UndetailedVomitPopup()
        }
        
            //Poo popups
        .popup(isPresented: $showingPopupForPooDetailed, type: .`default`, closeOnTap: false) {
            DetailedPooPopup(showingPopupForPooDetailed: $showingPopupForPooDetailed)
        }
        .popup(isPresented: $showingPopupForPooUndetailed, autohideIn: 1) {
            UndetailedPooPopup()
        }*/
    
       
        
    }
    
    
    // MARK: -Popups
    
    func selectPopupForActivity(activity: Activity?, isTapLong: Bool) {
        guard let activity = activity else {
            return
        }
        
        switch activity.title {
        case "food", "claws", "cage", "training", "parasites", "pee", "pills", "poo", "vaccine", "vomit", "washing", "water":
            if activity.detailedView || isTapLong == true{
                showingPopupDetailedDescriptionPhoto = true
            } else {
                showingPopupUndetailed = true
            }
        case "walk":
            if activity.detailedView || isTapLong == true{
                showingPopupForWalkDetailed = true
            } else {
                showingPopupUndetailed = true
            }
        case "weight":
            showingPopupForWeightDetailed = true
        default:
            showingPopupUndetailed = true
        }
    }
    
   /* func selectPopupForActivity(activity: Activity?, isTapLong: Bool) {
        guard let activity = activity else {
            return
        }
        
        switch activity.title {
        case "food":
            if activity.detailedView || isTapLong == true{
                showingPopupForFoodDetailed = true
            } else {
                showingPopupForFoodUndetailed = true
            }
        case "claws": fallthrough
        case "cage": fallthrough
        case "training": fallthrough
        case "parasites":
            showingPopupDetailedDescriptionPhoto = true
        case "pee": fallthrough
        case "pills": fallthrough
        case "poo": 
            if activity.detailedView || isTapLong == true{
                showingPopupForPooDetailed = true
            } else {
                showingPopupForPooUndetailed = true
            }
        case "vaccine": fallthrough
        case "vomit":
            if activity.detailedView || isTapLong == true{
                showingPopupForVomitDetailed = true
            } else {
                showingPopupForVomitUndetailed = true
            }
        case "walk": fallthrough
        case "washing": fallthrough
        case "water": fallthrough
        case "weight":
            showingPopupForWeightDetailed = true
        default:
            showingPopupForFoodDetailed = true
        }
    }
*/
}



struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .clipShape(Capsule())
            .foregroundColor(Color.white)
            .padding()
            //.background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
             .background(Color.orangeColor)
            .cornerRadius(20.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}

struct WhiteGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .clipShape(Capsule())
            //.foregroundColor(Color.white)
            .padding()
            //.background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
           //  .background(Color.orangeColor)
            .cornerRadius(20.0)
            .foregroundColor(Color.orangeColor)
            
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.orangeColor, lineWidth: 2))
            
            
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
