//
//  ShoppingItemFormView.swift
//  ShoppingList34
//
//  Created by МAK on 07.04.2026.
//

import SwiftUI

struct ShoppingItemFormView: View {
    @Environment(NavigationRouter.self) private var router
    
    let item: ShoppingItem?
    let existingItems: [ShoppingItem]
    var isEditing: Bool = false
    var onSave: (String, String, MeasurementType) -> Void
    
    init(
        item: ShoppingItem? = nil,
        existingItems: [ShoppingItem] = [],
        isEditing: Bool = false,
        onSave: @escaping (String, String, MeasurementType) -> Void
    ) {
        self.item = item
        self.existingItems = existingItems
        self.isEditing = isEditing
        self.onSave = onSave
    }
    
    // MARK: - Состояние полей формы
    
    @State private var name = ""
    @State private var amount = ""
    @State private var selectedUnit: MeasurementType = .piece
    
    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespaces)
    }

    private var isDuplicate: Bool {
        guard !trimmedName.isEmpty else { return false }
        return existingItems.contains { existing in
            if let item, existing.id == item.id { return false }
            return existing.title.localizedCaseInsensitiveCompare(trimmedName) == .orderedSame
        }
    }

    private var nameFieldState: TextFieldState {
        isDuplicate ? .error(Constants.duplicateError) : .normal
    }

    private var isDoneButtonActive: Bool {
        !trimmedName.isEmpty && !amount.isEmpty && !isDuplicate
    }
    
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
                        router.dismissModal()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Constants.doneButton) {
                        onSave(trimmedName, amount, selectedUnit)
                    }
                    .fontWeight(.semibold)
                    .disabled(!isDoneButtonActive)
                }
            }
        }
        .onAppear {
            if let item {
                name = item.title
                amount = String(item.amount)
                selectedUnit = item.type
            }
        }
    }
}

// MARK: - Подвью

private extension ShoppingItemFormView {
    
    var nameField: some View {
        BaseTextField(
            placeholder: Constants.namePlaceholder,
            text: $name,
            state: nameFieldState
        )
    }
    
    var amountRow: some View {
        HStack(spacing: 16) {
            amountField
            unitPicker
        }
    }
    
    var amountField: some View {
        TextField(Constants.amountPlaceholder, text: $amount)
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
            
            Picker("", selection: $selectedUnit) {
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
        static let duplicateError = "Этот товар уже есть в списке, добавьте другой"
    }
}

// MARK: - Preview

#Preview("Создание") {
    ShoppingItemFormView(isEditing: false) { name, amount, unit in
        print("Создано: \(name), \(amount) \(unit.rawValue)")
    }
    .environment(NavigationRouter())
}

#Preview("Создание с дубликатом") {
    ShoppingItemFormView(
        existingItems: [
            ShoppingItem(title: "Чайник", amount: 1, type: .piece),
            ShoppingItem(title: "Молоко", amount: 2, type: .liter)
        ],
        isEditing: false
    ) { name, amount, unit in
        print("Создано: \(name), \(amount) \(unit.rawValue)")
    }
    .environment(NavigationRouter())
}

#Preview("Редактирование") {
    ShoppingItemFormView(isEditing: true) { name, amount, unit in
        print("Изменено: \(name), \(amount) \(unit.rawValue)")
    }
    .environment(NavigationRouter())
}
