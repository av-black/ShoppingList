//
//  ModalRoute.swift
//  ShoppingList34
//
//  Created by Алла on 11.04.2026.
//

import Foundation

/// Маршруты модальной навигации приложения.
enum ModalRoute: Hashable, Identifiable {
    case createShoppingItem
    case editShoppingItem(item: ShoppingItem)
    
    var id: String {
        switch self {
        case .createShoppingItem:
            return "createShoppingItem"
        case .editShoppingItem(let item):
            return "editShoppingItem_\(item.id)"
        }
    }
}
