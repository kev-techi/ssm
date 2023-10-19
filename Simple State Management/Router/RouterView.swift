//
//  Router.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

struct RouterView : View {
    var body: some View {
        TabView{
            CounterView().tabItem { Label(
                "Counter1",
                systemImage: "rectangle.badge.plus"
            ) }
            CounterReadOnlyView().tabItem { Label(
                "Counter1 (readonly)",
                systemImage: "rectangle.fill.badge.plus"
            ) }
            CounterFreshView().tabItem { Label(
                "Counter2 (fresh)",
                systemImage: "rectangle.fill.badge.plus"
            ) }
            LocalCounterView().tabItem { Label(
                "Local Counter",
                systemImage: "rectangle.badge.plus"
            ) }
            TodoView().tabItem { Label(
                "To Do",
                systemImage: "checklist"
            ) }
        }
    }
}
