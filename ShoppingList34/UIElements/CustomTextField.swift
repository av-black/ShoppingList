//
//  CustomTextField.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 31.03.2026.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let state: TextFieldState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField(
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .foregroundColor(Color("GrayHintSL"))
                )
                .font(.headline)
                .foregroundColor(Color("GrayHintSL"))
                .padding(.vertical, 14)
                .padding(.leading, 16)
                
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        AppIcon.clear.image
                            .foregroundColor(Color("GrayHintSL"))
                    }
                    .padding(.trailing, 12)
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            
            if case let .error(message) = state {
                Text(message)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}
