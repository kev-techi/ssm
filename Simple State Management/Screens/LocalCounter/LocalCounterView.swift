//
//  View.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

struct LocalCounterView: View {
    @State private var counter: Int = 0
    
    func handleBumpUp() {
        counter += 1
    }
    
    func handleAsyncBumpUp() {
        Task {
            try await Task.sleep(nanoseconds: 1000000000)
            
            counter += 1
        }
    }
    
    func handleBumpDown() {
        counter -= 1
    }
    
    func handleReset() {
         counter = 0
    }
    
    var body: some View {
        VStack{
            Text("Amount: \(counter)")
            Divider()
            Button("Add", systemImage: "plus", action: handleBumpUp)
            Divider()
            Button("Async Add", systemImage: "plus", action: handleAsyncBumpUp)
            Divider()
            Button("Remove", systemImage: "minus", action: handleBumpDown)
            Divider()
            Button("Reset", systemImage: "trash", action: handleReset)
        }
    }
}

#Preview {
    _CounterView(counterState: CounterState())
}
