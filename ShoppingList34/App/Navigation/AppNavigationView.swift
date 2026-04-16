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
            rootScreen
                .navigationDestination(for: NavigationRoute.self) { route in
                    destination(for: route)
                }
        }
        .environment(router)
        .sheet(item: $router.modalRoute) { route in
            modal(for: route)
        }
    }
}

// MARK: - Private Builders

private extension AppNavigationView {
    private var rootScreen: some View {
        ListView(
            onCreateTap: {
                router.push(
                    .listCreationScreen(mode: .create)
                )
            },
            onItemTap: { entity in
                router.push(.shoppingItemsScreen(entity: entity))
            },
            onEditTap: { mode in
                router.push(.listCreationScreen(mode: mode))
            }
        )
    }
    
    @ViewBuilder
    private func destination(for route: NavigationRoute) -> some View {
        switch route {
        case let .shoppingItemsScreen(entity: item):
            shoppingItemsScreen(entity: item)
            
        case let .listCreationScreen(mode):
            listCreationScreen(mode: mode)
        }
    }
    
    @ViewBuilder
    private func modal(for route: ModalRoute) -> some View {
        switch route {
        case .createShoppingItem:
            createShoppingItemModal()
            
        case let .editShoppingItem(item):
            editShoppingItemModal(item: item)
        }
    }
    
    private func shoppingItemsScreen(entity: ListItemEntity) -> some View {
        ShoppingItemsView(
            entity: entity,
            onBackTap: {
                router.pop()
            },
            onCreateItemTap: {
                router.showModal(.createShoppingItem)
            },
            onEditItemTap: { item in
                router.showModal(.editShoppingItem(item: item))
            }
        )
    }
    
    private func listCreationScreen(mode: ListCreationModel) -> some View {
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
    
    private func createShoppingItemModal() -> some View {
        ShoppingItemFormView(
            existingItems: currentShoppingItems,
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
    }
    
    private func editShoppingItemModal(item: ShoppingItemEntity) -> some View {
        ShoppingItemFormView(
            item: item.toModel(),
            existingItems: currentShoppingItems,
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

    private var currentShoppingItems: [ShoppingItem] {
        guard case let .shoppingItemsScreen(entity) = router.path.last else {
            return []
        }
        return entity.items.map { $0.toModel() }
    }
}
