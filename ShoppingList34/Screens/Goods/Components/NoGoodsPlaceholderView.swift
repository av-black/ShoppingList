//
//  NoGoodsPlaceholderView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import SwiftUI

struct NoGoodsPlaceholderView: View {
    var body: some View {
        VStack(spacing: 28) {
            AppIcon.itemsEmptyState.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 277)

            VStack(spacing: 4) {
                Text(Constants.title)
                    .font(AppFont.title3)

                Text(Constants.subtitle)
                    .font(AppFont.body)
            }
            .foregroundColor(.blackTextSL)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

private extension NoGoodsPlaceholderView {
    enum Constants {
        static let title = "Давайте спланируем покупки!"
        static let subtitle = "Начните добавлять товары"
    }
}

#Preview {
    NoGoodsPlaceholderView()
}
