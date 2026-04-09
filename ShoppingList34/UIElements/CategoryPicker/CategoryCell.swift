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
                .foregroundStyle(
                    isSelected
                    ? .blackUniversalSL
                    : .whiteIconSL
                )
                .scaledToFit()
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        
    }
}
