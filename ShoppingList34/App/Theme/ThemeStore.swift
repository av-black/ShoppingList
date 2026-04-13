//
//  ThemeStore.swift
//  ShoppingList34
//
//  Created by Качусов Степан on 11.04.2026.
//

import Observation
import Foundation

@Observable
final class ThemeStore {
    var selectedTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(
                selectedTheme.rawValue,
                forKey: Keys.selectedTheme
            )
        }
    }

    init() {
        let savedValue = UserDefaults.standard.string(
            forKey: Keys.selectedTheme
        )

        selectedTheme = AppTheme(rawValue: savedValue ?? "") ?? .system
    }

    func setTheme(_ theme: AppTheme) {
        selectedTheme = theme
    }
}

private enum Keys {
    static let selectedTheme = "selectedTheme"
}
