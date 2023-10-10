//
//  Storage.swift
//  Simple State Management
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import Foundation

class Storage {
    private let store: UserDefaults
    
    init() {
        self.store = UserDefaults.standard
    }
    
    func setLastQuery(query: String) throws {
        store.setValue(query, forKey: "search_query")
    }
    
    func getLastQuery() throws -> String {
        let savedValue: String? = store.string(forKey: "search_query")
        if (savedValue == nil) {
            return ""
        }
            
        return savedValue!
    }
}
