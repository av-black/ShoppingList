//
//  CustomTextField.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 31.03.2026.
//

import SwiftUI

struct BaseTextField: View {
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
                        .foregroundColor(.grayHintUniversalSL)                )
                .font(AppFont.body)
                .foregroundColor(.blackTextSL)                .padding(.vertical, 14)
                .padding(.leading, 16)
                
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        AppIcon.clear.image
                        .foregroundColor(.grayHintUniversalSL)                    }
                    .padding(.trailing, 12)
                }
            }
            .background(.grayCardBackgroundSL)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 0.5)
            )
            
            if case let .error(message) = state {
                Text(message)
                    .font(AppFont.caption)
                    .foregroundColor(.redSL)
            }
        }
    }
    private var borderColor: Color {
        switch state {
        case .normal:
            return .clear
        case .error:
            return .redSL
        }
    }
}
#Preview {
    @Previewable @State var text = ""
    @Previewable @State var filledText = "Тестовый текст"
    
    VStack(spacing: 16) {
        BaseTextField(
            placeholder: "Введите текст",
            text: $text,
            state: .normal
        )
        
        BaseTextField(
            placeholder: "Введите текст",
            text: $filledText,
            state: .normal
        )
        
        BaseTextField(
            placeholder: "Введите текст",
            text: $text,
            state: .error("Это название уже используется, пожалуйста, измените его.")
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
