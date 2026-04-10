//
//  NavigationRouter.swift
//  ShoppingList34
//
//  Created by Алла on 10.04.2026.
//

import Foundation

@Observable
final class NavigationRouter {
    var path: [NavigationRoute] = []
    
    func push(_ route: NavigationRoute) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
