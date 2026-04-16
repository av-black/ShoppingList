//
//  ShoppingItemsView+Observed.swift
//  ShoppingList34
//
//  Created by Алла on 16.04.2026.
//

import Foundation
import Observation

extension ShoppingItemsView {
    @Observable
    final class Observed {
        
        var isSorted = false
        var searchText = ""
        
        func filteredItems(from items: [ShoppingItem]) -> [ShoppingItem] {
            let filtered: [ShoppingItem]
            
            if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                filtered = items
            } else {
                filtered = items.filter {
                    $0.title.localizedCaseInsensitiveContains(searchText)
                }
            }
            
            return isSorted
            ? filtered.sorted { $0.title < $1.title }
            : filtered
        }
        
        func shareText(from items: [ShoppingItem]) -> String {
            items
                .map { "• \($0.title) — \($0.formattedAmount) \($0.type.rawValue)." }
                .joined(separator: "\n")
        }
        
        func toggle(_ item: ShoppingItem, in entity: ListItemEntity) {
            guard let entityItem = entity.items.first(where: { $0.id == item.id }) else { return }
            entityItem.isCompleted.toggle()
        }
        
        func delete(_ item: ShoppingItem, in entity: ListItemEntity) {
            guard let index = entity.items.firstIndex(where: { $0.id == item.id }) else { return }
            entity.items.remove(at: index)
        }
        
        func resetCompletedItems(in entity: ListItemEntity) {
            entity.items.forEach { $0.isCompleted = false }
        }
        
        func deleteCompletedItems(from items: [ShoppingItem], in entity: ListItemEntity) {
            let completed = items.filter { $0.isComplete }
            completed.forEach { delete($0, in: entity) }
        }
        
        func entityItem(for item: ShoppingItem, in entity: ListItemEntity) -> ShoppingItemEntity? {
            entity.items.first { $0.id == item.id }
        }
    }
}
