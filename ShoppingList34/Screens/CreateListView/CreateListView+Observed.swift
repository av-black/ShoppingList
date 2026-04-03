//
//  CreateListView+Observed.swift
//  ShoppingList34
//
//  Created by Smirnov Michael on 31.03.2026.
//

import SwiftUI
import Observation   

extension CreateListView {
    @MainActor
    @Observable
    final class Observed {
        var name: String = ""
        var state: TextFieldState = .normal
        
        private let existingLists = ["Новый год"]
        
        var isButtonActive: Bool {
            !name.isEmpty && !isDuplicate(name)
        }
        
        func validate() {
            if isDuplicate(name) {
                state = .error("Это название уже используется, пожалуйста, измените его.")
            } else {
                state = .normal
            }
        }
        
        func createList() {
            validate()
            guard isButtonActive else { return }
            
            print("List created: \(name)")
        }
        
        private func isDuplicate(_ name: String) -> Bool {
            existingLists.contains(name)
        }
    }
}
