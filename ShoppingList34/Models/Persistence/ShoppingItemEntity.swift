//
//  Untitled.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 13.04.2026.
//

import SwiftUI
import SwiftData

@Model
final class ShoppingItemEntity {
    var id: UUID
    var title: String
    var amount: Double
    var type: String
    var isCompleted: Bool
    
    var list: ListItemEntity?

    init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
        type: String,
        isCompleted: Bool = false,
        list: ListItemEntity? = nil
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.type = type
        self.isCompleted = isCompleted
        self.list = list
    }
}
