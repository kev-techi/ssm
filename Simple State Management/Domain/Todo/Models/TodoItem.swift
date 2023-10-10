//
//  TodoModel.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    let text: String
    
    init(text: String) {
        self.text = text
    }
}
