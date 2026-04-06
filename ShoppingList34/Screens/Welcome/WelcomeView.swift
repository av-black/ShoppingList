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
                title: "Начать",
                isActive: true,
                action: onStart
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .background(Color.grayMainBackgroundSL)
    }
}
 
// MARK: - Subviews
 
private extension WelcomeView {
    var titleSection: some View {
        Text("Добро пожаловать!")
            .font(AppFont.largeTitle)
            .foregroundStyle(.blackTextSL)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
    }

    var illustrationSection: some View {
        AppIcon.onboardingMain.image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 280)
            .padding(.vertical, 48)
            .accessibilityHidden(true)
    }

    var descriptionSection: some View {
        VStack(spacing: 12) {
            Text("Никогда не забывайте,\nчто нужно купить")
                .font(AppFont.title2)
                .bold()
                .multilineTextAlignment(.center)

            Text("Создавайте списки\nи не переживайте о покупках")
                .font(AppFont.body)
                .foregroundStyle(.secondary)
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
