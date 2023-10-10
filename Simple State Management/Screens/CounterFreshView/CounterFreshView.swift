//
//  View.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import SwiftUI

struct CounterFreshView: View {
    var body: some View {
        _CounterView(counterState: CounterState())
    }
}

#Preview {
    CounterFreshView()
}
