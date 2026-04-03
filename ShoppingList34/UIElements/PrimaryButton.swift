//
//  PrimaryButton.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 31.03.2026.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color("GrayHintSL"))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("GrayButtonDisabledSL"))
                .clipShape(Capsule())
        }
        .disabled(!isActive)
    }
}

#Preview {
    PrimaryButton(
        title: "Нажми на меня",
        isActive: true,
        action: {}
    )
    .padding()
}
