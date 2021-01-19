//
//  SwiftUI_MQTTTests.swift
//  SwiftUI_MQTTTests
//
//  Created by Anoop M on 2021-01-19.
//

import XCTest
@testable import SwiftUI_MQTT

class SwiftUI_MQTTTests: XCTestCase {

    var manager: MQTTManager!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = MQTTManager.shared()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manager = nil
    }

    func testExample() throws {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        manager.initializeMQTT(host: "broker.hivemq.com", identifier: "iOS-Test")
        manager.connect()
        manager.subscribe(topic: "SUI-Test")
        manager.publish(with: "Hello")
        manager.disconnect()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
