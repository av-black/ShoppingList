//
//  ShoppingItemsView.swift
//  ShoppingList34
//
//  Created by Алла on 07.04.2026.
//

import SwiftUI

struct ShoppingItemsView: View {
    let title: String
    let shoppingItems: [ShoppingItem]
    
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                navigationBar
                searchBar
                    .padding(.top, 4)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                itemsList
            }
            
            addItemButton
        }
        .background(.grayMainBackgroundSL)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Subviews

private extension ShoppingItemsView {
    
    // MARK: - Navigation Bar
    
    var navigationBar: some View {
        HStack(spacing: 8) {
            backButton
            titleView
            Spacer()
            // moreButton
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 16)
    }
    
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            AppIcon.back.image
                .foregroundStyle(.blackIconSL)
                .font(AppFont.sectionTitle)
                .frame(width: 28, height: 28)
        }
    }
    
    var titleView: some View {
        Text(title)
            .font(AppFont.headline)
            .foregroundStyle(.blackTitleSL)
    }
    
    //    var moreButton: some View {
    //        MoreButton(
    //            action: {}
    //        )
    //    }
    
    // MARK: - Search
    
    var searchBar: some View {
        HStack {
            AppIcon.search.image
                .foregroundStyle(.grayHintUniversalSL)
                .font(AppFont.body)
            
            TextField(
                "",
                text: $searchText,
                prompt: Text(Constants.promptText)
                    .foregroundStyle(.grayHintUniversalSL)
                    .font(AppFont.body)
            )
            .font(AppFont.body)
            .foregroundStyle(.blackTextSL)
        }
        .padding(8)
        .background(.grayFieldBackgroundSL)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    // MARK: - List
    
    var itemsList: some View {
        List {
            ForEach(shoppingItems) { item in
                shoppingItemRow(for: item)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
        }
        .padding(.bottom, 80)
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
    
    // MARK: - Rows
    
    private func shoppingItemRow(for item: ShoppingItem) -> some View {
        VStack(spacing: 0) {
            ShoppingItemViewCell(
                shoppingItem: item,
                onCheckboxTap: {}
            )
            
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(Color.graySeparatorSL)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            deleteSwipeAction
            editSwipeAction
        }
    }
    
    // MARK: - Swipe Actions
    
    var editSwipeAction: some View {
        Button {
            print("Edit tapped")
        } label: {
            AppIcon.edit.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.grayEditSL)
    }
    
    var deleteSwipeAction: some View {
        Button {
            print("Delete tapped")
        } label: {
            AppIcon.trashSL.image
                .font(AppFont.body)
                .foregroundStyle(.whiteUniversalSL)
        }
        .tint(.redSL)
    }
    
    // MARK: - Bottom
    
    var addItemButton: some View {
        BaseButton(
            title: Constants.buttonText,
            isActive: true,
            action: {}
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

// MARK: - Constants

private extension ShoppingItemsView {
    enum Constants {
        static let promptText = "Поиск"
        static let buttonText = "Добавить товар"
    }
}

#Preview {
    NavigationStack {
        ShoppingItemsView(
            title: ListItem.mock.title,
            shoppingItems: ListItem.mock.shoppingItem
        )
    }
}
