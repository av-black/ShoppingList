//
//  ListCreationView+Observed.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 10.04.2026.
//

import SwiftUI
import Observation

extension ListCreationView {
    @Observable
    final class Observed {
        let mode: ListCreationModel
        let items: [CategoryItem]
        
        var id: UUID?
        var title: String
        var selectedColor: ListColor
        var selectedCategory: CategoryItem
        
        init(
            mode: ListCreationModel,
            items: [CategoryItem] = CategoryItem.mockCategoryItems
        ) {
            self.mode = mode
            self.items = items
            
            switch mode {
            case .create:
                id = nil
                title = ""
                selectedColor = .blue
                selectedCategory = items.first ?? CategoryItem(icon: .cart)
                
            case let .edit(id, title, selectedColor, selectedCategory):
                self.id = id
                self.title = title
                self.selectedColor = selectedColor
                
                self.selectedCategory =
                items.first(where: { $0.icon == selectedCategory.icon })
                ?? items.first
                ?? CategoryItem(icon: .cart)
            }
        }
        
        var screenTitle: String {
            switch mode {
            case .create:
                return Constants.createScreenTitle
            case .edit:
                return Constants.editScreenTitle
            }
        }
        
        var buttonTitle: String {
            switch mode {
            case .create:
                return Constants.createButtonTitle
            case .edit:
                return Constants.editButtonTitle
            }
        }
        
        var isButtonActive: Bool {
            !trimmedTitle.isEmpty
        }
        
        func handlePrimaryButtonTap(
            onCreateTap: (ListItem) -> Void,
            onSaveTap: (ListItem) -> Void
        ) {
            guard isButtonActive else { return }
            
            let item = ListItem(
                id: id ?? UUID(),
                title: title,
                designColor: selectedColor,
                icon: selectedCategory.icon,
                shoppingItem: []
            )
            
            switch mode {
            case .create:
                onCreateTap(item)
            case .edit:
                onSaveTap(item)
            }
        }
    }
}

private extension ListCreationView.Observed {
    enum Constants {
        static let createScreenTitle = "Создать список"
        static let editScreenTitle = "Редактировать список"
        static let createButtonTitle = "Создать"
        static let editButtonTitle = "Сохранить"
    }
    
    var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
