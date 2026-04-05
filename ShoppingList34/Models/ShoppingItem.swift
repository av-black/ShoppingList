//
//  Goods.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import Foundation

struct ShoppingItem: Identifiable {
    let id: UUID
    var title: String
    var amount: Double
    var type: MeasurementType
    var isComplete: Bool

    init(
        id: UUID = UUID(),
        title: String,
        amount: Double = 1,
        type: MeasurementType = .piece,
        isComplete: Bool = false
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.type = type
        self.isComplete = isComplete
    }
}

// MARK: - Mock

extension ShoppingItem {
    static var mock: ShoppingItem {
        ShoppingItem(
            title: "Молоко",
            amount: 2,
            type: .liter,
            isComplete: false
        )
    }
    
    static var completedMock: ShoppingItem {
        ShoppingItem(
            title: "Чайник",
            amount: 2,
            type: .piece,
            isComplete: true
        )
    }
}
