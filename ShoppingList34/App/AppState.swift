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
        didSet {
            UserDefaults.standard.set(hasLaunchedBefore, forKey: Keys.hasLaunchedBefore)
        }
    }

    init() {
        hasLaunchedBefore = UserDefaults.standard.bool(forKey: Keys.hasLaunchedBefore)
    }

    func completeOnboarding() {
        hasLaunchedBefore = true
    }
}

private enum Keys {
    static let hasLaunchedBefore = "hasLaunchedBefore"
}
