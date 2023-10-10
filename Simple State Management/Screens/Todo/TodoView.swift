//
//  ContentView.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject var todoState: TodoState
    
    var body: some View {
        _TodoView(todoState: todoState)
    }
}

struct _TodoView: View {
    @ObservedObject private var todoState: TodoState
    private let logic: TodoLogic
    
    init(todoState: TodoState) {
        self.todoState = todoState
        self.logic = TodoLogic(state: todoState)
    }
    
    func onLoad() {
        logic.fetchTodos()
    }
    
    func handleSearchSubmit(text: String) {
        logic.addTodo(text: text)
        
        searchIsFocused = false
    }
    
    func handleRecoverLastQuery() {
        logic.recoverLastQuery()
    }
        
    @FocusState private var searchIsFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Search or create...", text: $todoState.query)
                    .focused($searchIsFocused)
                    .onSubmit {
                        handleSearchSubmit(text: todoState.query)
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .submitLabel(SubmitLabel.search)
            }
            VStack(spacing: 10) {
                if (todoState.query.isEmpty) {Text("Search is empty")}
                if (!todoState.query.isEmpty) {Text("Your query: \"\(todoState.query)\". Submit to create.")}
                if (todoState.loading) {ProgressView()}
                if (todoState.loading) {Rectangle().fill(Color.white)}
                if (!todoState.loading && !todoState.items.isEmpty) {
                    List {
                        ForEach(selectFilteredTodos(state: todoState)) { item in
                            Text("Text: \(item.text)")
                        }
                    }
                }
                HStack {
                    Button("Recover Last Query", action: handleRecoverLastQuery)
                }
            }
            
        }
        .padding()
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .onAppear(perform: onLoad)
    }
}

#Preview {
    _TodoView(todoState: TodoState())
}
