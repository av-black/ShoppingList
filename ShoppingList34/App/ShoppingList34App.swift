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
    
    var body: some Scene {
        WindowGroup {
            if appState.hasLaunchedBefore {
                AppNavigationView()
            } else {
                WelcomeView(onStart: appState.completeOnboarding)
            }
        }
        .modelContainer(for: [
            ListItemEntity.self,
            ShoppingItemEntity.self
        ])
    }
}
