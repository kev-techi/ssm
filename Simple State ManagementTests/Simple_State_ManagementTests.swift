//
//  Simple_State_ManagementTests.swift
//  Simple State ManagementTests
//
//  Created by Kevin Sundar Raj on 10/10/2023.
//

import XCTest
@testable import Simple_State_Management

final class TodoStateTests: XCTestCase {
    let state = TodoState()
    var logic = TodoLogic(state: TodoState())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        logic = TodoLogic(state: state)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDefaultState() throws {
        XCTAssert(state.query == "")
        XCTAssert(state.items.isEmpty)
        XCTAssert(state.loading == false)
        XCTAssert(state.error == false)
    }
    
    func testFetchTodoItems() async throws {
        XCTAssert(state.items.count == 0)
        
        await logic.fetchTodos()
        
        // give the UI time to update
        try await Task.sleep(nanoseconds: 1000000)
        
        XCTAssert(state.items.count == 2)
        XCTAssert(state.items[0].text == "first item")
        XCTAssert(state.items[1].text == "second item")
    }
    
    func testAddTodoItem() async throws {
        logic.addTodo(text: "first item")
        logic.addTodo(text: "second item")
        
        // give the UI time to update
        try await Task.sleep(nanoseconds: 1000000)
        
        XCTAssert(state.items.count == 2)
        XCTAssert(state.items[0].text == "second item")
        XCTAssert(state.items[1].text == "first item")
    }
    
    func testQueryItem() async throws {
        logic.addTodo(text: "first item")
        logic.addTodo(text: "second item")
        
        // give the UI time to update
        try await Task.sleep(nanoseconds: 1000000)
        
        XCTAssert(state.items.count == 2)
        XCTAssert(state.items[0].text == "second item")
        XCTAssert(state.items[1].text == "first item")
        
        state.setQuery(query: "item")
        
        // give the UI time to update
        try await Task.sleep(nanoseconds: 1000000)
        
        XCTAssert(state.query == "item")
        
        var filteredItems = selectFilteredTodos(state: state)
        XCTAssert(filteredItems.count == 2)
        XCTAssert(filteredItems[0].text == "second item")
        XCTAssert(filteredItems[1].text == "first item")
        
        state.setQuery(query: "second")
        
        // give the UI time to update
        try await Task.sleep(nanoseconds: 1000000)
        
        filteredItems = selectFilteredTodos(state: state)
        XCTAssert(filteredItems.count == 1)
        XCTAssert(filteredItems[0].text == "second item")
    }
}
