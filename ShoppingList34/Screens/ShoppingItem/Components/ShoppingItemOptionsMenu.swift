//
//  ShoppingItemOptionsMenu.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 16.04.2026.
//

import SwiftUI

struct ShoppingItemOptionsMenu: View {
    let onSortTap: () -> Void
    let onShareTap: () -> Void
    let onResetTap: () -> Void
    let onDeleteCompletedTap: () -> Void

    @State private var isPresented = false

    var body: some View {
        MoreButton {
            isPresented.toggle()
        }
        .popover(isPresented: $isPresented, arrowEdge: .top) {
            content
                .presentationCompactAdaptation(.popover)
        }
    }
}

// MARK: - Titles

private enum MenuTitle {
    static let sort = "Сортировать по\nАлфавиту"
    static let share = "Поделиться"
    static let reset = "Снять отметки со\nвсех товаров"
    static let deleteCompleted = "Удалить купленные\nтовары"
}

// MARK: - Content

private extension ShoppingItemOptionsMenu {
    var content: some View {
        VStack(spacing: 0) {
            sortRow
            separator
            shareRow
            separator
            resetRow
            separator
            deleteCompletedRow
        }
        .frame(width: 250)
        .fixedSize(horizontal: true, vertical: true)
        .background(Color.grayCardBackgroundSL)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: 6)
    }

    var separator: some View {
        Rectangle()
            .fill(Color.graySeparatorSL)
            .frame(height: 0.5)
    }
}

// MARK: - Rows

private extension ShoppingItemOptionsMenu {
    var sortRow: some View {
        MenuRow(
            title: MenuTitle.sort,
            rightIcon: AppIcon.sort.image,
            isMultiline: true,
            titleFont: AppFont.body
        ) {
            onSortTap()
            isPresented = false
        }
    }

    var shareRow: some View {
        MenuRow(
            title: MenuTitle.share,
            rightIcon: AppIcon.share.image,
            isMultiline: false,
            titleFont: AppFont.body
        ) {
            onShareTap()
            isPresented = false
        }
    }

    var resetRow: some View {
        MenuRow(
            title: MenuTitle.reset,
            rightIcon: AppIcon.reset.image,
            isMultiline: true,
            titleFont: AppFont.body
        ) {
            onResetTap()
            isPresented = false
        }
    }

    var deleteCompletedRow: some View {
        MenuRow(
            title: MenuTitle.deleteCompleted,
            rightIcon: AppIcon.trashSL.image,
            isMultiline: true,
            titleFont: AppFont.body,
            color: .redSL,
        ) {
            onDeleteCompletedTap()
            isPresented = false
        }
    }
}

// MARK: - Preview

#Preview {
    ShoppingItemOptionsMenu(
        onSortTap: {},
        onShareTap: {},
        onResetTap: {},
        onDeleteCompletedTap: {}
    )
    .environment(ThemeStore())
    .padding()
    .background(Color.grayMainBackgroundSL)
}

#Preview("Light") {
    ShoppingItemOptionsMenu(
        onSortTap: {},
        onShareTap: {},
        onResetTap: {},
        onDeleteCompletedTap: {}
    )
    .environment(ThemeStore())
    .padding()
    .background(Color.grayMainBackgroundSL)
}

#Preview("Dark") {
    ShoppingItemOptionsMenu(
        onSortTap: {},
        onShareTap: {},
        onResetTap: {},
        onDeleteCompletedTap: {}
    )
    .environment(ThemeStore())
    .environment(\.colorScheme, .dark)
    .padding()
    .background(Color.grayMainBackgroundSL)
}
