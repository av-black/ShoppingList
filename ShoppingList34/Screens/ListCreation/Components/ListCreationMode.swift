//
//  ListCreationMode.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 10.04.2026.
//

enum ListCreationMode {
    case create
    case edit(
        title: String,
        selectedColor: ListColor,
        selectedCategory: CategoryItem
    )
}
