//
//  Goods.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import Foundation

struct Goods {
    var title: String
    var amount: Double
    var type: MeasurementType
    var isComplete: Bool

    init(
        title: String,
        amount: Double = 1,
        type: MeasurementType = .piece,
        isComplete: Bool = false
    ) {
        self.title = title
        self.amount = amount
        self.type = type
        self.isComplete = isComplete
    }
}
