//
//  PetActivityEntry.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI

struct PetActivityEntryView: View {
    @Binding var showActivityHistory: Bool
    @Binding var showActivityHistoryEntry: Bool
    
    @Binding var activityEntryIndex: Int
    
    @Binding var forward: Bool
    
    @EnvironmentObject var activityHistoryViewModel: ActivityHistoryViewModel
    
    
    var body: some View {
        
        VStack {
           
            NavigationActivityEntryHstack(showActivityHistory: $showActivityHistory,
                                          showActivityHistoryEntry: $showActivityHistoryEntry,
                                          activity: activityHistoryViewModel.activity,
                                          forward: $forward)
            ScrollView {
            Text("date: \(activityHistoryViewModel.activityEntries[activityEntryIndex].date)")
            }
            
        }
        //.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        
    }
    
    
}

struct NavigationActivityEntryHstack: View {
    @Binding var showActivityHistory: Bool
    @Binding var showActivityHistoryEntry: Bool
    
    @State var activity: Activity
    
    @Binding var forward: Bool
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 115)
                .foregroundColor(Color.white)
                .opacity(0.2)
                
                
            HStack {
                Button(action: {
                    forward = false
                    showActivityHistory = true
                    showActivityHistoryEntry = false
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(width: 30)
                Text("\(activity.title.capitalizingFirstLetter()) entry")
                    .font(.largeTitle)
                   // .fontWeight(.bold)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "pencil")
                      //  .font(.title)
                        .foregroundColor(.white)
                }
                .buttonStyle(GradientButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top)
           // .padding(.bottom, 10)
        }
        .ignoresSafeArea()
        //.background(BackgroundBlurView())
       // .backgroundColor = .clear
        .shadow(radius: 10)
        .frame(height: 60)
       // .background(Color.clear)
        //.opacity(0.3)
        
    }
}

