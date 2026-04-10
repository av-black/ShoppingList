//
//  CategoryCell.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 07.04.2026.
//

import SwiftUI

struct CategoryCell: View {
    
    let item: CategoryItem
    let isSelected: Bool
    let selectedColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    isSelected
                    ? selectedColor
                    : .grayIconBackgroundSL
                )
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
            
            item.icon.image
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(
                    isSelected
                    ? .blackUniversalSL
                    : .whiteIconSL
                )
        }
    }
}
    
#Preview("Ячейка выбрана") {
    CategoryCell(
        item: CategoryItem(icon: AppIcon.snow),
        isSelected: true,
        selectedColor: .blueSelectionSL
    )
    .padding()
    .background(.grayMainBackgroundSL)
}

#Preview("Ячейка не выбрана") {
    CategoryCell(
        item: CategoryItem(icon: AppIcon.snow),
        isSelected: false,
        selectedColor: .blueSelectionSL
    )
    .padding()
    .background(.grayMainBackgroundSL)
}
