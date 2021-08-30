//
//  ImagePicker.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 24.08.2021.
//

import Foundation
import SwiftUI


class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var isShown: Bool
    @Binding var image: UIImage?

    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = pickedImage
        }
       
        //image = Image(uiImage: uiImage)
        isShown = false
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    @Binding var image: UIImage?

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.sourceType = .camera
                } else {
                    fatalError("Camera is not available, please use real device.")
                }
       // picker.allowsEditing = true
        
        return picker
    }

}
