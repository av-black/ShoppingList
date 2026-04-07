//
//  ListView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 07.04.2026.
//

import SwiftUI

struct ListView: View {
    let items: [ListItem]
    let onCreateTap: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                header
                if items.isEmpty {
                    emptyState
                } else {
                    listContent
                }
            }
            createButton
        }
        .background(.grayMainBackgroundSL)
    }
}

// MARK: - Subviews

private extension ListView {
    var header: some View {
        HStack {
            Text(Constants.title)
                .font(AppFont.title1)
                .foregroundStyle(.blackTitleSL)
            Spacer()
            MoreButton(action: {})
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    var emptyState: some View {
        NoListsPlaceholderView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var listContent: some View {
        List {
            ForEach(items) { item in
                ListViewCell(listItem: item)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
        .padding(.bottom, 80)
        .scrollContentBackground(.hidden)
    }

    var createButton: some View {
        BaseButton(
            title: Constants.buttonTitle,
            isActive: true,
            action: onCreateTap
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

// MARK: - Constants

private extension ListView {
    enum Constants {
        static let title = "Мои списки"
        static let buttonTitle = "Создать список"
    }
}

// MARK: - Preview

#Preview("Пустой") {
    ListView(items: [], onCreateTap: {})
}

#Preview("С данными") {
    ListView(items: ListItem.mocks, onCreateTap: {})
}
