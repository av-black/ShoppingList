//
//  AppNavigationView.swift
//  ShoppingList34
//
//  Created by Алла on 10.04.2026.
//

import SwiftUI

/// Корневой экран навигации приложения.
/// Отвечает за настройку NavigationStack и переходы между экранами.
struct AppNavigationView: View {
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ListView(
                items: ListItem.mocks,
                onCreateTap: {
                    router.push(
                        .listCreationScreen(mode: .create)
                    )
                },
                onItemTap: { item in
                    router.push(
                        .shoppingItemsScreen(
                            title: item.title,
                            shoppingItems: item.shoppingItem
                        )
                    )
                }
            )
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                case let .shoppingItemsScreen(title, shoppingItems):
                    ShoppingItemsView(
                        title: title,
                        shoppingItems: shoppingItems
                    )
                    
                case let .listCreationScreen(mode):
                    ListCreationView(observed: .init(mode: mode))
                }
            }
        }
        .environment(router)
        .sheet(item: $router.modalRoute) { route in
            switch route {
            case .createShoppingItem:
                ShoppingItemFormView(
                    isEditing: false,
                    onSave: { _, _, _ in
                        router.dismissModal()
                    }
                )
                .environment(router)
                
            case let .editShoppingItem(item):
                ShoppingItemFormView(
                    item: item,
                    isEditing: true,
                    onSave: { _, _, _ in
                        router.dismissModal()
                    }
                )
                .environment(router)
            }
        }
    }
}
