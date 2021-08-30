//
//  WalkActivitiesMenu.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

import SwiftUI

struct WalkActivitiesMenu: View {
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    @Binding var walkStarted: Bool
    @Binding var moreThenOnePet: Bool
    
    @Binding var showingUndetailedWalkPooPopup: Bool
    @Binding var showingUndetailedPooPopup: Bool
    @Binding var showingDetailedWalkPooPopup: Bool
    @Binding var showingDetailedPooPopup: Bool
    @Binding var showingUndetailedWalkPeePopup: Bool
    @Binding var showingUndetailedPeePopup: Bool
    @Binding var showingDetailedWalkPeePopup: Bool
    @Binding var showingDetailedPeePopup: Bool
    
    var body: some View {
        HStack() {
            SmallConnectionView(imageName: Activity(title: "poo").title)
            .onTapGesture {
                impactMed.impactOccurred()
                if walkStarted && moreThenOnePet {
                    showingUndetailedWalkPooPopup = true
                } else if walkStarted {
                    showingUndetailedPooPopup = true
                }
            }
            .onLongPressGesture {
                impactMed.impactOccurred()
                if walkStarted && moreThenOnePet {
                    showingDetailedWalkPooPopup = true
                } else if walkStarted {
                    showingDetailedPooPopup = true
                }
            }
            SmallConnectionView(imageName: Activity(title: "pee").title)
            .onTapGesture {
                impactMed.impactOccurred()
                if walkStarted && moreThenOnePet {
                    showingUndetailedWalkPeePopup = true
                } else if walkStarted {
                    showingUndetailedPeePopup = true
                }
            }
            .onLongPressGesture {
                impactMed.impactOccurred()
                if walkStarted && moreThenOnePet {
                    showingDetailedWalkPeePopup = true
                } else if walkStarted {
                    showingDetailedPeePopup = true
                }
            }
            
            SmallConnectionView(imageName: "camera")
            .onTapGesture {
                impactMed.impactOccurred()
            }
            .onLongPressGesture {
                impactMed.impactOccurred()
            }
        }
    }
}


