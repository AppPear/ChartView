//
//  CGPointExtensionTests.swift
//  SwiftUIChartsTests
//
//  Created by Adrian Bolinger on 5/24/20.
//

@testable import SwiftUICharts
import XCTest

class CGPointExtensionTests: XCTestCase {
    static let twentyElementArray: [Double] = Array(repeating: Double.random(in: 1...100), count: 20)
    
    func testGetStepWithOneElementArray() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let oneElementArray: [Double] = [0.0]
        
        XCTAssertEqual(CGPoint.getStep(frame: frame, data: oneElementArray), .zero)
    }
    
    func testGetStepWithMultiElementArrayWithNegativeValues() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let multiElementArray: [Double] = [-5.0, 0.0, 5.0]
        XCTAssertEqual(CGPoint.getStep(frame: frame, data: multiElementArray), CGPoint(x: 150.0, y: 27.0))
    }
    
    func testGetStepWithMultiElementArrayWithPositiveValues() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let multiElementArray: [Double] = [5.0, 10.0, 15.0]
        XCTAssertEqual(CGPoint.getStep(frame: frame, data: multiElementArray), CGPoint(x: 150.0, y: 13.5))
    }
}
