//
//  State.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

class CounterState: ObservableObject {
    @Published var counter: Int = 0
}

extension CounterState {
    func increment() {
        counter += 1
    }
    
    func decrement() {
        counter -= 1
    }
    
    func reset() {
        counter = 0
    }
}
