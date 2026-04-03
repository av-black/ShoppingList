//
//  List.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import Foundation

struct ListItem {
    var title: String
    var designColor: ListColor
    var icon: AppIcon
    var goods: [Goods] = []
    
    // MARK: - Вычисляемые свойства
    
    var totalCount: Int { goods.count }
    
    var completedCount: Int { goods.filter(\.isComplete).count }
    
    var statusText: String { "\(completedCount)/\(totalCount)" }
    
    init(
        title: String,
        designColor: ListColor = .blue,
        icon: AppIcon,
        goods: [Goods] = []
    ) {
        self.title = title
        self.designColor = designColor
        self.icon = icon
        self.goods = goods
    }
}

// MARK: - Mock
extension ListItem {
    static var mock: ListItem {
        ListItem(
            title: "Новый год",
            designColor: .blue,
            icon: .calendar,
            goods: [
                Goods(title: "Молоко", amount: 2, type: .liter),
                Goods(title: "Сыр", amount: 300, type: .gram),
                Goods(title: "Хлеб", amount: 1, type: .piece),
                Goods(title: "Мясо", amount: 600, type: .gram),
                Goods(title: "Рыба", amount: 600, type: .gram),
                Goods(title: "Соленые огурцы", amount: 200, type: .gram),
                Goods(title: "Кукуруза в банках", amount: 300, type: .gram),
                Goods(title: "Конфеты шоколадные", amount: 500, type: .gram),
                Goods(title: "Салфетки бумажные", amount: 5, type: .piece),
                Goods(title: "Салат новогодний", amount: 1, type: .kilogram),
                Goods(title: "Шампанское", amount: 2, type: .piece, isComplete: true),
                Goods(title: "Мандарины", amount: 1, type: .kilogram, isComplete: true),
                Goods(title: "Виноград", amount: 2, type: .kilogram, isComplete: true),
                Goods(title: "Сок апельсиновый", amount: 1, type: .liter, isComplete: true),
                Goods(title: "Минеральная вода", amount: 4, type: .piece, isComplete: true),
                Goods(title: "Икра красная", amount: 1, type: .kilogram, isComplete: true),
                Goods(title: "Хлопушки", amount: 10, type: .piece, isComplete: true),
                Goods(title: "Конфетти", amount: 1, type: .piece, isComplete: true),
                Goods(title: "Бенгальские огни", amount: 4, type: .piece, isComplete: true),
                Goods(title: "Дед мороз", amount: 1, type: .piece, isComplete: true)
            ]
        )
    }
}
