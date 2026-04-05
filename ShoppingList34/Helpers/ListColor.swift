//
//  ListColor.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import SwiftUI

enum ListColor: String, Codable, CaseIterable {
    case blue   = "BlueSelectionSL"
    case green  = "GreenSelectionSL"
    case purple = "PurpleSelectionSL"
    case red    = "RedSelectionSL"
    case yellow = "YellowSelectionSL"

    var color: Color {
        Color(self.rawValue)
    }
}
