//
//  AppIcon.swift
//  ShoppingList34
//
//  Created by Алла on 26.03.2026.
//

import SwiftUI

enum AppIcon {
    case system(String)
    case asset(String)
}

extension AppIcon {
    var image: Image {
        switch self {
        case .system(let name):
            return Image(systemName: name)
        case .asset(let name):
            return Image(name)
        }
    }
    
    // MARK: - SF Symbols
    
    static let more = AppIcon.system("ellipsis.circle")
    static let back = AppIcon.system("chevron.left")
    static let clear = AppIcon.system("xmark.circle.fill")
    static let edit = AppIcon.system("square.and.pencil")
    static let duplicate = AppIcon.system("plus.square.on.square")
    static let trash = AppIcon.system("trash")
    static let theme = AppIcon.system("circle.lefthalf.filled")
    static let sort = AppIcon.system("arrow.up.arrow.down")
    static let chevronDown = AppIcon.system("chevron.down")
    static let checkmark = AppIcon.system("checkmark")
    static let selector = AppIcon.system("chevron.up.chevron.down")
    static let checkbox = AppIcon.system("square")
    static let checkboxFill = AppIcon.system("square.fill")
    static let checkboxSelected = AppIcon.system("checkmark.square.fill")
    static let share = AppIcon.system("square.and.arrow.up")
    static let reset = AppIcon.system("arrow.trianglehead.2.clockwise.rotate.90")
    static let search = AppIcon.system("magnifyingglass")
    
    // MARK: - Assets: Icons
    
    static let airplane = AppIcon.asset("airplaneSL")
    static let balloon = AppIcon.asset("balloonSL")
    static let bandage = AppIcon.asset("bandageSL")
    static let bed = AppIcon.asset("bedSL")
    static let briefcase = AppIcon.asset("briefcaseSL")
    static let building = AppIcon.asset("buildingSL")
    static let calendar = AppIcon.asset("calendarSL")
    static let car = AppIcon.asset("carSL")
    static let cart = AppIcon.asset("cartSL")
    static let dumbbell = AppIcon.asset("dumbbellSL")
    static let fastfood = AppIcon.asset("fastfoodSL")
    static let gamepad = AppIcon.asset("gamepadSL")
    static let gift = AppIcon.asset("giftSL")
    static let palette = AppIcon.asset("paletteSL")
    static let paw = AppIcon.asset("pawSL")
    static let snow = AppIcon.asset("snowSL")
    static let warning = AppIcon.asset("warningSL")
    static let wrench = AppIcon.asset("wrenchSL")
    static let trashSL = AppIcon.asset("trashSL")
    
    // MARK: - Assets: Images
    
    static let itemsEmptyState = AppIcon.asset("ItemsEmptyStateImage")
    static let mainEmptyState = AppIcon.asset("MainEmptyStateImage")
    static let onboardingMain = AppIcon.asset("onboardingMainImage")
}
