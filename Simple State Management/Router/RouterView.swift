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
                "Counter View",
                systemImage: "rectangle.badge.plus"
            ) }
            CounterReadOnlyView().tabItem { Label(
                "Counter View (readonly)",
                systemImage: "rectangle.fill.badge.plus"
            ) }
            Home1View().tabItem { Label(
                "View 2",
                systemImage: "house.circle"
            ) }
        }
    }
}
