//
//  NoListsPlaceholderView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import SwiftUI

struct NoListsPlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            AppIcon.mainEmptyState.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 277)

            VStack(spacing: 4) {
                Text("Давайте спланируем покупки!")
                    .font(AppFont.title3)
                    .bold()

                Text("Создайте свой первый список")
                    .font(AppFont.body)
                    .foregroundStyle(.secondary)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    NoListsPlaceholderView()
}
