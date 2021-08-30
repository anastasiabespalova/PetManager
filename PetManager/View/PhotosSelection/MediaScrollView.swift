//
//  MediaScrollView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 24.08.2021.
//

import SwiftUI
import AVKit

struct MediaScrollView: View {
    
    @EnvironmentObject var mediaItems: PickedMediaItems
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(mediaItems.items, id: \.id) { item in
                       ZStack(alignment: .topLeading) {
                           if item.mediaType == .photo {
                               Image(uiImage: item.photo ?? UIImage())
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                           } else if item.mediaType == .video {
                               if let url = item.url {
                                   VideoPlayer(player: AVPlayer(url: url))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                               } else { EmptyView() }
                           } else {
                               if let livePhoto = item.livePhoto {
                                   LivePhotoView(livePhoto: livePhoto)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                               } else { EmptyView() }
                           }
                                               
                           Image(systemName: getMediaImageName(using: item))
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                               .padding(4)
                               .background(Color.black.opacity(0.5))
                               .foregroundColor(.white)
                            .offset(y: 36)
                        
                        Button(action: {
                            mediaItems.delete(item: item)
                                    }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .background(Color.black.opacity(0.5))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                
                                }//.overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .offset(x: 42, y: 3)
                       
                       }
                       
                       .frame(width: 65, height: 65)
                      // .onTapGesture {
                     //   mediaItems.delete(item: item)
                      // }
                       
                }
            }
    }
}

}
