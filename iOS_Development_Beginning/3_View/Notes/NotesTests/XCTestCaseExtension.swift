//
//  XCTestCaseExtension.swift
//  NotesTests
//
//  Created by Alexey Danilov on 7/7/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import Foundation

extension XCTestCase {
    
    func assert<T, E: Error & Equatable>(
        _ expression: @autoclosure () throws -> T,
        throws error: E,
        in file: StaticString = #file,
        line: UInt = #line
        ) {
        var thrownError: Error?
        
        XCTAssertThrowsError(try expression(),
                             file: file, line: line) {
                                thrownError = $0
        }
        
        XCTAssertTrue(
            thrownError is E,
            "Unexpected error type: \(type(of: thrownError))",
            file: file, line: line
        )
        
        XCTAssertEqual(
            thrownError as? E, error,
            file: file, line: line
        )
    }
}
