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
    var isEditing: Bool = false
    var onSave: (String, String, MeasurementType) -> Void
    
    init(
        item: ShoppingItem? = nil,
        isEditing: Bool = false,
        onSave: @escaping (String, String, MeasurementType) -> Void
    ) {
        self.item = item
        self.isEditing = isEditing
        self.onSave = onSave
    }
    
    // MARK: - Состояние полей формы
    
    @State private var name = ""
    @State private var amount = ""
    @State private var selectedUnit: MeasurementType = .piece
    
    private var isDoneButtonActive: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && !amount.isEmpty
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
                        onSave(name, amount, selectedUnit)
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
            state: .normal
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
    }
}

// MARK: - Preview

#Preview("Создание") {
    ShoppingItemFormView(isEditing: false) { name, amount, unit in
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
