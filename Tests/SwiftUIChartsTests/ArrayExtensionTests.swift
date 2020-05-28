//
//  File.swift
//  
//
//  Created by Nicolas Savoini on 2020-05-25.
//

@testable import SwiftUICharts
import XCTest

class ArrayExtensionTests: XCTestCase {

    func testArrayRotatingIndexEmpty() {
        let colors = [ColorGradient]()
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.orangeBright)
    }
    
    func testArrayRotatingIndexOneValue() {
        let colors = [ColorGradient.greenRed]
        
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 1), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 2), ColorGradient.greenRed)
    }
    
    func testArrayRotatingIndexLessValues() {
        let colors = [ColorGradient.greenRed, ColorGradient.whiteBlack]
        
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 1), ColorGradient.whiteBlack)
        XCTAssertEqual(colors.rotate(for: 2), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 3), ColorGradient.whiteBlack)
        XCTAssertEqual(colors.rotate(for: 4), ColorGradient.greenRed)
    }
    
    func testArrayRotatingIndexMoreValues() {
        let colors = [ColorGradient.greenRed, ColorGradient.whiteBlack, ColorGradient.orangeBright]
        
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 1), ColorGradient.whiteBlack)

    }
  
}
