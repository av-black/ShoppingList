//
//  NavigationRoute.swift
//  ShoppingList34
//
//  Created by Алла on 10.04.2026.
//

import Foundation

enum NavigationRoute: Hashable {
    case shoppingItemsScreen(title: String, shoppingItems: [ShoppingItem])
}
