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
    var modalRoute: ModalRoute?
    
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
    
    func showModal(_ route: ModalRoute) {
        modalRoute = route
    }
    
    func dismissModal() {
        modalRoute = nil
    }
}
