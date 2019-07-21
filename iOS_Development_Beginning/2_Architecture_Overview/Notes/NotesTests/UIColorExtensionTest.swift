//
//  UIColorExtensionTest.swift
//  NotesTests
//
//  Created by Alexey Danilov on 7/7/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import XCTest
@testable import Notes

class UIColorExtensionTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testConvertionColorToDict() {
        let color = UIColor.red
        let dict = color.getRgbaDict()
        
        let redDict = ["red": 1.0,
                       "green": 0,
                       "blue": 0,
                       "alpha": 1]
        
        XCTAssertEqual(dict, redDict)
    }
    
    func testConvertionDictToColor() {
        let redDict = ["red": 1.0,
                       "green": 0,
                       "blue": 0,
                       "alpha": 1]
        
        let color = UIColor.getColor(from: redDict)
        
        XCTAssertEqual(UIColor.red, color)
    }

}
