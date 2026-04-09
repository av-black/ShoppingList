//
//  CustomNavigationBar.swift
//  ShoppingList34
//
//  Created by Алла on 08.04.2026.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let onBackTap: () -> Void
    let onMoreTap: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 8) {
            backButton
            titleView
            Spacer()
            
            if let onMoreTap {
                MoreButton(action: onMoreTap)
            }
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

// MARK: - Subviews

private extension CustomNavigationBar {
    var backButton: some View {
        Button {
            onBackTap()
        } label: {
            AppIcon.back.image
                .foregroundStyle(.blackIconSL)
                .font(AppFont.sectionTitle)
                .frame(width: 28, height: 28)
        }
    }
    
    var titleView: some View {
        Text(title)
            .font(AppFont.headline)
            .foregroundStyle(.blackTitleSL)
    }
}

#Preview("Без кнопки") {
    CustomNavigationBar(
        title: "Создать список",
        onBackTap: {},
        onMoreTap: nil
    )
    .background(.grayMainBackgroundSL)
}

#Preview("С кнопкой") {
    CustomNavigationBar(
        title: ListItem.mock.title,
        onBackTap: {},
        onMoreTap: {}
    )
    .background(.grayMainBackgroundSL)
}
