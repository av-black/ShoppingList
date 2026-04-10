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
                    print("Create tapped")
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
                }
            }
        }
        .environment(router)
    }
}
