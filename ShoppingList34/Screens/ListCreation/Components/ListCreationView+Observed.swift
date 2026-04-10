//
//  ListCreationView+Observed.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 10.04.2026.
//

import SwiftUI
import Observation

@Observable
final class ListCreationViewObserved {
    let mode: ListCreationMode
    let items: [CategoryItem]
    
    var title: String
    var selectedColor: ListColor
    var selectedCategory: CategoryItem
    
    init(
        mode: ListCreationMode,
        items: [CategoryItem] = CategoryItem.mockCategoryItems
    ) {
        self.mode = mode
        self.items = items
        
        switch mode {
        case .create:
            title = ""
            selectedColor = .blue
            selectedCategory = items.first!
            
        case let .edit(title, selectedColor, selectedCategory):
            self.title = title
            self.selectedColor = selectedColor
            self.selectedCategory = selectedCategory
        }
    }
    
    var screenTitle: String {
        switch mode {
        case .create: return "Создать список"
        case .edit: return "Редактировать список"
        }
    }
    
    var buttonTitle: String {
        switch mode {
        case .create: return "Создать"
        case .edit: return "Сохранить"
        }
    }
    
    var isButtonActive: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var textFieldState: TextFieldState {
        .normal
    }
    
    func handleBackTap() {}
    
    func handlePrimaryButtonTap() {
        guard isButtonActive else { return }
        
        switch mode {
        case .create:
            handleCreate()
        case .edit:
            handleSave()
        }
    }
}

private extension ListCreationViewObserved {
    func handleCreate() {}
    func handleSave() {}
}
