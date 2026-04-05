//
//  NoListsPlaceholderView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import SwiftUI

struct NoListsPlaceholderView: View {
    var body: some View {
        VStack(spacing: 28) {
            AppIcon.mainEmptyState.image
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

private extension NoListsPlaceholderView {
    enum Constants {
        static let title = "Давайте спланируем покупки!"
        static let subtitle = "Создайте свой первый список"
    }
}

#Preview {
    NoListsPlaceholderView()
}
