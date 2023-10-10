//
//  Logic.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

class CounterLogic {
    let state: CounterState
    
    init(state: CounterState) {
        self.state = state
    }
}

extension CounterLogic {
    func bumpUpCounter() {
        state.increment()
    }
    
     func asyncBumpUpCounter() {
        Task {
            try await Task.sleep(nanoseconds: 1000000000)
            
            state.increment()
        }
    }
    
    func bumpDownCounter() {
        state.decrement()
    }
    
    func asyncBumpDownCounter() {
       Task {
           try await Task.sleep(nanoseconds: 1000000000)
           
           state.decrement()
       }
   }
    
    func reset() {
        state.reset()
    }
}
