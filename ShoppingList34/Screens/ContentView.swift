//
//  ContentView.swift
//  ShoppingList34
//
//  Created by Nikita Tsomuk on 23.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedColor: ListColor = .blue
    @State private var isDarkMode = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                ColorSelectorView(selectedColor: $selectedColor)

                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationTitle("Создать список")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Тема") {
                        isDarkMode.toggle()
                    }
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
