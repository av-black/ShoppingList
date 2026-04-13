//
//  ListColor.swift
//  ShoppingList34
//
//  Created by Качусов Степан on 02.04.2026.
//

import SwiftUI

enum ListColor: String, CaseIterable, Identifiable {
    case blue = "BlueSelectionSL"
    case green = "GreenSelectionSL"
    case purple = "PurpleSelectionSL"
    case red = "RedSelectionSL"
    case yellow = "YellowSelectionSL"

    var id: String { rawValue }

    var color: Color {
        Color(rawValue)
    }
}
