//
//  ModalRoute.swift
//  ShoppingList34
//
//  Created by Алла on 11.04.2026.
//

import Foundation

/// Маршруты модальной навигации приложения.
enum ModalRoute: Hashable {
    case createShoppingItem
    case editShoppingItem(item: ShoppingItem)
}
