//
//  ColorExtensionTests.swift
//  SwiftUIChartsTests
//
//  Created by Adrian Bolinger on 5/24/20.
//

@testable import SwiftUICharts
import SwiftUI
import XCTest

class ColorExtensionTests: XCTestCase {
    func testTwentyFourBitRGBColors() {
        let actualWhite = Color(hexString: "FFFFFF")
        let expectedWhite = Color(red: 1, green: 1, blue: 1)
        XCTAssertEqual(actualWhite, expectedWhite)
        
        let actualBlack = Color(hexString: "000000")
        let expectedBlack = Color(red: 0, green: 0, blue: 0)
        XCTAssertEqual(actualBlack, expectedBlack)
        
        let actualRed = Color(hexString: "FF0000")
        let expectedRed = Color(red: 255/255, green: 0, blue: 0)
        XCTAssertEqual(actualRed, expectedRed)
        
        let actualGreen = Color(hexString: "00FF00")
        let expectedGreen = Color(red: 0, green: 1, blue: 0)
        XCTAssertEqual(actualGreen, expectedGreen)
        
        let actualBlue = Color(hexString: "0000FF")
        let expectedBlue = Color(red: 0, green: 0, blue: 1)
        XCTAssertEqual(actualBlue, expectedBlue)
    }
    
    func testTwelveBitRGBColors() {
        let actualWhite = Color(hexString: "FFF")
        let expectedWhite = Color(red: 1, green: 1, blue: 1)
        XCTAssertEqual(actualWhite, expectedWhite)
        
        let actualBlack = Color(hexString: "000")
        let expectedBlack = Color(red: 0, green: 0, blue: 0)
        XCTAssertEqual(actualBlack, expectedBlack)
        
        let actualRed = Color(hexString: "F00")
        let expectedRed = Color(red: 255/255, green: 0, blue: 0)
        XCTAssertEqual(actualRed, expectedRed)
        
        let actualGreen = Color(hexString: "0F0")
        let expectedGreen = Color(red: 0, green: 1, blue: 0)
        XCTAssertEqual(actualGreen, expectedGreen)
        
        let actualBlue = Color(hexString: "00F")
        let expectedBlue = Color(red: 0, green: 0, blue: 1)
        XCTAssertEqual(actualBlue, expectedBlue)
    }
}
