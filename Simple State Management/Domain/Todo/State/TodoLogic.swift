//
//  TodoLogic.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

class TodoLogic {
    let state: TodoState
    let storage: Storage = Storage()
    
    init(state: TodoState) {
        self.state = state
    }
}

extension TodoLogic {
    func addTodo(text: String) {
        do {
            state.addTodo(item: TodoItem(text: text))
            
            try storage.setLastQuery(query: text)
        } catch {}
    }
    
    func fetchTodos() {
        Task {
            do {
                state.fetchTodoRequest()
                
                // fake delay
                try await Task.sleep(nanoseconds: 2000000000)
                let fetchedItems: [TodoItem] = [
                    TodoItem(text: "first item"),
                    TodoItem(text: "second item"),
                ]
                
                state.fetchTodoSuccess(items: fetchedItems)
            } catch {
                state.fetchTodoFail()
            }
        }
    }

    func recoverLastQuery() {
        do {
            let lastQuery = try storage.getLastQuery()
            
            state.setQuery(query: lastQuery)
        } catch {}
    }
}
