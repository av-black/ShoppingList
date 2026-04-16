//
//  ListDuplicateHelper.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 16.04.2026.
//

import SwiftData
import Foundation

enum ListDuplicateHelper {
    
    static func makeCopy(
        from listItem: ListItem,
        in context: ModelContext
    ) -> ListItem {
        
        let allLists = (try? context.fetch(FetchDescriptor<ListItemEntity>())) ?? []
        
        let baseTitle = listItem.title
            .replacingOccurrences(of: #"^Копия \d* "#, with: "", options: .regularExpression)
            .replacingOccurrences(of: "Копия ", with: "")
        
        let identicalLists = allLists.filter {
            $0.color == listItem.designColor.rawValue &&
            $0.icon == listItem.icon.rawValue &&
            (
                $0.title == baseTitle ||
                ($0.title.hasPrefix("Копия") && $0.title.contains(baseTitle))
            )
        }
        
        let copies = identicalLists.filter {
            $0.title.hasPrefix("Копия")
        }
        
        let copyNumber = copies.count + 1
        
        var newItem = ListItem(
            id: UUID(),
            title: baseTitle,
            designColor: listItem.designColor,
            icon: listItem.icon,
            shoppingItem: listItem.shoppingItem
        )
        
        if !identicalLists.isEmpty {
            if copyNumber == 1 {
                newItem.title = "Копия \(baseTitle)"
            } else {
                newItem.title = "Копия \(copyNumber) \(baseTitle)"
            }
        }
        
        return newItem
    }
}
