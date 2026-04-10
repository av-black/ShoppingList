//
//  ListCreationView.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 10.04.2026.
//

import SwiftUI

struct ListCreationView: View {
    @State private var observed: ListCreationViewObserved
    
    init(observed: ListCreationViewObserved) {
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
                VStack(spacing: 24) {
                    BaseTextField(
                        placeholder: Constants.placeholder,
                        text: $observed.title,
                        state: observed.textFieldState
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
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            
            Spacer(minLength: 0)
            
            BaseButton(
                title: observed.buttonTitle,
                isActive: observed.isButtonActive,
                action: observed.handlePrimaryButtonTap
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
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

#Preview("Создать список") {
    ListCreationView(
        observed: ListCreationViewObserved(
            mode: .create
        )
    )
}

#Preview("Редактировать список") {
    ListCreationView(
        observed: ListCreationViewObserved(
            mode: .edit(
                title: "Покупки",
                selectedColor: .blue,
                selectedCategory: CategoryItem.mockCategoryItems.first!
            )
        )
    )
}
