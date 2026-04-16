//
//  ListView.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 07.04.2026.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query
    private var entities: [ListItemEntity]
    private var sortedEntities: [ListItemEntity] {
        entities.sorted {
            isSortedAscending
            ? $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            : $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedDescending
        }
    }
    @Environment(NavigationRouter.self)
    private var router
    @Environment(\.modelContext)
    private var context
    @State private var isSortedAscending = true
    @State private var activeAlert: ListViewAlert?
    
    let onCreateTap: () -> Void
    let onItemTap: (ListItemEntity) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                header
                if entities.isEmpty {
                    emptyState
                } else {
                    listContent
                }
            }
            createButton
        }
        .background(.grayMainBackgroundSL)
        .alert(item: $activeAlert) { alert in
            makeAlert(for: alert)
        }
    }
}

// MARK: - Subviews

private extension ListView {
    var header: some View {
        HStack {
            Text(Constants.title)
                .font(AppFont.title1)
                .foregroundStyle(.blackTitleSL)
            Spacer()
            ListOptionsMenu(onSortTap: handleSortTap)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    var emptyState: some View {
        NoListsPlaceholderView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var listContent: some View {
        List {
            ForEach(sortedEntities) { entity in
                Button {
                    onItemTap(entity)
                } label: {
                    ListViewCell(listItem: entity.toModel())
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    deleteAction(for: entity)
                    duplicateAction(for: entity)
                    editAction(for: entity)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 80)
        }
    }
    
    var createButton: some View {
        BaseButton(
            title: Constants.buttonTitle,
            isActive: true,
            action: onCreateTap
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
    }
    
    func handleSortTap() {
        isSortedAscending.toggle()
    }
    
    func deleteAction(for entity: ListItemEntity) -> some View {
        Button {
            activeAlert = .deleteList(entity)
        } label: {
            AppIcon.trash.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.redSL)
    }
    
    func editAction(for entity: ListItemEntity) -> some View {
        Button {
            handleEdit(entity)
        } label: {
            AppIcon.edit.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.gray)
    }
    
    func duplicateAction(for entity: ListItemEntity) -> some View {
        Button {
            handleDuplicate(entity)
        } label: {
            AppIcon.duplicate.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.orangeDuplicateSL)
    }
    
    func makeAlert(for alert: ListViewAlert) -> Alert {
        switch alert {
        case let .deleteList(entity):
            return Alert(
                title: Text(Constants.deleteListAlertTitle),
                message: Text(Constants.deleteListAlertMessage),
                primaryButton: .cancel(Text(Constants.cancelButtonTitle)),
                secondaryButton: .destructive(
                    Text(Constants.deleteButtonTitle),
                    action: {
                        handleDelete(entity)
                    }
                )
            )
        }
    }
    
    func handleDelete(_ entity: ListItemEntity) {
        context.delete(entity)
    }
    
    func handleEdit(_ entity: ListItemEntity) {
        let model = entity.toModel()
        
        router.push(
            .listCreationScreen(
                mode: .edit(
                    id: model.id,
                    title: model.title,
                    selectedColor: model.designColor,
                    selectedCategory: CategoryItem(icon: model.icon)
                )
            )
        )
    }
    
    func handleDuplicate(_ entity: ListItemEntity) {
        let newItem = ListDuplicateHelper.makeCopy(from: entity.toModel(), in: context)
        
        context.insert(newItem.toEntity())
    }
}

// MARK: - Constants

private extension ListView {
    enum Constants {
        static let title = "Мои списки"
        static let buttonTitle = "Создать список"
        static let deleteListAlertTitle = "Удаление списка"
        static let deleteListAlertMessage = "Вы действительно хотите удалить список?"
        static let cancelButtonTitle = "Отменить"
        static let deleteButtonTitle = "Удалить"
    }
}

// MARK: - Preview

enum PreviewContainer {
    static let container: ModelContainer = {
        // swiftlint:disable:next force_try
        let container = try! ModelContainer(
            for: ListItemEntity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        let context = container.mainContext
        
        ListItem.mocks.forEach {
            context.insert($0.toEntity())
        }
        
        return container
    }()
}

private enum ListViewAlert: Identifiable {
    case deleteList(ListItemEntity)

    var id: UUID {
        switch self {
        case let .deleteList(entity):
            return entity.id
        }
    }
}

#Preview("Пустой") {
    ListView(
        onCreateTap: {},
        onItemTap: { _ in }
    )
    .environment(ThemeStore())
}

#Preview("С данными") {
    ListView(
        onCreateTap: {},
        onItemTap: { _ in }
    )
    .modelContainer(PreviewContainer.container)
    .environment(ThemeStore())
}
