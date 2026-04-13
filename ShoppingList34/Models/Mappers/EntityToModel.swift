//
//  EntityToModel.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 13.04.2026.
//

extension ListItemEntity {
    
    @MainActor func toModel() -> ListItem {
        ListItem(
            id: id,
            title: title,
            designColor: ListColor(rawValue: color) ?? .blue,
            icon: AppIcon(rawValue: icon),
            shoppingItem: items.map { $0.toModel() }
        )
    }
}

extension ShoppingItemEntity {
    
    @MainActor func toModel() -> ShoppingItem {
        ShoppingItem(
            id: id,
            title: title,
            amount: amount,
            type: MeasurementType(rawValue: type) ?? .piece,
            isComplete: isCompleted
        )
    }
}
