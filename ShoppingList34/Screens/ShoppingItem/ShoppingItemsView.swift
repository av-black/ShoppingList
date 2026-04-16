//
//  ShoppingItemsView.swift
//  ShoppingList34
//
//  Created by Алла on 07.04.2026.
//

import SwiftUI
import SwiftData

struct ShoppingItemsView: View {
    let entity: ListItemEntity
    
    let onBackTap: () -> Void
    let onCreateItemTap: () -> Void
    let onEditItemTap: (ShoppingItemEntity) -> Void
    
    var shoppingItems: [ShoppingItem] {
        entity.items.map { $0.toModel() }
    }
    
    var filteredItems: [ShoppingItem] {
        observed.filteredItems(from: shoppingItems)
    }
    
    var title: String {
        entity.toModel().title
    }
    
    @State private var isSharePresented = false
    @State private var activeAlert: ShoppingItemsAlert?
    @State private var observed = Observed()
        
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                navigationBar
                searchBar
                    .padding(.top, 4)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                
                if shoppingItems.isEmpty {
                    emptyState
                } else {
                    itemsList
                }
            }
            addItemButton
        }
        .background(.grayMainBackgroundSL)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isSharePresented) {
            ShareSheet(items: [observed.shareText(from: shoppingItems)])
        }
        .alert(item: $activeAlert) { alert in
            makeAlert(for: alert)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Subviews

private extension ShoppingItemsView {
    // MARK: - Navigation Bar
    
    var navigationBar: some View {
        HStack(spacing: 8) {
            Button {
                onBackTap()
            } label: {
                AppIcon.back.image
                    .foregroundStyle(.blackIconSL)
                    .font(AppFont.sectionTitle)
                    .frame(width: 28, height: 28)
            }

            Text(title)
                .font(AppFont.headline)
                .foregroundStyle(.blackTitleSL)

            Spacer()

            ShoppingItemOptionsMenu(
                onSortTap: { observed.isSorted.toggle() },
                onShareTap: { isSharePresented = true },
                onResetTap: {
                    resetCompletedItems()
                },
                onDeleteCompletedTap: {
                    activeAlert = .deleteCompleted
                }
            )
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
    
    // MARK: - Search
    
    var searchBar: some View {
        HStack {
            AppIcon.search.image
                .foregroundStyle(.grayHintUniversalSL)
                .font(AppFont.body)
            
            TextField(
                "",
                text: $observed.searchText,
                prompt: Text(Constants.promptText)
                    .foregroundStyle(.grayHintUniversalSL)
                    .font(AppFont.body)
            )
            .font(AppFont.body)
            .foregroundStyle(.blackTextSL)
        }
        .padding(8)
        .background(.grayFieldBackgroundSL)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    // MARK: - List
    
    var itemsList: some View {
        List {
            ForEach(filteredItems) { item in
                shoppingItemRow(for: item)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 80)
            }
    }
    
    private func shoppingItemRow(for item: ShoppingItem) -> some View {
        VStack(spacing: 0) {
            ShoppingItemViewCell(
                shoppingItem: item,
                onCheckboxTap: {
                    toggle(item)
                }
            )
            
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(Color.graySeparatorSL)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            deleteSwipeAction(for: item)
            editSwipeAction(for: item)
        }
    }
    
    private func toggle(_ item: ShoppingItem) {
        observed.toggle(item, in: entity)
    }
    
    private func makeAlert(for alert: ShoppingItemsAlert) -> Alert {
        switch alert {
        case let .deleteItem(item):
            return Alert(
                title: Text(Constants.deleteItemAlertTitle),
                message: Text(Constants.deleteItemAlertMessage),
                primaryButton: .cancel(Text(Constants.cancelButtonTitle)),
                secondaryButton: .destructive(
                    Text(Constants.deleteButtonTitle),
                    action: {
                        delete(item)
                    }
                )
            )
        case .deleteCompleted:
            return Alert(
                title: Text(Constants.deleteCompletedAlertTitle),
                message: Text(Constants.deleteCompletedAlertMessage),
                primaryButton: .cancel(Text(Constants.cancelButtonTitle)),
                secondaryButton: .destructive(
                    Text(Constants.deleteButtonTitle),
                    action: {
                        deleteCompletedItems()
                    }
                )
            )
        }
    }
    
    private func delete(_ item: ShoppingItem) {
        observed.delete(item, in: entity)
    }
    
    private func resetCompletedItems() {
        observed.resetCompletedItems(in: entity)
    }
    
    private func deleteCompletedItems() {
        observed.deleteCompletedItems(from: shoppingItems, in: entity)
    }
    
    // MARK: - Empty State
    
    var emptyState: some View {
        NoShoppingItemsPlaceholderView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Swipe Actions
    
    func editSwipeAction(for item: ShoppingItem) -> some View {
        Button {
            guard let entityItem = observed.entityItem(for: item, in: entity) else { return }
            onEditItemTap(entityItem)
        } label: {
            AppIcon.edit.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.grayEditSL)
    }
    
    func deleteSwipeAction(for item: ShoppingItem) -> some View {
        Button {
            activeAlert = .deleteItem(item)
        } label: {
            AppIcon.trashSL.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.redSL)
    }
    
    // MARK: - Bottom
    
    var addItemButton: some View {
        BaseButton(
            title: Constants.buttonText,
            isActive: true,
            action: {
                onCreateItemTap()
            }
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

// MARK: - Constants

private extension ShoppingItemsView {
    enum Constants {
        static let promptText = "Поиск"
        static let buttonText = "Добавить товар"
        static let deleteItemAlertTitle = "Удаление товара"
        static let deleteItemAlertMessage = "Вы действительно хотите удалить товар?"
        static let deleteCompletedAlertTitle = "Удаление купленных товаров"
        static let deleteCompletedAlertMessage = "Вы действительно хотите удалить все купленные товары?"
        static let cancelButtonTitle = "Отменить"
        static let deleteButtonTitle = "Удалить"
    }
}

private enum ShoppingItemsAlert: Identifiable {
    case deleteItem(ShoppingItem)
    case deleteCompleted

    var id: String {
        switch self {
        case let .deleteItem(item):
            return "delete-item-\(item.id.uuidString)"
        case .deleteCompleted:
            return "delete-completed"
        }
    }
}

#Preview("С данными") {
    // swiftlint:disable:next force_try
    let container = try! ModelContainer(
        for: ListItemEntity.self, ShoppingItemEntity.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    let entity = ListItemEntity(
        title: "Новый год",
        color: "blue",
        icon: "gift"
    )

    entity.items = [
        ShoppingItemEntity(title: "Молоко", amount: 1, type: "liter", list: entity),
        ShoppingItemEntity(title: "Хлеб", amount: 2, type: "piece", list: entity)
    ]

    context.insert(entity)

    return NavigationStack {
        ShoppingItemsView(
            entity: entity,
            onBackTap: {},
            onCreateItemTap: {},
            onEditItemTap: { _ in }
        )
    }
    .modelContainer(container)
}

#Preview("Пустой") {
    // swiftlint:disable:next force_try
    let container = try! ModelContainer(
        for: ListItemEntity.self, ShoppingItemEntity.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let entity = ListItemEntity(
        title: "Пустой список",
        color: "gray",
        icon: "cart"
    )

    return NavigationStack {
        ShoppingItemsView(
            entity: entity,
            onBackTap: {},
            onCreateItemTap: {},
            onEditItemTap: { _ in }
        )
    }
    .modelContainer(container)
}
