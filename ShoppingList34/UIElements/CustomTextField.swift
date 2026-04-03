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
            .background(Color("GrayCardBackgroundSL"))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            )
            
            if case let .error(message) = state {
                Text(message)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
    private var borderColor: Color {
        switch state {
        case .normal:
            return .clear
        case .error:
            return Color("RedSL")
        }
    }
}
#Preview {
    @Previewable @State var text = ""
    @Previewable @State var filledText = "Тестовый текст"
    
    VStack(spacing: 16) {
        CustomTextField(
            placeholder: "Введите текст",
            text: $text,
            state: .normal
        )
        
        CustomTextField(
            placeholder: "Введите текст",
            text: $filledText,
            state: .normal
        )
        
        CustomTextField(
            placeholder: "Введите текст",
            text: $text,
            state: .error("Это название уже используется, пожалуйста, измените его.")
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
