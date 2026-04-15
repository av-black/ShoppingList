//
//  ListOptionsMenu.swift
//  ShoppingList34
//
//  Created by Качусов Степан on 11.04.2026.
//

import SwiftUI

struct ListOptionsMenu: View {
    @Environment(ThemeStore.self) private var themeStore
    let onSortTap: () -> Void

    @State private var isPresented = false
    @State private var isExpanded = false

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
    static let theme = "Установить тему"
    static let sort = "Сортировать по\nАлфавиту"
}

// MARK: - Content

private extension ListOptionsMenu {
    var content: some View {
        VStack(spacing: 0) {
            themeRow

            separator

            if isExpanded {
                themeList
                separator
            }

            sortRow
        }
        .frame(width: 250)
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

private extension ListOptionsMenu {
    var themeRow: some View {
        MenuRow(
            title: MenuTitle.theme,
            leftSystemIcon: isExpanded ? "chevron.down" : "chevron.right",
            rightIcon: AppIcon.theme.image,
            isMultiline: false,
            titleFont: AppFont.body
        ) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
        }
    }

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
        .padding(.leading, 31)
    }
}

// MARK: - Theme List

private extension ListOptionsMenu {
    var themeList: some View {
        VStack(spacing: 0) {
            ForEach(AppTheme.allCases) { theme in
                Button {
                    themeStore.setTheme(theme)

                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded = false
                        isPresented = false
                    }
                } label: {
                    HStack(spacing: 12) {
                        Group {
                            if themeStore.selectedTheme == theme {
                                AppIcon.checkmark.image
                                    .font(AppFont.headlineStrong)
                                    .foregroundStyle(.blackSettingsTextSL)
                            } else {
                                Color.clear
                            }
                        }
                        .frame(width: 20)

                        Text(theme.title)
                            .font(AppFont.body)
                            .foregroundStyle(.blackSettingsTextSL)

                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if theme.id != AppTheme.allCases.last?.id {
                    separator
                }
            }
        }
    }
}

// MARK: - Reusable Row

struct MenuRow<RightIcon: View>: View {
    let title: String
    let leftSystemIcon: String?
    let rightIcon: RightIcon?
    let isMultiline: Bool
    let titleFont: Font
    let action: () -> Void

    init(
        title: String,
        leftSystemIcon: String? = nil,
        rightIcon: RightIcon? = nil,
        isMultiline: Bool = false,
        titleFont: Font = AppFont.body,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.leftSystemIcon = leftSystemIcon
        self.rightIcon = rightIcon
        self.isMultiline = isMultiline
        self.titleFont = titleFont
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let leftSystemIcon {
                    Image(systemName: leftSystemIcon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.blackSettingsTextSL)
                        .frame(width: 20)
                }

                Text(title)
                    .font(titleFont)
                    .foregroundStyle(.blackSettingsTextSL)
                    .multilineTextAlignment(.leading)
                    .lineLimit(isMultiline ? 2 : 1)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 8)

                rightIcon
                    .font(.system(size: 21, weight: .regular))
                    .foregroundStyle(.blackSettingsTextSL)
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 16)
            .frame(height: isMultiline ? 84 : 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .tint(.blackSettingsTextSL)
    }
}

// MARK: - Preview

#Preview("Collapsed") {
    ListOptionsMenu(onSortTap: {})
        .environment(ThemeStore())
        .padding()
        .background(Color.grayMainBackgroundSL)
}

#Preview("Dark") {
    ListOptionsMenu(onSortTap: {})
        .environment(ThemeStore())
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.grayMainBackgroundSL)
}
