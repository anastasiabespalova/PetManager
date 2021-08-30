//
//  PetActivitiesView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI

struct PetActivitiesView: View {
    @Binding var showPets: Bool
    @Binding var showActivities: Bool
    @Binding var showActivityHistory: Bool
    
    @EnvironmentObject var petViewModel: PetViewModel
    @Binding var petIndex: Int
    @Binding var selectedActivity: Activity
    
    @State var size = "Medium"
    @GestureState var isDragging = false
    
    @Binding var forward: Bool
    
    @State var viewId = UUID().uuidString
    
    @State var showDeletionPopup = false
    @State var showArchivePopup = false

    var body: some View {
       // ZStack {
            VStack {
               
                NavigationActivitiesHstack(showPets: $showPets,
                                           showActivities: $showActivities,
                                           forward: $forward)
                ScrollView {
                    VStack {
                        
                        ForEach(petViewModel.pets[petIndex].active_activities_array.indices, id: \.self){index in
                            // Card View...
                            ZStack {
                                Color.red
                                    .cornerRadius(20)
                                
                                Color.orange
                                    .cornerRadius(20)
                                    .padding(.trailing, 65)
                                
                                // Buttons...
                                HStack {
                                   Spacer()
                                    Button(action: {
                                        showArchivePopup = true
                                    }) {
                                        Image(systemName: "archivebox")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 65)
                                        
                                    }
                                    
                                    Button(action: {
                                        showDeletionPopup = true
                                    }) {
                                        Image(systemName: "trash")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 65)
                                        
                                    }
                                }
                                
                                
                                ActivityCardView(activity: petViewModel.pets[petIndex].active_activities_array[index],
                                                 isInFastAccess: false /*petViewModel.pets[petIndex].activitiesWithFastAccess.contains(
                                                    where: { $0?.title == petViewModel.pets[petIndex].active_activities_array[index].title })*/)
                                // drag gesture...
                                    .offset(x: petViewModel.pets[petIndex].active_activities_array[index].offset)
                                    .gesture(DragGesture()
                                                .updating($isDragging, body: {(value, state, _) in
                                                    state = true
                                                    onChanged(value: value, index: index)
                                                })
                                                .onEnded({ (value) in onEnd(value: value, index: index )
                                                    
                                                }))
                            }
                            .onTapGesture {
                                forward = true
                                selectedActivity = petViewModel.pets[petIndex].active_activities_array[index]
                                showActivityHistory = true
                                showActivities = false
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                        
                    }
                    .padding(.bottom, 100)
                }
            }
            .popup(isPresented: $showDeletionPopup, type: .`default`, closeOnTap: false) {
                DeletePopup(deletedObject: "\(selectedActivity.title) activity", showingPopup: $showDeletionPopup)
            }
        
            .popup(isPresented: $showArchivePopup, autohideIn: 1) {
                ArchivePopup()
            }
          /*  .if(forward){
                    $0.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                  }
        */
           // .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
       // }.id(viewId)
        
    }
    

    

    func addCart(index: Int) {

        // Closing after added...
        withAnimation {
            petViewModel.pets[index].offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int){
        if value.translation.width < 0 && isDragging {
            petViewModel.pets[petIndex].active_activities_array[index].offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value, index: Int){
        withAnimation{
            if -value.translation.width >= 100 {
                petViewModel.pets[petIndex].active_activities_array[index].offset = -130
            } else {
                petViewModel.pets[petIndex].active_activities_array[index].offset = 0
            }
        }
    }
}

struct ActivityCardView: View {
    
    var activity: Activity
    
    @State var isInFastAccess: Bool
    
    
    var body: some View {
        HStack{
            Image(activity.title)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
               // .frame(width: UIScreen.main.bounds.width / 3.2, height: 80)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(activity.title.capitalizingFirstLetter())
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Spacer()
                        if isInFastAccess {
                            HStack {
                                Text("Fast access")
                                Image.init(systemName: "checkmark")
                            }
                                .font(.caption)
                                .foregroundColor(.gray)
                           
                        }
                        
                    }
                    
                    Text(activity.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    /*Text("Some text")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)*/
            }
           
            }
            Spacer(minLength: 0)
        }
        .frame(height: 90)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
      //  .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
        
    }
}



struct NavigationActivitiesHstack: View {
    @Binding var showPets: Bool
    @Binding var showActivities: Bool
    
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
                    showPets = true
                    showActivities = false
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(width: 30)
                Text("Pets activities")
                    .font(.largeTitle)
                   // .fontWeight(.bold)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "plus")
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

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
