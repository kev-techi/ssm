//
//  TodoState.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

class TodoState: ObservableObject {
    @Published var loading: Bool = false
    @Published var error: Bool = false
    
    @Published var items: [TodoItem] = []
    
    @Published var query: String = ""
}

extension TodoState {
   private func setState(modify: @escaping() -> Void) {
        Task {
            await MainActor.run {
                modify()
            }
        }
    }
    
    func fetchTodoRequest() {
        setState {
            self.loading = true
            self.error = false
        }
    }
    
    func fetchTodoSuccess(items: [TodoItem]) {
        setState {
            self.loading = false
            self.error = false
            self.items.removeAll()
            self.items.append(contentsOf: items)
        }
    }
    
    func fetchTodoFail() {
        setState {
            self.loading = false
            self.error = true
        }
    }
    
    func setQuery(query: String) {
        setState {
            self.query = query
        }
    }
    
    func addTodo(item: TodoItem) {
        setState {
            self.items.insert(item, at: 0)
            self.query = ""
        }
    }
}
