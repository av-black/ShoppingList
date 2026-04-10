//
//  AppNavigationView.swift
//  ShoppingList34
//
//  Created by Алла on 10.04.2026.
//

import SwiftUI

struct AppNavigationView: View {
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ListView(
                items: ListItem.mocks,
                onCreateTap: {
                    print("Create tapped")
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
    }
}
