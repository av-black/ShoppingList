//
//  ShoppingItemViewCell.swift
//  ShoppingList34
//
//  Created by Алла on 05.04.2026.
//

import SwiftUI

struct ShoppingItemViewCell: View {
    let shoppingItem: ShoppingItem
    let onCheckboxTap: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Button(
                action: onCheckboxTap,
                label: {
                    checkboxView
                        .frame(width: 44, height: 44)
                }
            )
            .buttonStyle(.plain)
            
            HStack {
                Text(shoppingItem.title)
                
                Spacer()
                
                Text(amountText)
            }
            .font(AppFont.body)
            .foregroundStyle(textColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
    
    // MARK: - Private Computed Properties
    
    private var amountText: String {
        "\(shoppingItem.formattedAmount) \(shoppingItem.type.rawValue)."
    }
    
    private var checkboxView: some View {
        Group {
            if shoppingItem.isComplete {
                ZStack {
                    AppIcon.checkboxFill.image
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.turquoiseUniversalSL)
                    
                    AppIcon.checkmark.image
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.whiteUniversalSL)
                }
            } else {
                AppIcon.checkbox.image
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.grayCheckboxSL)
            }
        }
        
    }
    
    private var textColor: Color {
        shoppingItem.isComplete ? .graySelectedTextSL : .blackTextSL
    }
}

#Preview {
    VStack(spacing: 0) {
        ShoppingItemViewCell(
            shoppingItem: .mock,
            onCheckboxTap: {}
        )
        
        Divider()
            .background(Color.graySeparatorSL)
            .frame(height: 1)
        
        ShoppingItemViewCell(
            shoppingItem: .completedMock,
            onCheckboxTap: {}
        )
    }
    .background(.grayMainBackgroundSL)
}
