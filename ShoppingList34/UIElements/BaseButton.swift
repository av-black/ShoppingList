//
//  PrimaryButton.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 31.03.2026.
//

import SwiftUI

struct BaseButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.headline)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .clipShape(Capsule())
        }
        .disabled(!isActive)
    }
    
    private var backgroundColor: Color {
        isActive
        ? .turquoiseUniversalSL
        : .grayButtonDisabledSL
    }
    
    private var textColor: Color {
        isActive
        ? .whiteUniversalSL
        : .grayHintSL
    }
}

#Preview {
    VStack(spacing: 16) {
        BaseButton(
            title: "Нажми на меня",
            isActive: true,
            action: {}
        )
        
        BaseButton(
            title: "Нажми на меня",
            isActive: false,
            action: {}
        )
    }
    .padding()
}
