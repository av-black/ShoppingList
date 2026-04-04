//
//  ColorSelectionView.swift
//  ShoppingList34
//
//  Created by Качусов Степан on 02.04.2026.
//

import SwiftUI

struct ColorSelectorView: View {
    @Binding var selectedColor: ListColor
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            Text(Constants.title)
                .font(.system(size: Constants.titleFontSize))
                .foregroundStyle(titleColor)

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
        .background(backgroundColor)
        .clipShape(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
        )
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? Color.grayCardBackgroundSL : .white
    }

    private var titleColor: Color {
        colorScheme == .dark ? Color.whiteGrayTextSL : .black
    }
}

private extension ColorSelectorView {
    enum Constants {
        static let title = "Выберите цвет"

        static let titleFontSize: CGFloat = 16
        static let verticalSpacing: CGFloat = 12
        static let itemSpacing: CGFloat = 12

        static let circleSize: CGFloat = 48
        static let selectionSize: CGFloat = 60
        static let selectionLineWidth: CGFloat = 3

        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 20

        static let selectionColor = Color.turquoiseUniversalSL
    }
}
