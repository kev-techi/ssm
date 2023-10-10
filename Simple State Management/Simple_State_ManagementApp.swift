//
//  Simple_State_ManagementApp.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

@main
struct Simple_State_ManagementApp: App {
    let counterState = CounterState()
    
    var body: some Scene {
        WindowGroup {
            RouterView().environmentObject(counterState)
        }
    }
}
