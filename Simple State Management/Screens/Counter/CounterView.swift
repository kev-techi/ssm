//
//  View.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

struct CounterView: View {
    @EnvironmentObject var counterState: CounterState
    
    var body: some View {
        _CounterView(counterState: counterState)
    }
}

struct _CounterView: View {
    @ObservedObject var counterState: CounterState
    let logic: CounterLogic
    
    init(counterState: CounterState) {
        self.counterState = counterState
        self.logic = CounterLogic(state: counterState)
    }
    
    func handleBumpUp() {
        logic.bumpUpCounter()
    }
    
    func handleBumpDown() {
        logic.bumpDownCounter()
    }
    
    func handleReset() {
         logic.reset()
    }
    
    var body: some View {
        VStack{
            Text("Amount: \(counterState.counter)")
            Divider()
            Button("Add", systemImage: "plus", action: handleBumpUp)
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
