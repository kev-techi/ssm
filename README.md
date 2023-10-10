# Simple State Management in Swift UI

## State

Define what should be available to your views and define the specific ways in which the data should be modified.

### Data
```
class TodoState: ObservableObject {
    @Published var loading: Bool = false
    @Published var error: Bool = false
    
    @Published var items: [TodoItem] = []
    
    @Published var query: String = ""
}
```

### Methods to update the data
```
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
```

## Logic

Call external services and device APIs. Trigger multiple state methods to update the state based on how the calls to those services go. 

### Setup
```
class TodoLogic {
    let state: TodoState
    let storage: Storage = Storage()
    
    init(state: TodoState) {
        self.state = state
    }
}
```

## Methods
```
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
```

## Selectors

Combine multiple state values together to produce a single result that can be used by your views. 

Always takes a state as an input.

```
func selectFilteredTodos(state: TodoState) -> [TodoItem] {
    if (state.query.isEmpty) {
        return state.items
    }
    
    return state.items.filter { item in
        item.text.lowercased().contains(state.query.lowercased())
    }
}
```

## Instantiation

### App level

Through EnvironmentObject, this instance of `CounterState` will be available through the underlying view hierarchy

```
@main
struct SimpleApp: App {
    let todoState = TodoState()
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(todoState)
        }
    }
}
```

### Local level

This view will have its own instance of `CounterState`:

```
struct CounterView: View {
    var body: some View {
        _CounterView(counterState: CounterState())
    }
}
```

## Accessing State from views

Get the EnvironmentObject:
```
struct TodoView: View {
    @EnvironmentObject var todoState: TodoState
    
    var body: some View {
        _TodoView(todoState: todoState)
    }
}
```

Using ObservedObject, any changes to your state will update your view:
```
struct _TodoView: View {
    @ObservedObject private var todoState: TodoState
    
    init(todoState: TodoState) {
        self.todoState = todoState
    }
    
    var body: some View {
        VStack{
            List {
                ForEach(todoState.items) { item in
                    Text("Text: \(item.text)")
                }
            }
        }
    }
}
```

You can instantiate Logic and call methods to update your State
```
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
    
    var body: some View {
        VStack(alignment: .leading) {
            ...
        }
        .onAppear(perform: onLoad)
    }
}
```

Selectors can be used to combine State data and update the UI
```
struct _TodoView: View {
    @ObservedObject private var todoState: TodoState
    private let logic: TodoLogic
    
    init(todoState: TodoState) {
        self.todoState = todoState
        self.logic = TodoLogic(state: todoState)
    }
    
    var body: some View {
        VStack{
            List {
                ForEach(selectFilteredTodos(state: todoState)) { item in
                    Text("Text: \(item.text)")
                }
            }
        }
    }
}
```
