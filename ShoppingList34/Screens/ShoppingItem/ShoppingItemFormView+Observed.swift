//
//  ShoppingItemFormView+Observed.swift
//  ShoppingList34
//
//  Created by Алла on 16.04.2026.
//

import Foundation
import Observation

extension ShoppingItemFormView {
    @Observable
    final class Observed {
        var name = ""
        var amount = ""
        var selectedUnit: MeasurementType = .piece

        func configure(with item: ShoppingItem?) {
            guard let item else { return }
            name = item.title
            amount = String(item.amount)
            selectedUnit = item.type
        }

        func trimmedName() -> String {
            name.trimmingCharacters(in: .whitespaces)
        }

        func isDuplicate(existingItems: [ShoppingItem], editingItem: ShoppingItem?) -> Bool {
            let trimmed = trimmedName()
            guard !trimmed.isEmpty else { return false }

            return existingItems.contains { existing in
                if let editingItem, existing.id == editingItem.id { return false }
                return existing.title.localizedCaseInsensitiveCompare(trimmed) == .orderedSame
            }
        }

        func nameFieldState(existingItems: [ShoppingItem], editingItem: ShoppingItem?) -> TextFieldState {
            isDuplicate(existingItems: existingItems, editingItem: editingItem)
            ? .error(Constants.duplicateError)
            : .normal
        }

        func isDoneButtonActive(existingItems: [ShoppingItem], editingItem: ShoppingItem?) -> Bool {
            !trimmedName().isEmpty
            && !amount.isEmpty
            && !isDuplicate(existingItems: existingItems, editingItem: editingItem)
        }
    }
}

// MARK: - Constants

extension ShoppingItemFormView.Observed {
    enum Constants {
        static let duplicateError = "Этот товар уже есть в списке, добавьте другой"
    }
}
