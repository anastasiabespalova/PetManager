//
//  ActivityEntryView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 03.09.2021.
//

import SwiftUI
import AVKit
import CoreLocation

struct ActivityEntryView: View {
    @ObservedObject var mediaItems = PickedMediaItems()
    @StateObject var activityEntryViewModel: ActivityEntryViewModel
    
    @State private var showSheet = false
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldOpenCamera = false
    @State private var media_path: String = ""
    
    let documentURL = FileManager.default.urls(for: .documentDirectory,
                                               in: FileManager.SearchPathDomainMask.userDomainMask).first
    var body: some View {
        
        if (activityEntryViewModel.entryInfo.activity_title == "walk" && activityEntryViewModel.entryInfo.withBikeRide != nil) {
            mapActivityView
        } else {
            commonActivityView
        }
        
    }
    @State private var selectedTabIndex = 0
    var mapActivityView: some View {
        VStack {
            SlidingTabView(selection: $selectedTabIndex,tabs: ["Details", "Walk track"])
            if selectedTabIndex == 0 {
                commonActivityView
            } else {
                MapTrackView()
                    .ignoresSafeArea()
                    .environmentObject(activityEntryViewModel)
                Spacer()
                
            }
            Spacer()
        }
        .frame(alignment: .top)
    }
    
    var commonActivityView: some View {
        List {
            Section(header: Text("Date"))  {
                
                HStack{
                  //  Text("Date ")
                     //   .fontWeight(.bold)
                    DatePicker(
                        "",
                        selection: $activityEntryViewModel.entryInfo.timestamp,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
                
                .padding()
            }
            
            if (activityEntryViewModel.entryInfo.activity_title == "walk" && activityEntryViewModel.entryInfo.withBikeRide != nil) {
                Section(header: Text("Statistics")) {
                    
                }
            }
            
            Section(header: Text("Description")) {
                VStack {
                    TextEditorView(text: $activityEntryViewModel.entryInfo.description)
                        .frame(height: 200)
                    
                }
            }
            
            Section(header: HStack {
                Text("Media items")
                Spacer()
                Button(action: {
                    shouldPresentActionScheet = true
                }
                ) {
                    Text("Add")
                        .frame(width: 40)
                }
                .buttonStyle(GradientButtonStyle())}) {
                   // TabView {
                    
                        ForEach(activityEntryViewModel.entryInfo.media_path.split(separator: " "), id: \.self) { photoKey in
                            if photoKey.contains(".png") == true {
                                Image(uiImage: mediaItems.retrieveImage(forKey: documentURL!.appendingPathComponent(String(photoKey)).absoluteString)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else if photoKey.contains(".mp4") == true || photoKey.contains(".mov") == true{
                                VideoPlayer(player: AVPlayer(url: documentURL!.appendingPathComponent(String(photoKey))))
                                    .scaledToFill()
                                   // .resizable()
                                   // .aspectRatio(contentMode: .fit)
                            }
                            
                        }
            }
            
        }
        
        .fullScreenCover(isPresented: $showImagePicker) {
                ImagePicker(isShown: $showImagePicker, image: $image)
                    .edgesIgnoringSafeArea(.all)
                    .onDisappear() {
                        if image != nil {
                            mediaItems.items.append(PhotoPickerModel(with: image!))
                            image = nil
                        }
                    }
        }
        
        .sheet(isPresented: $showSheet, content: {
            PhotoPicker(mediaItems: mediaItems) { didSelectItem in
                 media_path += mediaItems.store(timestamp: activityEntryViewModel.entryInfo.timestamp)
              //  petViewModel.addActivityEntry(activityEntry: ActivityEntryInfo_(activity_title: activity.title, description: text, petId: petId, timestamp: timestamp, media_path: media_path))
                showSheet = false
            }
        })
            
        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to load media"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                    self.showImagePicker = true
                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                    self.showSheet = true
                }), ActionSheet.Button.cancel()])
        }
        
        .onDisappear() {
            activityEntryViewModel.entryInfo.media_path.append(media_path)
            activityEntryViewModel.update()
        }
        .navigationTitle("Activity entry")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(InsetGroupedListStyle())
    }
   
}

