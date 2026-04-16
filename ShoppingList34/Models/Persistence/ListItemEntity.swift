//
//  ListItemEntity.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 13.04.2026.
//

import SwiftUI
import SwiftData

@Model
final class ListItemEntity {
    var id: UUID
    var title: String
    var color: String
    var icon: String
    
    @Relationship(deleteRule: .cascade)
    var items: [ShoppingItemEntity]

    init(
        id: UUID = UUID(),
        title: String,
        color: String,
        icon: String,
        items: [ShoppingItemEntity] = []
    ) {
        self.id = id
        self.title = title
        self.color = color
        self.icon = icon
        self.items = items
    }
}
