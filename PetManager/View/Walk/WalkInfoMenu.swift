//
//  WalkInfoMenu.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI

struct WalkStartInfoMenu: View {
    @Binding var walkStarted: Bool
    @Binding var showingPopupForPetWalkSelection: Bool
    
    @EnvironmentObject var petViewModel: PetViewModel
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                Circle()
                    .foregroundColor(.purple)
                    .frame(width: 60, height: 60)
            }
            .onTapGesture {
                if petViewModel.pets.count > 1 {
                    showingPopupForPetWalkSelection = true
                } else {
                    if petViewModel.pets.count == 1 {
                        petViewModel.petsOnWalk.append(petViewModel.pets.first!)
                    }
                }
            }
        }
        
    }
}

struct WalkProcessInfoMenu: View {
    @EnvironmentObject var petViewModel: PetViewModel
    @Binding var walkStarted: Bool
    @Binding var showWalkEndedPopup: Bool
    
    @State var meters: Int = 0
    @State var seconds: Int = 0
    @State var minutes: Int = 0
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 100, height: 50)
                    .opacity(0.6)
                Text("\(meters) m")
                    
            }
            
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.orange)
                    .frame(width: 50, height: 50)
            }
            .onTapGesture {
                walkStarted = false
                showWalkEndedPopup = true
            }
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 100, height: 50)
                    .opacity(0.6)
                Text("\(minutes) min")
            }
        }
    }
}


