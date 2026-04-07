//
//  AppState.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 07.04.2026.
//

import SwiftUI

@Observable
final class AppState {
    var hasLaunchedBefore: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.hasLaunchedBefore) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.hasLaunchedBefore) }
    }

    /// Вызывается при нажатии "Начать" на WelcomeView
    func completeOnboarding() {
        hasLaunchedBefore = true
    }
}

private enum Keys {
    static let hasLaunchedBefore = "hasLaunchedBefore"
}
