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
            Button(action: onCheckboxTap) {
                checkboxView
                    .frame(width: 44, height: 44)
            }
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
                        .font(AppFont.checkbox)
                        .foregroundStyle(.turquoiseUniversalSL)
                    
                    AppIcon.checkmark.image
                        .font(AppFont.checkboxMark)
                        .foregroundStyle(.whiteUniversalSL)
                }
            } else {
                AppIcon.checkbox.image
                    .font(AppFont.checkbox)
                    .foregroundStyle(.grayCheckboxSL)
            }
        }
    }
    
    private var textColor: Color {
        shoppingItem.isComplete ? .graySelectedTextSL : .blackTextSL
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 0) {
            ForEach(ListItem.mock.shoppingItem) { item in
                ShoppingItemViewCell(
                    shoppingItem: item,
                    onCheckboxTap: {}
                )
                
                Divider()
                    .background(Color.graySeparatorSL)
            }
        }
        .background(.grayMainBackgroundSL)
    }
}
