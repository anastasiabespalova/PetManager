//
//  TakePhotoView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 23.08.2021.
//

import SwiftUI
import AVKit
import UIKit

struct TakePhotoView: View {
    @State private var showSheet = false
    @EnvironmentObject var mediaItems: PickedMediaItems
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false
    @State private var shouldPresentActionScheet = false
    
    @State private var shouldOpenCamera = false
    
    var body: some View {
            VStack {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 65, height: 65, alignment: .leading)
                        .foregroundColor(.lightGreyColor)
                    
                    Image(systemName: "camera.on.rectangle")
                        .foregroundColor(.black)
                        //.resizable()
                        .aspectRatio(contentMode: .fit)
                        
                        //.frame(width: 75, height: 75, alignment: .leading)
                }
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGreyColor, lineWidth: 3))
                .onTapGesture {
                    shouldPresentActionScheet = true
                }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
                ImagePicker(isShown: $showImagePicker, image: $image)
                    .onDisappear() {
                        if image != nil {
                            mediaItems.items.append(PhotoPickerModel(with: image!))
                            image = nil
                        }
                    }
        }
            
        .sheet(isPresented: $showSheet, content: {
            PhotoPicker(mediaItems: mediaItems) { didSelectItem in
                // Handle didSelectItems value here...
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
            
    }
    
}


func getMediaImageName(using item: PhotoPickerModel) -> String {
    switch item.mediaType {
        case .photo: return "photo"
        case .video: return "video"
        case .livePhoto: return "livephoto"
    }
}


extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
