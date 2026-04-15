//
//  ShoppingList34App.swift
//  ShoppingList34
//
//  Created by Nikita Tsomuk on 23.03.2026.
//

import SwiftUI
import SwiftData

@main
struct ShoppingList34App: App {
    @State private var appState = AppState()
    @State private var themeStore = ThemeStore()

    var body: some Scene {
        WindowGroup {
            Group {
                if appState.hasLaunchedBefore {
                    AppNavigationView()
                } else {
                    WelcomeView(onStart: appState.completeOnboarding)
                }
            }
            .environment(themeStore)
            .preferredColorScheme(themeStore.selectedTheme.colorScheme)
        }
        .modelContainer(for: [
            ListItemEntity.self,
            ShoppingItemEntity.self
        ])
    }
}
