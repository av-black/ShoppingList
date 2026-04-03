//
//  CreateListView.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 31.03.2026.
//

import SwiftUI

struct CreateListView: View {
    @State private var observed = Observed()
    
    var body: some View {
        VStack {
            
            CustomTextField(
                placeholder: "Введите название списка",
                text: $observed.name,
                state: observed.state
            )
            .padding(.top, 56)
            .padding(.horizontal, 16)
            .onChange(of: observed.name) {
                observed.validate()
            }
            
            Spacer()
            
            PrimaryButton(
                title: "Создать",
                isActive: observed.isButtonActive,
                action: observed.createList
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(
            Color("GrayMainBackgroundSL")
                .ignoresSafeArea()
        )
    }
}
