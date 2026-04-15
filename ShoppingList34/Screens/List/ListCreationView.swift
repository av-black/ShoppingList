//
//  ListCreationView.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 10.04.2026.
//

import SwiftUI

struct ListCreationView: View {
    @State private var observed: Observed
    
    let onBackTap: () -> Void
    let onCreateTap: (ListItem) -> Void
    let onSaveTap: (ListItem) -> Void
    
    init(
        observed: Observed,
        onBackTap: @escaping () -> Void,
        onCreateTap: @escaping (ListItem) -> Void,
        onSaveTap: @escaping (ListItem) -> Void
    ) {
        _observed = State(initialValue: observed)
        self.onBackTap = onBackTap
        self.onCreateTap = onCreateTap
        self.onSaveTap = onSaveTap
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: observed.screenTitle,
                onBackTap: onBackTap,
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
                action: {
                    observed.handlePrimaryButtonTap(
                        onCreateTap: onCreateTap,
                        onSaveTap: onSaveTap
                    )
                }
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
            mode: .create,
        ),
        onBackTap: {},
        onCreateTap: {_ in},
        onSaveTap: {_ in}
    )
}

#Preview("Edit") {
    ListCreationView(
        observed: .init(
            mode: .edit(
                id: UUID(),
                title: "Покупки",
                selectedColor: .blue,
                selectedCategory: CategoryItem.mockCategoryItems.first
                ?? CategoryItem(icon: .cart)
            )
        ),
        onBackTap: {},
        onCreateTap: {_ in},
        onSaveTap: {_ in}
    )
}
