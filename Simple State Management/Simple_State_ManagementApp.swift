//
//  Simple_State_ManagementApp.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

@main
struct Simple_State_ManagementApp: App {
    let storage = Storage();
    
    let counterState = CounterState()
    let todoState = TodoState()
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(counterState)
                .environmentObject(todoState)
        }
    }
}
