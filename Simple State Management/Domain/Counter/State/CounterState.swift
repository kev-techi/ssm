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
    private func setState(modify: @escaping() -> Void) {
        Task {
            await MainActor.run {
                modify()
            }
        }
    }
        
    func increment() {
        setState {
            self.counter += 1
        }
    }
    
    func decrement() {
        setState {
            self.counter -= 1
        }
    }
    
    func reset() {
        setState {
            self.counter = 0
        }
    }
}
