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
                onItemTap: { entity in
                    router.push(.shoppingItemsScreen(entity: entity))
                }
            )
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                case let .shoppingItemsScreen(entity: item):
                    ShoppingItemsView(entity: item)
                case let .listCreationScreen(mode):
                    ListCreationView(
                        observed: .init(mode: mode),
                        onBackTap: {
                            router.pop()
                        },
                        onCreateTap: { listItem in
                            let newItem = ListDuplicateHelper.makeCopy(from: listItem, in: context)
                            
                            context.insert(newItem.toEntity())
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
                    onSave: { name, amount, unit in
                        
                        guard let route = router.path.last else {
                            router.dismissModal()
                            return
                        }
                        
                        if case let .shoppingItemsScreen(entity) = route {
                            
                            let item = ShoppingItemEntity(
                                title: name,
                                amount: Double(amount) ?? 1,
                                type: unit.rawValue,
                                list: entity
                            )
                            
                            entity.items.append(item)
                            context.insert(item)
                        }
                        
                        router.dismissModal()
                    }
                )
                .environment(router)
                
            case let .editShoppingItem(item):
                ShoppingItemFormView(
                    item: item.toModel(),
                    isEditing: true,
                    onSave: { name, amount, unit in
                        item.title = name
                        item.amount = Double(amount) ?? 1
                        item.type = unit.rawValue

                        router.dismissModal()
                    }
                )
                .environment(router)
            }
        }
    }
}
