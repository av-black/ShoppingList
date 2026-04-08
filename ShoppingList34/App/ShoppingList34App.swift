//
//  ShoppingList34App.swift
//  ShoppingList34
//
//  Created by Nikita Tsomuk on 23.03.2026.
//

import SwiftUI

@main
struct ShoppingList34App: App {
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.hasLaunchedBefore {
                ContentView()
            } else {
                WelcomeView(onStart: appState.completeOnboarding)
            }
        }
    }
}
