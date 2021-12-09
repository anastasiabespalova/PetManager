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
              //  ForEach(mediaItems.items, id: \.self) { item in
                ForEach(mediaItems.items.indices, id: \.self) { index in
                       ZStack(alignment: .topLeading) {
                           if  mediaItems.items[index].mediaType == .photo {
                            // Image(uiImage: item.photo ?? UIImage())
                            Image(uiImage: mediaItems.items[index].photo ?? UIImage())
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                           } else if  mediaItems.items[index].mediaType == .video {
                               if let url =  mediaItems.items[index].url {
                                   VideoPlayer(player: AVPlayer(url: url))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                               } else { EmptyView() }
                           } else {
                               if let livePhoto =  mediaItems.items[index].livePhoto {
                                   LivePhotoView(livePhoto: livePhoto)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                               } else { EmptyView() }
                           }
                                               
                           Image(systemName: getMediaImageName(using:  mediaItems.items[index]))
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                               .padding(4)
                               .background(Color.black.opacity(0.5))
                               .foregroundColor(.white)
                            .offset(y: 36)
                        
                        Button(action: {
                            mediaItems.delete(item:  mediaItems.items[index])
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
                       //.frame(maxWidth: .infinity)
                     //  .frame(maxHeight: .infinity)
                       .frame( height: 65)
                      // .onTapGesture {
                     //   mediaItems.delete(item: item)
                      // }
                       
                }
            }
    }
}

}
