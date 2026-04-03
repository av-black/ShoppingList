//
//  ListViewCell.swift
//  ShoppingList34
//
//  Created by Anton Silenin on 03.04.2026.
//

import SwiftUI

struct ListViewCell: View {
    let listItem: ListItem

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(listItem.designColor.color)
                    .frame(width: 56, height: 56)

                listItem.icon.image
                    .font(.title2)
            }

            Text(listItem.title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 2) {
                Text("\(listItem.completedCount)/")
                    .font(.title2)
                Text("\(listItem.totalCount)")
                    .font(.title2)
                    .bold()
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ListViewCell(listItem: .mock)
        .padding()
        .background(Color(.systemGroupedBackground))
}
