//
//  AppNavigationView.swift
//  ShoppingList34
//
//  Created by Алла on 10.04.2026.
//

import SwiftUI
import SwiftData
import Observation

/// Корневой экран навигации приложения.
/// Отвечает за настройку NavigationStack и переходы между экранами.
struct AppNavigationView: View {
    @State private var router = NavigationRouter()
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ListView(
                onCreateTap: {
                    router.push(
                        .listCreationScreen(mode: .create)
                    )
                },
                onItemTap: { item in
                    router.push(
                        .shoppingItemsScreen(
                            title: item.title,
                            shoppingItems: item.shoppingItem
                        )
                    )
                }
            )
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                case let .shoppingItemsScreen(title, shoppingItems):
                    ShoppingItemsView(
                        title: title,
                        shoppingItems: shoppingItems
                    )
                    
                case let .listCreationScreen(mode):
                    ListCreationView(
                        observed: .init(mode: mode),
                        onBackTap: {
                            router.pop()
                        },
                        onCreateTap: { listItem in
                            let entity = listItem.toEntity()
                            context.insert(entity)
                            router.pop()
                        },
                        onSaveTap: { listItem in
                            let id = listItem.id
                            
                            let descriptor = FetchDescriptor<ListItemEntity>(
                                predicate: #Predicate { $0.id == id }
                            )
                            
                            if let entity = try? context.fetch(descriptor).first {
                                
                                entity.title = listItem.title
                                entity.color = listItem.designColor.rawValue
                                entity.icon = listItem.icon.rawValue
                                
                            } else {
                                context.insert(listItem.toEntity())
                            }
                            router.pop()
                        }
                    )
                }
            }
        }
        .environment(router)
        .sheet(item: $router.modalRoute) { route in
            switch route {
            case .createShoppingItem:
                ShoppingItemFormView(
                    isEditing: false,
                    onSave: { _, _, _ in
                        router.dismissModal()
                    }
                )
                .environment(router)
                
            case let .editShoppingItem(item):
                ShoppingItemFormView(
                    item: item,
                    isEditing: true,
                    onSave: { _, _, _ in
                        router.dismissModal()
                    }
                )
                .environment(router)
            }
        }
    }
}
