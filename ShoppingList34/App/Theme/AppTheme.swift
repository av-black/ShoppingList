//
//  AppTheme.swift
//  ShoppingList34
//
//  Created by Качусов Степан on 11.04.2026.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case light
    case dark
    case system

    var id: String { rawValue }

    var title: String {
        switch self {
        case .light:
            "Светлая"
        case .dark:
            "Темная"
        case .system:
            "Системная"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        case .system:
            nil
        }
    }
}
