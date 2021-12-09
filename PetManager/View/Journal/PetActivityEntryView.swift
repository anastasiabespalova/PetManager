//
//  PetActivityEntry.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 26.08.2021.
//

import SwiftUI
import Foundation
import AVKit

struct PetActivityEntryView: View {
    //  @Binding var activityEntryInfo: ActivityEntryInfo_
    @Binding var activityEntryInfo_: ActivityEntryInfo_
    @Binding var showActivityHistory: Bool
    @Binding var showActivityHistoryEntry: Bool
    
    let documentURL = FileManager.default.urls(for: .documentDirectory,
                                               in: FileManager.SearchPathDomainMask.userDomainMask).first
    
    @Binding var activityEntryIndex: Int
    
    @Binding var forward: Bool
    
    @EnvironmentObject var activityHistoryViewModel: ActivityHistoryViewModel
    @State var index = 0
    @ObservedObject var mediaItems = PickedMediaItems()
    var body: some View {
        
        VStack {
            
            NavigationActivityEntryHstack(showActivityHistory: $showActivityHistory,
                                          showActivityHistoryEntry: $showActivityHistoryEntry,
                                          activity: activityHistoryViewModel.activity,
                                          forward: $forward)
            ScrollView {
                ZStack {
                    
                    Color.white
                    /* RoundedRectangle(cornerRadius: 15)
                     .fill(Color.white)
                     .padding()
                     
                     */
                    VStack {
                        
                       
                        
                        HStack {
                            
                            
                            
                            DatePicker(
                                "",
                                //selection: $date,
                                //selection: $activityHistoryViewModel.activityEntries_[activityEntryIndex].timestamp,
                                selection: $activityEntryInfo_.timestamp,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            Spacer()
                            VStack {
                                TakePhotoView()
                                    .environmentObject(mediaItems)
                                
                                Spacer()
                                Text("Add more media")
                                    .font(.caption)
                            }
                            .frame(height: 65)
                            .padding()
                        }
                        .padding(.top, 30)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        
                        VStack {
                            
                            //TextEditorView(text: $activityHistoryViewModel.activityEntries_[activityEntryIndex].description)
                            TextEditorView(text: $activityEntryInfo_.description)
                                .frame(height: 200)
                            
                        }
                        .padding()
                        
                        //ZStack {
                        // Color.black
                       // if activityHistoryViewModel.activityEntries_[activityEntryIndex].media_path != "" {
                        if activityEntryInfo_.media_path != "" {
                        VStack{
                            Text("Media data")
                                .font(.caption)
                            TabView {
                                
                                //ForEach(activityHistoryViewModel.activityEntries_[activityEntryIndex].media_path.split(separator: " "), id: \.self) { photoKey in
                                ForEach(activityEntryInfo_.media_path.split(separator: " "), id: \.self) { photoKey in
                                    if photoKey.contains(".png") == true {
                                        
                                        Image(uiImage: mediaItems.retrieveImage(forKey: documentURL!.appendingPathComponent(String(photoKey)).absoluteString)!)
                                            //Image(uiImage: mediaItems.retrieveImage(forKey: String(photoKey))!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        //.frame(width: 350)
                                        //.padding()
                                    } else if photoKey.contains(".mp4") == true {
                                        VideoPlayer(player: AVPlayer(url: documentURL!.appendingPathComponent(String(photoKey))))
                                        // .frame(width: 400)
                                        // .padding()
                                    }
                                    
                                }//.padding()
                                //.frame(width: 450)
                                /*ForEach(0..<30) { i in
                                 ZStack {
                                 Color.black
                                 Text("Row: \(i)").foregroundColor(.white)
                                 }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                 }
                                 .padding(.all, 10)*/
                            }
                            
                            .frame(width: 350, height: 500)
                            .tabViewStyle(PageTabViewStyle())
                            // }
                            //  .padding()
                        }
                        .padding(.bottom, 85)
                        }
                        //LazyHStack {
                        // PageView()
                        //.environmentObject(activityHistoryViewModel)
                        //}/
                        
                        
                        
                        
                    }
                    //.padding()
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                //.padding()
                
                /*    PagingView(index: $index.animation(), maxIndex: activityHistoryViewModel.activityEntries_[activityEntryIndex].media_path.split(separator: " ").count - 1) {
                 ForEach(activityHistoryViewModel.activityEntries_[activityEntryIndex].media_path.split(separator: " "), id: \.self) { photoKey in
                 Image(uiImage: mediaItems.retrieveImage(forKey: String(photoKey))!)
                 .resizable()
                 .scaledToFill()
                 }
                 }
                 .aspectRatio(contentMode: .fit)
                 .clipShape(RoundedRectangle(cornerRadius: 15))
                 .frame(width: 350)*/
                
                
                
                
                
            }
            
        }
        
        //.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        
    }
    
    
}
/*
 struct PageView: View {
 // @EnvironmentObject activityHistoryViewModel: ActivityHistoryViewModel
 
 var body: some View {
 TabView {
 
            ForEach(activityHistoryViewModel.activityEntries_[activityEntryIndex].media_path.split(separator: " "), id: \.self) { photoKey in
                if photoKey.contains(".png") == true {
                    
                    Image(uiImage: mediaItems.retrieveImage(forKey: documentURL!.appendingPathComponent(String(photoKey)).absoluteString)!)
                        //Image(uiImage: mediaItems.retrieveImage(forKey: String(photoKey))!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                        //.padding()
                } else if photoKey.contains(".mp4") == true {
                    VideoPlayer(player: AVPlayer(url: documentURL!.appendingPathComponent(String(photoKey))))
                        .frame(width: 400)
                        .padding()
                }
                
            }.padding()
            
            /*ForEach(0..<30) { i in
                ZStack {
                    Color.black
                    Text("Row: \(i)").foregroundColor(.white)
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding(.all, 10)*/
        }
        .frame(width: 300, height: 200)
        .tabViewStyle(PageTabViewStyle())
        //.padding()
    }
}
*/
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
                
              /*  Button(action: {}) {
                    Image(systemName: "pencil")
                      //  .font(.title)
                        .foregroundColor(.white)
                }
                .buttonStyle(GradientButtonStyle())*/
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

