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
    
    static var groceryMock: ListItem {
        ListItem(
            title: "Продукты",
            designColor: .red,
            icon: .cart,
            shoppingItem: [
                ShoppingItem(title: "Хлеб", amount: 2, type: .piece),
                ShoppingItem(title: "Молоко", amount: 1, type: .liter),
                ShoppingItem(title: "Яйца", amount: 10, type: .piece),
                ShoppingItem(title: "Масло сливочное", amount: 200, type: .gram),
                ShoppingItem(title: "Сметана", amount: 400, type: .gram),
                ShoppingItem(title: "Творог", amount: 300, type: .gram),
                ShoppingItem(title: "Сахар", amount: 1, type: .kilogram, isComplete: true),
                ShoppingItem(title: "Мука", amount: 1, type: .kilogram, isComplete: true)
            ]
        )
    }

    static var gymMock: ListItem {
        ListItem(
            title: "В спортзал",
            designColor: .purple,
            icon: .dumbbell,
            shoppingItem: [
                ShoppingItem(title: "Протеин", amount: 1, type: .piece),
                ShoppingItem(title: "Бутылка воды", amount: 1, type: .piece),
                ShoppingItem(title: "Полотенце", amount: 1, type: .piece),
                ShoppingItem(title: "Кроссовки", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Перчатки", amount: 1, type: .piece, isComplete: true)
            ]
        )
    }

    static var dacha: ListItem {
        ListItem(
            title: "На дачу",
            designColor: .green,
            icon: .briefcase,
            shoppingItem: [
                ShoppingItem(title: "Удобрение", amount: 2, type: .piece),
                ShoppingItem(title: "Семена томатов", amount: 3, type: .piece),
                ShoppingItem(title: "Семена огурцов", amount: 3, type: .piece),
                ShoppingItem(title: "Перчатки садовые", amount: 2, type: .piece),
                ShoppingItem(title: "Лейка", amount: 1, type: .piece),
                ShoppingItem(title: "Грунт", amount: 5, type: .kilogram, isComplete: true),
                ShoppingItem(title: "Горшки", amount: 4, type: .piece, isComplete: true)
            ]
        )
    }

    static var birthdayMock: ListItem {
        ListItem(
            title: "День рождения",
            designColor: .yellow,
            icon: .gift,
            shoppingItem: [
                ShoppingItem(title: "Торт", amount: 1, type: .piece),
                ShoppingItem(title: "Шарики", amount: 20, type: .piece),
                ShoppingItem(title: "Свечи", amount: 1, type: .piece),
                ShoppingItem(title: "Подарок", amount: 1, type: .piece),
                ShoppingItem(title: "Открытка", amount: 1, type: .piece),
                ShoppingItem(title: "Скатерть", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Тарелки бумажные", amount: 10, type: .piece, isComplete: true),
                ShoppingItem(title: "Стаканы", amount: 10, type: .piece, isComplete: true)
            ]
        )
    }

    static var repairMock: ListItem {
        ListItem(
            title: "Ремонт",
            designColor: .red,
            icon: .wrench,
            shoppingItem: [
                ShoppingItem(title: "Краска белая", amount: 3, type: .liter),
                ShoppingItem(title: "Валик", amount: 2, type: .piece),
                ShoppingItem(title: "Малярная лента", amount: 3, type: .piece),
                ShoppingItem(title: "Шпатлёвка", amount: 5, type: .kilogram),
                ShoppingItem(title: "Грунтовка", amount: 2, type: .liter),
                ShoppingItem(title: "Наждачная бумага", amount: 5, type: .piece, isComplete: true),
                ShoppingItem(title: "Шурупы", amount: 50, type: .piece, isComplete: true)
            ]
        )
    }

    static var travelMock: ListItem {
        ListItem(
            title: "В поездку",
            designColor: .blue,
            icon: .airplane,
            shoppingItem: [
                ShoppingItem(title: "Солнцезащитный крем", amount: 1, type: .piece),
                ShoppingItem(title: "Купальник", amount: 1, type: .piece),
                ShoppingItem(title: "Полотенце пляжное", amount: 2, type: .piece),
                ShoppingItem(title: "Очки солнечные", amount: 1, type: .piece),
                ShoppingItem(title: "Шлёпанцы", amount: 1, type: .piece),
                ShoppingItem(title: "Аптечка", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Адаптер", amount: 1, type: .piece, isComplete: true),
                ShoppingItem(title: "Зарядка", amount: 1, type: .piece, isComplete: true)
            ]
        )
    }
    
    static var mocks: [ListItem] {
        [mock, catMock, partyMock, groceryMock, gymMock, dacha, birthdayMock, repairMock, travelMock]
    }
}
