//
//  ColorSelectionView.swift
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
                .font(.system(size: Constants.titleFontSize))
                .foregroundStyle(Constants.titleColor)

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
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(Constants.containerPadding)
        .background(Constants.backgroundColor)
        .clipShape(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
        )
    }
}

private extension ColorSelectorView {
    enum Constants {
        static let title = "Выберите цвет"

        static let titleFontSize: CGFloat = 16
        static let titleColor = Color.whiteGrayTextSL

        static let verticalSpacing: CGFloat = 12
        static let itemSpacing: CGFloat = 16

        static let circleSize: CGFloat = 48
        static let selectionSize: CGFloat = 60
        static let selectionLineWidth: CGFloat = 3

        static let containerPadding: CGFloat = 12
        static let cornerRadius: CGFloat = 12

        static let backgroundColor = Color.grayFieldBackgroundSL

        static let selectionColor = Color.turquoiseUniversalSL
    }
}
