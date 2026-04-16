//
//  ModelToEntity.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 13.04.2026.
//

extension ShoppingItem {

    @MainActor func toEntity(parent: ListItemEntity) -> ShoppingItemEntity {
        ShoppingItemEntity(
            id: id,
            title: title,
            amount: amount,
            type: type.rawValue,
            isCompleted: isComplete,
            list: parent
        )
    }
}

extension ListItem {
    @MainActor func toEntity() -> ListItemEntity {
        let entity = ListItemEntity(
            id: id,
            title: title,
            color: designColor.rawValue,
            icon: icon.rawValue
        )
        
        entity.items = shoppingItem.map { $0.toEntity(parent: entity) }
        
        return entity
    }
}
