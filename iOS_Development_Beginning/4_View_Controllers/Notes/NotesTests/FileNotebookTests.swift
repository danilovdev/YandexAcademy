//
//  FileNotebookTests.swift
//  NotesTests
//
//  Created by Alexey Danilov on 7/7/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import XCTest
@testable import Notes

class FileNotebookTests: XCTestCase {

    func testAddingError() {
        let fileNotebook = FileNotebook()
        let note = Note(title: "Some Note Title", content: "Some Note Content", importance: .critical)
        try? fileNotebook.add(note)
        assert(try fileNotebook.add(note), throws: FileNotebookError.noteAlreadyExistsError)
    }
    
    func testDeletingError() {
        let fileNotebook = FileNotebook()
        assert(try fileNotebook.remove(with: "NO_ID"), throws: FileNotebookError.noteDoesNotExist)
    }
    
    func testSavingAndLoading() {
        var fileNotebook: FileNotebook? = FileNotebook()
        let note = Note(title: "Note Number 1 Title",
                        content: "Note Number 1 Content",
                        importance: .critical)
        try? fileNotebook?.add(note)
        try? fileNotebook?.saveToFile()
        fileNotebook = nil
        
        try? fileNotebook?.loadFromFile()
        if let loadedNote = fileNotebook?.notes.first?.value {
            XCTAssertEqual(note, loadedNote)
        }
    }

}
