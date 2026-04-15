//
//  CategoryItem.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 07.04.2026.
//

import Foundation

struct CategoryItem: Identifiable, Hashable {
    let id: UUID
    let icon: AppIcon
    
    init(
        id: UUID = UUID(),
        icon: AppIcon
    ) {
        self.id = id
        self.icon = icon
    }
}

// MARK: - Mock
extension CategoryItem {
    static var mockCategoryItems: [CategoryItem] {
        [
            CategoryItem(icon: AppIcon.snow),
            CategoryItem(icon: AppIcon.airplane),
            CategoryItem(icon: AppIcon.warning),
            CategoryItem(icon: AppIcon.balloon),
            CategoryItem(icon: AppIcon.bandage),
            CategoryItem(icon: AppIcon.dumbbell),
            CategoryItem(icon: AppIcon.bed),
            CategoryItem(icon: AppIcon.briefcase),
            CategoryItem(icon: AppIcon.wrench),
            CategoryItem(icon: AppIcon.building),
            CategoryItem(icon: AppIcon.calendar),
            CategoryItem(icon: AppIcon.gift),
            CategoryItem(icon: AppIcon.palette),
            CategoryItem(icon: AppIcon.cart),
            CategoryItem(icon: AppIcon.car),
            CategoryItem(icon: AppIcon.fastfood),
            CategoryItem(icon: AppIcon.paw),
            CategoryItem(icon: AppIcon.gamepad)
        ]
    }
}
