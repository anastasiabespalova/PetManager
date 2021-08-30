//
//  LivePhotoView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 23.08.2021.
//

import SwiftUI
import PhotosUI

struct LivePhotoView: UIViewRepresentable {
    typealias UIViewType = PHLivePhotoView
    
    var livePhoto: PHLivePhoto
    
    func makeUIView(context: Context) -> PHLivePhotoView {
        let livePhotoView = PHLivePhotoView()
        livePhotoView.livePhoto = livePhoto
        
        // Enable the following optionally to see live photo
        // playing back when it appears.
        // livePhotoView.startPlayback(with: .hint)
        
        return livePhotoView
    }
    
    func updateUIView(_ uiView: PHLivePhotoView, context: Context) {
        
    }
}
