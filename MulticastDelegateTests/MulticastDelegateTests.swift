//
//  MulticastDelegateTests.swift
//  MulticastDelegateTests
//
//  Created by Catigbe, Karl on 5/2/17.
//  Copyright © 2017 Karl Catigbe. All rights reserved.
//

import XCTest
@testable import MulticastDelegate

protocol FirstTestableProtocol {
    func doSomething(with string: String)
}

protocol SecondTestableProtocol {
    func doAnotherThing(with integer: Int)
}

class FirstTestableClass: FirstTestableProtocol {
    
    var testCaseString: String?
    
    func doSomething(with string: String) {
        testCaseString = string
    }
}

class SecondTestableClass: SecondTestableProtocol {
    var testCaseInt: Int?
    
    func doAnotherThing(with integer: Int) {
        testCaseInt = integer
    }
}

class CombinedTestableClass: FirstTestableProtocol, SecondTestableProtocol {
    var testCaseString: String?
    var testCaseInt: Int?

    func doSomething(with string: String) {
        testCaseString = string
    }
    
    func doAnotherThing(with integer: Int) {
        testCaseInt = integer
    }
}


class MulticastDelegateTests: XCTestCase {
    
    var firstMCDelegate: MulticastDelegate<FirstTestableProtocol>?
    
    var secondMCDelegate: MulticastDelegate<SecondTestableProtocol>?
    
    override func setUp() {
        super.setUp()
        
        firstMCDelegate = MulticastDelegate<FirstTestableProtocol>()
        secondMCDelegate = MulticastDelegate<SecondTestableProtocol>()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testMethodAddingSingleDelegate() {
        let instance = FirstTestableClass()
        
        firstMCDelegate!.add(instance)
        
        XCTAssertFalse(firstMCDelegate!.isEmpty, "MulticastDelegate should NOT be empty!")
        
        XCTAssertTrue(firstMCDelegate!.allDelegates.count == 1, "MulticastDelegate Count should be 1!")
        
        XCTAssertTrue(firstMCDelegate!.contains(instance), "MulticastDelegate should contain the instance!")
    }
    
    func testOperatorAddingSingleDelegate() {
        let instance = FirstTestableClass()
        
        firstMCDelegate! += instance
        
        XCTAssertFalse(firstMCDelegate!.isEmpty, "MulticastDelegate should NOT be empty!")
        
        XCTAssertTrue(firstMCDelegate!.allDelegates.count == 1, "MulticastDelegate Count should be 1!")
        
        XCTAssertTrue(firstMCDelegate!.contains(instance), "MulticastDelegate should contain the instance!")
    }
    
    func testMethodRemoveSingleDelegate() {
        let instance = FirstTestableClass()
        let anotherInstance = FirstTestableClass()
        
        firstMCDelegate! += instance
        firstMCDelegate! += anotherInstance
        
        firstMCDelegate!.remove(instance)
        
        XCTAssertFalse(firstMCDelegate!.contains(instance), "MulticastDelegate still contains the object")
        XCTAssertFalse(firstMCDelegate!.isEmpty, "MulticastDelegate should not be empty")
        

    }
    
    func testOperatorRemoveSingleDelegate() {
        let instance = FirstTestableClass()
        let anotherInstance = FirstTestableClass()
        
        firstMCDelegate! += instance
        firstMCDelegate! += anotherInstance
        
        firstMCDelegate! -= (instance)
        
        XCTAssertFalse(firstMCDelegate!.contains(instance), "MulticastDelegate still contains the object")
        XCTAssertFalse(firstMCDelegate!.isEmpty, "MulticastDelegate should not be empty")
        
        
    }
    
    
    func testRemoveAllDelegates() {
        let instance = FirstTestableClass()
        let anotherInstance = FirstTestableClass()
        
        firstMCDelegate! += instance
        firstMCDelegate! += anotherInstance
        
        firstMCDelegate!.removeAll()
        
        XCTAssertFalse(firstMCDelegate!.contains(instance), "MulticastDelegate still contains the object")
        XCTAssertFalse(firstMCDelegate!.contains(anotherInstance), "MulticastDelegate still contains the object")
        XCTAssertTrue(firstMCDelegate!.isEmpty, "MulticastDelegate should be empty")
    }
    
    
    func testMethodSingleInvocation() {
        let instance = FirstTestableClass()
        
        let ex = expectation(description: "testCase should be \"this\"")
        firstMCDelegate! += instance
        
        firstMCDelegate!.invoke {
            $0.doSomething(with: "this")
            XCTAssertEqual(instance.testCaseString!, "this")
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testOperatorSingleInvocation() {
        let instance = FirstTestableClass()
        
        firstMCDelegate! += instance
        
        firstMCDelegate! ~> {
            $0.doSomething(with: "that")
        }
        
        XCTAssertEqual(instance.testCaseString!, "that")
    }
    
    func testMultipleInvocation() {
        let instance = FirstTestableClass()
        let anotherInstance = CombinedTestableClass()
        
        firstMCDelegate! += instance
        firstMCDelegate! += anotherInstance
        
        firstMCDelegate!.invoke {
            $0.doSomething(with: "this")
        }
        
        XCTAssertEqual(instance.testCaseString!, "this")
        XCTAssertEqual(anotherInstance.testCaseString!, "this")
        
    }
    
    func testMultipleCombinedInvocation() {
        let instance = CombinedTestableClass()
        
        firstMCDelegate! += instance
        secondMCDelegate! += instance
        
        firstMCDelegate!.invoke {
            $0.doSomething(with: "this")
        }
        
        secondMCDelegate!.invoke {
            $0.doAnotherThing(with: 15)
        }
        XCTAssertEqual(instance.testCaseString!, "this")
        XCTAssertEqual(instance.testCaseInt, 15)

    }
}
