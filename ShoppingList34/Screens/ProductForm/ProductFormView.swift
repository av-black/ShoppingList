//
//  ProductFormView.swift
//  ShoppingList34
//
//  Created by МAK on 07.04.2026.
//

import SwiftUI
 
struct ProductFormView: View {

    @Environment(\.dismiss) private var dismiss

    var isEditing: Bool = false
    var onSave: (String, String, MeasurementType) -> Void
 
    // MARK: - Состояние полей формы
 
    @State private var name = ""
    @State private var amount = ""
    @State private var selectedUnit: MeasurementType = .piece
    @State private var nameFieldState: TextFieldState = .normal

    private var isDoneButtonActive: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && !amount.isEmpty
    }
 
    // MARK: - Body
 
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
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
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Constants.doneButton) {
                        onSave(name, amount, selectedUnit)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(!isDoneButtonActive)
                }
            }
        }
    }
}
 
// MARK: - Подвью

private extension ProductFormView {
 
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
            .keyboardType(.decimalPad)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(.whiteUniversalSL)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.grayHintUniversalSL, lineWidth: 0.5)
            )
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
        .background(.whiteUniversalSL)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayHintUniversalSL, lineWidth: 0.5)
        )
    }
}

private extension ProductFormView {
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
    ProductFormView(isEditing: false) { name, amount, unit in
        print("Создано: \(name), \(amount) \(unit.rawValue)")
    }
}
 
#Preview("Редактирование") {
    ProductFormView(isEditing: true) { name, amount, unit in
        print("Изменено: \(name), \(amount) \(unit.rawValue)")
    }
}
