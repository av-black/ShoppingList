//
//  List.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import Foundation

struct ListItem: Identifiable {
    let id: UUID
    var title: String
    var designColor: ListColor
    var icon: AppIcon
    var shoppingItem: [ShoppingItem] = []
    
    // MARK: - Вычисляемые свойства
    
    var totalCount: Int { shoppingItem.count }
    
    var completedCount: Int { shoppingItem.filter(\.isComplete).count }
    
    var statusText: String { "\(completedCount)/\(totalCount)" }
    
    init(
        id: UUID = UUID(),
        title: String,
        designColor: ListColor = .blue,
        icon: AppIcon,
        shoppingItem: [ShoppingItem] = []
    ) {
        self.id = id
        self.title = title
        self.designColor = designColor
        self.icon = icon
        self.shoppingItem = shoppingItem
    }
}

// MARK: - Mock
extension ListItem {
    static var mock: ListItem {
        ListItem(
            title: "Новый год",
            designColor: .blue,
            icon: .calendar,
            shoppingItem: [
                ShoppingItem(title: "Молоко", amount: 2, type: .liter),
                ShoppingItem(title: "Сыр", amount: 300, type: .gram),
                ShoppingItem(title: "Хлеб", amount: 1, type: .piece),
                ShoppingItem(title: "Мясо", amount: 600, type: .gram),
                ShoppingItem(title: "Рыба", amount: 600, type: .gram),
                ShoppingItem(title: "Соленые огурцы", amount: 200, type: .gram),
                ShoppingItem(title: "Кукуруза в банках", amount: 300, type: .gram),
                ShoppingItem(title: "Конфеты шоколадные", amount: 500, type: .gram),
                ShoppingItem(title: "Салфетки бумажные", amount: 5, type: .piece),
                ShoppingItem(title: "Салат новогодний", amount: 1, type: .kilogram),
                ShoppingItem(title: "Шампанское", amount: 2, type: .piece, isComplete: true),
                ShoppingItem(title: "Мандарины", amount: 1, type: .kilogram, isComplete: true),
                ShoppingItem(title: "Виноград", amount: 2, type: .kilogram, isComplete: true),
                ShoppingItem(title: "Сок апельсиновый", amount: 1, type: .liter, isComplete: true),
                ShoppingItem(title: "Минеральная вода", amount: 4, type: .piece, isComplete: true),
                ShoppingItem(title: "Икра красная", amount: 1, type: .kilogram, isComplete: true),
                ShoppingItem(title: "Хлопушки", amount: 10, type: .piece, isComplete: true),
                ShoppingItem(title: "Конфетти", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Бенгальские огни", amount: 4, type: .piece, isComplete: true),
                ShoppingItem(title: "Дед мороз", amount: 1, type: .piece, isComplete: true)
            ]
        )
    }
}
