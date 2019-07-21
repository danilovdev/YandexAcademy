//
//  NotesListController.swift
//  Notes
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class NotesListController: UITableViewController {
    
    private let reuseIdentifier = "NotesListCell"
    
    private var selectedNote: Note?

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.register(UINib(nibName: "NotesListCell", bundle: nil),
                           forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileNoteBook.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath) as! NotesListCell
        
        let note = fileNoteBook.notes[indexPath.row]
        cell.colorView.backgroundColor = note.color
        cell.noteTitleLabel.text = note.title
        cell.noteDesctiptionLabel.text = note.content
        
        return cell
    }
    
    
    
    @IBAction func addNoteButtonTapped(_ sender: Any) {
        selectedNote = Note(title: "",
                            content: "",
                            importance: .usual)
        try? fileNoteBook.add(selectedNote!)
        performSegue(withIdentifier: "ShowNoteDetails",
                     sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "ShowNoteDetails" {
            if let destination = segue.destination as? NoteDetailsController {
                destination.currentNote = selectedNote
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = fileNoteBook.notes[indexPath.row]
        performSegue(withIdentifier: "ShowNoteDetails", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = fileNoteBook.notes[indexPath.row]
            try? fileNoteBook.remove(with: note.uid)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
}
