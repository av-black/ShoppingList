//
//  ShoppingItemFormView.swift
//  ShoppingList34
//
//  Created by МAK on 07.04.2026.
//

import SwiftUI

struct ShoppingItemFormView: View {
    let item: ShoppingItem?
    let existingItems: [ShoppingItem]
    
    var isEditing: Bool = false
    var onSave: (String, String, MeasurementType) -> Void
    var onDismiss: () -> Void
    
    init(
        item: ShoppingItem? = nil,
        existingItems: [ShoppingItem] = [],
        isEditing: Bool = false,
        onDismiss: @escaping () -> Void,
        onSave: @escaping (String, String, MeasurementType) -> Void
    ) {
        self.item = item
        self.existingItems = existingItems
        self.isEditing = isEditing
        self.onDismiss = onDismiss
        self.onSave = onSave
    }
    
    // MARK: - Состояние полей формы
    
    @State private var observed = Observed()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                nameField
                amountRow
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .background(.grayMainBackgroundSL)
            .navigationTitle(isEditing ? Constants.editTitle : Constants.createTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Constants.cancelButton) {
                        onDismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Constants.doneButton) {
                        onSave(
                            observed.trimmedName(),
                            observed.amount,
                            observed.selectedUnit
                        )
                    }
                    .fontWeight(.semibold)
                    .disabled(!observed.isDoneButtonActive(existingItems: existingItems, editingItem: item))
                }
            }
        }
        .onAppear {
            observed.configure(with: item)
        }
    }
}

// MARK: - Подвью

private extension ShoppingItemFormView {
    
    var nameField: some View {
        BaseTextField(
            placeholder: Constants.namePlaceholder,
            text: $observed.name,
            state: observed.nameFieldState(existingItems: existingItems, editingItem: item)
        )
    }
    
    var amountRow: some View {
        HStack(spacing: 16) {
            amountField
            unitPicker
        }
    }
    
    var amountField: some View {
        TextField(Constants.amountPlaceholder, text: $observed.amount)
            .font(AppFont.body)
            .foregroundStyle(.grayHintUniversalSL)
            .keyboardType(.decimalPad)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(.grayCardBackgroundSL)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var unitPicker: some View {
        HStack(spacing: 4) {
            Text(Constants.unitLabel)
                .font(AppFont.body)
                .foregroundStyle(.grayHintUniversalSL)
            
            Picker("", selection: $observed.selectedUnit) {
                ForEach(MeasurementType.allCases, id: \.self) { unit in
                    Text(unit.rawValue).tag(unit)
                }
            }
            .pickerStyle(.menu)
            .tint(.turquoiseUniversalSL)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.grayCardBackgroundSL)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private extension ShoppingItemFormView {
    enum Constants {
        static let createTitle = "Создание товара"
        static let editTitle = "Редактировать"
        static let cancelButton = "Отменить"
        static let doneButton = "Готово"
        static let namePlaceholder = "Название списка"
        static let amountPlaceholder = "Количество"
        static let unitLabel = "Ед.изм.:"
    }
}

// MARK: - Preview

#Preview("Создание") {
    ShoppingItemFormView(
        isEditing: false,
        onDismiss: {},
        onSave: { name, amount, unit in
            print("Создано: \(name), \(amount) \(unit.rawValue)")
        }
    )
}

#Preview("Создание с дубликатом") {
    ShoppingItemFormView(
        existingItems: [
            ShoppingItem(title: "Чайник", amount: 1, type: .piece),
            ShoppingItem(title: "Молоко", amount: 2, type: .liter)
        ],
        isEditing: false,
        onDismiss: {},
        onSave: { name, amount, unit in
            print("Создано: \(name), \(amount) \(unit.rawValue)")
        }
    )
}

#Preview("Редактирование") {
    ShoppingItemFormView(
        isEditing: true,
        onDismiss: {},
        onSave: { name, amount, unit in
            print("Изменено: \(name), \(amount) \(unit.rawValue)")
        }
    )
}
