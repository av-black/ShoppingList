//
//  CategoryPickerView.swift
//  ShoppingList34
//
//  Created by Дмитрий Перчемиди on 07.04.2026.
//

import SwiftUI

struct CategoryPickerView: View {
    
    let items: [CategoryItem]
    @Binding var selectedItem: CategoryItem
    let selectedColor: Color
    
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 6
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(Constants.title)
                .font(AppFont.sectionTitle)
                .foregroundStyle(.blackTextSL)
                .padding(12)
                
            LazyVGrid(
                columns: columns,
                spacing: 12
            ) {
                ForEach(items) { item in
                    CategoryCell(
                        item: item,
                        isSelected: item.id == selectedItem.id,
                        selectedColor: selectedColor
                    )
                    .onTapGesture {
                        handleSelect(item)
                    }
                }
            }
            .padding(.bottom, 12)
            .padding(.horizontal, 7.5)
            
        }
        .background(.grayCardBackgroundSL)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private func handleSelect(_ item: CategoryItem) {
        selectedItem = item
    }
}

private extension CategoryPickerView {
    enum Constants {
        static let title = "Выберите дизайн"
    }
}

struct PreviewWrapper: View {
    @State private var selected = CategoryItem(icon: AppIcon.airplane)
    
    var body: some View {
        CategoryPickerView(
            items: CategoryItem.mockCategoryItems,
            selectedItem: $selected,
            selectedColor: ListColor.blue.color,
        )
    }
}

#Preview("Light") {
    PreviewWrapper()
        .padding()
        .background(Color(.systemGroupedBackground))
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    PreviewWrapper()
        .padding()
        .background(Color(.systemGroupedBackground))
        .preferredColorScheme(.dark)
}
