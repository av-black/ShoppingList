//
//  MoreButton.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 07.04.2026.
//

import SwiftUI

struct MoreButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            AppIcon.more.image
                .font(AppFont.title2)
                .foregroundStyle(.blackTextSL)
                .frame(width: 44, height: 44)
                .background(Color.clear)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MoreButton(action: {})
        .padding()
}
