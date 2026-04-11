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
        let router: NavigationRouter
        
        let mode: ListCreationModel
        let items: [CategoryItem]
        
        var title: String
        var selectedColor: ListColor
        var selectedCategory: CategoryItem
        
        init(
            mode: ListCreationModel,
            router: NavigationRouter,
            items: [CategoryItem] = CategoryItem.mockCategoryItems
        ) {
            self.mode = mode
            self.router = router
            self.items = items
            
            switch mode {
            case .create:
                title = ""
                selectedColor = .blue
                selectedCategory = items.first ?? CategoryItem(icon: .cart)
                
            case let .edit(
                title,
                selectedColor,
                selectedCategory
            ):
                self.title = title
                self.selectedColor = selectedColor
                self.selectedCategory = selectedCategory
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
        
        func handleBackTap() {
            router.pop()
        }
        
        func handlePrimaryButtonTap() {
            guard isButtonActive else { return }
            
            switch mode {
            case .create:
                handleCreateList()
            case .edit:
                handleSaveList()
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
    
    func handleCreateList() {
    }
    
    func handleSaveList() {
    }
}
