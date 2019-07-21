//
//  NotesTests.swift
//  NotesTests
//
//  Created by Alexey Danilov on 7/6/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import XCTest
@testable import Notes

class NotesTests: XCTestCase {
    
    func test_usual_notes_do_not_parsed_to_json() {
        let note = Note(title: "Usual Note Title",
                        content: "Usual Note Content",
                        importance: .usual)
        let json = note.json
        let parsedImportance = json["importance"] as? String
        XCTAssertEqual(parsedImportance, nil)
    }
    
    func test_not_usual_notes_do_parsed_to_json() {
        let note = Note(title: "Critical Note Title",
                        content: "Critical Note Content",
                        importance: .critical)
        let json = note.json
        if let parsedImportance = json["importance"] as? String {
            XCTAssertEqual(Note.Importance(rawValue: parsedImportance), Note.Importance.critical)
        }
    }
    
    func test_white_color_do_not_parsed_to_json() {
        let note = Note(title: "Usual Note Title",
                        content: "Usual Note Content",
                        color: .white,
                        importance: .usual)
        let json = note.json
        let parsedColor = json["color"] as? [String: Double]
        XCTAssertEqual(parsedColor, nil)
    }
    
    func test_not_white_color_do_parsed_to_json() {
        let note = Note(title: "Usual Note Title",
                        content: "Usual Note Content",
                        color: .red,
                        importance: .critical)
        let json = note.json
        if let parsedColor = json["color"] as? [String: Double] {
            let color = UIColor.getColor(from: parsedColor)
            XCTAssertEqual(color, UIColor.red)
        }
    }
    
    func test_json_convertion_and_parsing() {
        let note = Note(title: "Usual Note Title",
                        content: "Usual Note Content",
                        color: .red,
                        importance: .critical,
                        selfDestructionDate: Date(timeIntervalSince1970: 123456))
        let json = note.json
        if let parsedNote = Note.parse(json: json) {
            XCTAssertEqual(note, parsedNote)
        }
    }

}
