//
//  ShoppingItemsView.swift
//  ShoppingList34
//
//  Created by Алла on 07.04.2026.
//

import SwiftUI

struct ShoppingItemsView: View {
    let title: String
    let shoppingItems: [ShoppingItem]
    
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
                onCheckboxTap: {}
            )
            
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(Color.graySeparatorSL)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            deleteSwipeAction
            editSwipeAction(for: item)
        }
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
    
    var deleteSwipeAction: some View {
        Button {
            print("Delete tapped")
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
    NavigationStack {
        ShoppingItemsView(
            title: ListItem.mock.title,
            shoppingItems: ListItem.mock.shoppingItem
        )
    }
    .environment(NavigationRouter())
}

#Preview("Пустой") {
    NavigationStack {
        ShoppingItemsView(
            title: ListItem.mock.title,
            shoppingItems: []
        )
    }
    .environment(NavigationRouter())
}
