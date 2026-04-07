//
//  ColorSelectorView.swift
//  ShoppingList34
//
//  Created by Качусов Степан on 02.04.2026.
//

import SwiftUI

struct ColorSelectorView: View {
    @Binding var selectedColor: ListColor

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            Text(Constants.title)
                .font(AppFont.sectionTitle)
                .foregroundStyle(.blackTextSL)

            HStack(spacing: Constants.itemSpacing) {
                ForEach(ListColor.allCases) { colorItem in
                    Button {
                        selectedColor = colorItem
                    } label: {
                        ZStack {
                            if selectedColor == colorItem {
                                Circle()
                                    .stroke(
                                        Constants.selectionColor,
                                        lineWidth: Constants.selectionLineWidth
                                    )
                                    .frame(
                                        width: Constants.selectionSize,
                                        height: Constants.selectionSize
                                    )
                            }

                            Circle()
                                .fill(colorItem.color)
                                .frame(
                                    width: Constants.circleSize,
                                    height: Constants.circleSize
                                )
                        }
                        .frame(
                            width: Constants.selectionSize,
                            height: Constants.selectionSize
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(.grayCardBackgroundSL)
        .clipShape(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
        )
    }
}

private extension ColorSelectorView {
    enum Constants {
        static let title = "Выберите цвет"

        static let verticalSpacing: CGFloat = 12
        static let itemSpacing: CGFloat = 12

        static let circleSize: CGFloat = 40
        static let selectionSize: CGFloat = 52
        static let selectionLineWidth: CGFloat = 2

        static let horizontalPadding: CGFloat = 12
        static let verticalPadding: CGFloat = 12
        static let cornerRadius: CGFloat = 12

        static let selectionColor = Color.turquoiseUniversalSL
    }
}


