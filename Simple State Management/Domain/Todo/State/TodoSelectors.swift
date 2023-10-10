//
//  TodoSelectors.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

func selectFilteredTodos(state: TodoState) -> [TodoItem] {
    if (state.query.isEmpty) {
        return state.items
    }
    
    return state.items.filter { item in
        item.text.lowercased().contains(state.query.lowercased())
    }
}
