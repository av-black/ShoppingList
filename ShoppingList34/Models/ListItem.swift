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
    
    static var catMock: ListItem {
        ListItem(
            title: "Кошке",
            designColor: .green,
            icon: .paw,
            shoppingItem: [
                ShoppingItem(title: "Корм сухой", amount: 1, type: .kilogram),
                ShoppingItem(title: "Наполнитель", amount: 2, type: .piece),
                ShoppingItem(title: "Игрушка", amount: 1, type: .piece),
                ShoppingItem(title: "Витамины", amount: 1, type: .piece, isComplete: true)
            ]
        )
    }
    
    static var partyMock: ListItem {
        ListItem(
            title: "Вечеринка малого",
            designColor: .yellow,
            icon: .gamepad,
            shoppingItem: [
                ShoppingItem(title: "Чипсы", amount: 3, type: .piece),
                ShoppingItem(title: "Газировка", amount: 5, type: .piece),
                ShoppingItem(title: "Пицца", amount: 2, type: .piece),
                ShoppingItem(title: "Конфеты", amount: 1, type: .kilogram),
                ShoppingItem(title: "Сок", amount: 3, type: .liter),
                ShoppingItem(title: "Орехи", amount: 200, type: .gram),
                ShoppingItem(title: "Печенье", amount: 300, type: .gram),
                ShoppingItem(title: "Мороженое", amount: 4, type: .piece),
                ShoppingItem(title: "Торт", amount: 1, type: .piece),
                ShoppingItem(title: "Шарики", amount: 10, type: .piece),
                ShoppingItem(title: "Свечи", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Скатерть", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Тарелки", amount: 10, type: .piece, isComplete: true),
                ShoppingItem(title: "Стаканы", amount: 10, type: .piece, isComplete: true),
                ShoppingItem(title: "Вилки", amount: 10, type: .piece, isComplete: true),
                ShoppingItem(title: "Салфетки", amount: 2, type: .piece, isComplete: true),
                ShoppingItem(title: "Фольга", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Пакеты", amount: 5, type: .piece, isComplete: true),
                ShoppingItem(title: "Зубочистки", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Открытка", amount: 1, type: .piece, isComplete: true)
            ]
        )
    }
    
    static var mocks: [ListItem] {
        [mock, catMock, partyMock]
    }
}
