//
//  ListView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 07.04.2026.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query
    private var entities: [ListItemEntity]
    var items: [ListItem] {
        entities.map { $0.toModel() }
    }
    
    let onCreateTap: () -> Void
    let onItemTap: (ListItem) -> Void

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
                Button {
                    onItemTap(item)
                } label: {
                    ListViewCell(listItem: item)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 80)
        }
    }

    var createButton: some View {
        BaseButton(
            title: Constants.buttonTitle,
            isActive: true,
            action: onCreateTap
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
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

enum PreviewContainer {
    static let container: ModelContainer = {
        // swiftlint:disable:next force_try
        let container = try! ModelContainer(
            for: ListItemEntity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        let context = container.mainContext
        
        ListItem.mocks.forEach {
            context.insert($0.toEntity())
        }
        
        return container
    }()
}

#Preview("Пустой") {
    ListView(
        onCreateTap: {},
        onItemTap: { _ in }
    )
}

#Preview("С данными") {
    ListView(
        onCreateTap: {},
        onItemTap: { _ in }
    )
    .modelContainer(PreviewContainer.container)
}
