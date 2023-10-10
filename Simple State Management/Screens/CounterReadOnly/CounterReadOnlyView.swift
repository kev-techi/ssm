//
//  CounterReadOnlyView.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

struct CounterReadOnlyView: View {
    @EnvironmentObject var counterState: CounterState
    
    var body: some View {
        _CounterReadOnlyView(counterState: counterState)
    }
}

private struct _CounterReadOnlyView: View {
    @ObservedObject var counterState: CounterState
    
    init(counterState: CounterState) {
        self.counterState = counterState
    }
    
    var body: some View {
        VStack{
            Text("Read the value from CounterState")
            Text("This is the amount: \(counterState.counter)")
        }
    }
}

#Preview {
    _CounterReadOnlyView(counterState: CounterState())
}
