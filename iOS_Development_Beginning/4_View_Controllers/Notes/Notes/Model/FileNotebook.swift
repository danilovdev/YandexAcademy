import Foundation

enum FileNotebookError: Error, Equatable {
    
    case noteAlreadyExistsError
    
    case noteDoesNotExist
    
    case notesCannotBeLoaded
    
    case notesCannotBeSaved
}

extension FileNotebookError {
    
    var message: String {
        switch self {
        case .noteAlreadyExistsError:
            return "Note with such ID already exists."
        case .noteDoesNotExist:
            return "Note with such ID does not exist."
        case .notesCannotBeLoaded:
            return "Notes cannot be loaded from disk"
        case .notesCannotBeSaved:
            return "Notes cannot be saved from disk"
        }
    }
}

class FileNotebook {
    
    private (set) var notes: [Note] = []
    
    public func add(_ note: Note) throws {
        let index = notes.firstIndex(where: { $0.uid == note.uid })
        guard index == nil else {
            throw FileNotebookError.noteAlreadyExistsError
        }
        notes.append(note)
    }
    
    public func update(note: Note) throws {
        guard let index = notes.firstIndex(where: { $0.uid == note.uid }) else {
            throw FileNotebookError.noteDoesNotExist
        }
        notes[index] = note
    }
    
    public func remove(with uid: String) throws {
        let index = notes.firstIndex(where: { $0.uid == uid })
        guard index != nil else {
            throw FileNotebookError.noteDoesNotExist
        }
        notes.remove(at: index!)
    }
    
    public func saveToFile() throws {
        let fileManager = FileManager.default
        guard let path = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let dirUrl = path.appendingPathComponent("FileNotebook")
        var isDir : ObjCBool = false
        var needToCreate = false
        if fileManager.fileExists(atPath: dirUrl.path, isDirectory: &isDir) {
            if isDir.boolValue {
                // file exists and is a directory
            } else {
                // file exists and is not a directory
                needToCreate = true
            }
        } else {
            // file does not exist
            needToCreate = true
        }
        
        if needToCreate {
            do {
                try FileManager.default.createDirectory(at: dirUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
                return
            }
        }
        
        let fileUrl = dirUrl.appendingPathComponent("FileNotebook.json")
        
        do {
            let notesJson = notes.map { note in (note.uid, note.json) }
            let data = try JSONSerialization.data(withJSONObject: notesJson, options: [])
            FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: [:])
        } catch {
            throw FileNotebookError.notesCannotBeSaved
        }
    }
    
    public func loadFromFile() throws {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let dirUrl = path.appendingPathComponent("FileNotebook", isDirectory: true)
        let fileUrl = dirUrl.appendingPathComponent("FileNotebook.json")
        do {
            
            if let data = FileManager.default.contents(atPath: fileUrl.path) {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]] {
                    for (_, value) in json {
                        if let note = Note.parse(json: value) {
                            try? add(note)
                        }
                    }
                }
            }
        } catch {
            throw FileNotebookError.notesCannotBeLoaded
        }
    }
}
