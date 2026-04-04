//
//  NoGoodsPlaceholderView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import SwiftUI

struct NoGoodsPlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            AppIcon.itemsEmptyState.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 277)

            VStack(spacing: 4) {
                Text("Давайте спланируем покупки!")
                    .font(AppFont.title3)
                    .bold()

                Text("Начните добавлять товары")
                    .font(AppFont.body)
                    .foregroundStyle(.secondary)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    NoGoodsPlaceholderView()
}
