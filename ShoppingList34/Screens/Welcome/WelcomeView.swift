//
//  WelcomeView.swift
//  ShoppingList34
//
//  Created by МAK on 06.04.2026.
//

import SwiftUI

struct WelcomeView: View {
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            titleSection
            illustrationSection
            descriptionSection

            Spacer()

            BaseButton(
                title: Constants.buttonTitle,
                isActive: true,
                action: onStart
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(.grayMainBackgroundSL)
    }
}

// MARK: - Constants

private extension WelcomeView {
    enum Constants {
        static let title = "Добро пожаловать!"
        static let headline = "Никогда не забывайте,\nчто нужно купить"
        static let subtitle = "Создавайте списки\nи не переживайте о покупках"
        static let buttonTitle = "Начать"
        static let illustrationMaxWidth: CGFloat = 277
    }
}

// MARK: - Subviews

private extension WelcomeView {
    var titleSection: some View {
        Text(Constants.title)
            .font(AppFont.largeTitle)
            .foregroundStyle(.blackTitleSL)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
    }

    var illustrationSection: some View {
        AppIcon.onboardingMain.image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: Constants.illustrationMaxWidth)
            .padding(.vertical, 48)
            .accessibilityHidden(true)
    }

    var descriptionSection: some View {
        VStack(spacing: 12) {
            Text(Constants.headline)
                .font(AppFont.title2)
                .multilineTextAlignment(.center)

            Text(Constants.subtitle)
                .font(AppFont.body)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.blackTextSL)
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview

#Preview("Light") {
    WelcomeView(onStart: {})
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    WelcomeView(onStart: {})
        .preferredColorScheme(.dark)
}
