//
//  ListView+Observed.swift.swift
//  ShoppingList34
//
//  Created by Алла on 16.04.2026.
//

import Foundation
import Observation
import SwiftData

extension ListView {
    @Observable
    final class Observed {
        
        var isSortedAscending = true
        
        func toggleSort() {
            isSortedAscending.toggle()
        }
        
        func delete(_ entity: ListItemEntity, context: ModelContext) {
            context.delete(entity)
        }
        
        func duplicate(_ entity: ListItemEntity, context: ModelContext) {
            let newItem = ListDuplicateHelper.makeCopy(from: entity.toModel(), in: context)
            context.insert(newItem.toEntity())
        }
        
        func makeEditMode(from entity: ListItemEntity) -> ListCreationModel {
            let model = entity.toModel()
            
            return .edit(
                id: model.id,
                title: model.title,
                selectedColor: model.designColor,
                selectedCategory: CategoryItem(icon: model.icon)
            )
        }
        
        func sortedEntities(from entities: [ListItemEntity]) -> [ListItemEntity] {
            entities.sorted {
                isSortedAscending
                ? $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
                : $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedDescending
            }
        }
    }
}
