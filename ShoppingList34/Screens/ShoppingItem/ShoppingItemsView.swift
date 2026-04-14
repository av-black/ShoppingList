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
    
    var shoppingItems: [ShoppingItem] {
        entity.items.map { $0.toModel() }
    }
    
    var title: String {
        entity.toModel().title
    }
    
    @State private var searchText = ""
    @Environment(NavigationRouter.self) private var router
    
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
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            print("MODEL CONTEXT:", entity.modelContext as Any)
        }
    }
}

// MARK: - Subviews

private extension ShoppingItemsView {
    // MARK: - Navigation Bar
    
    var navigationBar: some View {
        CustomNavigationBar(
            title: title,
            onBackTap: {
                router.pop()
            },
            onMoreTap: {}
        )
    }
    
    // MARK: - Search
    
    var searchBar: some View {
        HStack {
            AppIcon.search.image
                .foregroundStyle(.grayHintUniversalSL)
                .font(AppFont.body)
            
            TextField(
                "",
                text: $searchText,
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
            ForEach(shoppingItems) { item in
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
        guard let entity = entity.items.first(where: { $0.id == item.id }) else { return }
        
        entity.isCompleted.toggle()
    }
    
    private func delete(_ item: ShoppingItem) {
        guard let index = entity.items.firstIndex(where: { $0.id == item.id }) else { return }
        
        let object = entity.items[index]
        entity.items.remove(at: index)
    }
    
    // MARK: - Empty State
    
    var emptyState: some View {
        NoShoppingItemsPlaceholderView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Swipe Actions
    
    func editSwipeAction(for item: ShoppingItem) -> some View {
        Button {
            router.showModal(.editShoppingItem(item: item))
        } label: {
            AppIcon.edit.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.grayEditSL)
    }
    
    func deleteSwipeAction(for item: ShoppingItem) -> some View {
        Button {
            delete(item)
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
                router.showModal(.createShoppingItem)
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
        ShoppingItemsView(entity: entity)
    }
    .modelContainer(container)
    .environment(NavigationRouter())
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
        ShoppingItemsView(entity: entity)
    }
    .modelContainer(container)
    .environment(NavigationRouter())
}
