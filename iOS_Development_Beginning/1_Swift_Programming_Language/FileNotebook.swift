class FileNotebook {
    
    private (set) var notes: [String: Note] = [:]
    
    public func add(_ note: Note) {
        if notes[note.uid] == nil {
            notes[note.uid] = note
        } else {
            print("Note with such ID already exists.")
        }
    }
    
    public func remove(with uid: String) {
        if notes[uid] != nil {
            notes[uid] == nil
        } else {
            print("Note with such ID does not exist.")
        }
    }
    
    public func saveToFile() {
        let fileManager = FileManager.default
        guard let path = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let dirUrl = path.appendingPathComponent("FileNotebook")
        var isDir : ObjCBool = false
        var needToCreate = false
        if fileManager.fileExists(atPath: dirUrl.path, isDirectory: &isDir) {
            if isDir.boolValue {
                // file exists and is a directory
                print("file exists and is a directory")
            } else {
                // file exists and is not a directory
                print("file exists and is not a directory")
                needToCreate = true
            }
        } else {
            // file does not exist
            print("file does not exist")
            needToCreate = true
        }
        
        if needToCreate {
            do {
                try FileManager.default.createDirectory(at: dirUrl, withIntermediateDirectories: true, attributes: nil)
                print("dir created")
            } catch {
                print(error)
                return
            }
        }
        
        let fileUrl = dirUrl.appendingPathComponent("FileNotebook.json")
        
        do {
            let notesJson = Dictionary(uniqueKeysWithValues: notes.map { key, value in (key, value.json) })
            let data = try JSONSerialization.data(withJSONObject: notesJson, options: [])
            FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: [:])
        } catch {
            print("error")
            return
        }
    }
    
    public func loadFromFile() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let dirUrl = path.appendingPathComponent("FileNotebook", isDirectory: true)
        let fileUrl = dirUrl.appendingPathComponent("FileNotebook.json")
        do {
            
            if let data = FileManager.default.contents(atPath: fileUrl.path) {
                print("here")
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]] {
                    for (_, value) in json {
                        if let note = Note.parse(json: value) {
                            add(note)
                        }
                    }
                }
            }
        } catch {
            print(error)
            return
        }
    }
}
