//
//  TextEditorView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 24.08.2021.
//

import SwiftUI
import AVKit

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

struct TextEditorView: View {
    
    @Binding var text: String

    
    init(text: Binding<String>) {
        UITextView.appearance().backgroundColor = .clear
        self._text = text
    }
    

    var body: some View {
        
        TextEditor(text: $text)
            .foregroundColor(Color.black)
            //.frame(width: width, height: height)
            .background(Color.lightGreyColor)
            .cornerRadius(15)
            .padding()
            .disableAutocorrection(true)
    }

    
}
