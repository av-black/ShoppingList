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
        get { UserDefaults.standard.bool(forKey: "hasLaunchedBefore") }
        set { UserDefaults.standard.set(newValue, forKey: "hasLaunchedBefore") }
    }

    /// Вызывается при нажатии "Начать" на WelcomeView
    func completeOnboarding() {
        hasLaunchedBefore = true
    }
}
