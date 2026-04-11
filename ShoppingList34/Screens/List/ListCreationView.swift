//
//  ListCreationView.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 10.04.2026.
//

import SwiftUI

struct ListCreationView: View {
    @State private var observed: Observed
    
    init(observed: Observed) {
        _observed = State(initialValue: observed)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: observed.screenTitle,
                onBackTap: observed.handleBackTap,
                onMoreTap: nil
            )
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    BaseTextField(
                        placeholder: Constants.placeholder,
                        text: $observed.title,
                        state: .normal
                    )
                    
                    ColorSelectorView(
                        selectedColor: $observed.selectedColor
                    )
                    
                    CategoryPickerView(
                        items: observed.items,
                        selectedItem: $observed.selectedCategory,
                        selectedColor: observed.selectedColor.color
                    )
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            
            Spacer()
            
            BaseButton(
                title: observed.buttonTitle,
                isActive: observed.isButtonActive,
                action: observed.handlePrimaryButtonTap
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(.grayMainBackgroundSL)
        .navigationBarBackButtonHidden(true)
    }
}

private extension ListCreationView {
    enum Constants {
        static let placeholder = "Введите название списка"
    }
}

#Preview("Create") {
    ListCreationView(
        observed: .init(
            mode: .create
        )
    )
}

#Preview("Edit") {
    ListCreationView(
        observed: .init(
            mode: .edit(
                title: "Покупки",
                selectedColor: .blue,
                selectedCategory: CategoryItem.mockCategoryItems.first
                ?? CategoryItem(icon: .cart)
            )
        )
    )
}
