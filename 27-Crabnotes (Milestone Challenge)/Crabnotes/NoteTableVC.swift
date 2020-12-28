import UIKit

class NoteTableVC: UITableViewController {
    
    var crabnotes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let persistenceManager = PersistenceManager.shared
        crabnotes = persistenceManager.loadNotes()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crabnotes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crabnote", for: indexPath)
        cell.textLabel?.text = crabnotes[indexPath.row].text
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd.MM.yy, HH:mm"
        let stringDate = dateFormat.string(from: crabnotes[indexPath.row].changed)
        
        cell.detailTextLabel?.text = crabnotes[indexPath.row].title + " created at " + stringDate
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(identifier: "Detail") as? NoteDetailVC {
            detailVC.note = crabnotes[indexPath.row]
            detailVC.noteIndex = indexPath.row
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            crabnotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = crabnotes[sourceIndexPath.row]
        crabnotes.remove(at: sourceIndexPath.row)
        crabnotes.insert(movedItem, at: destinationIndexPath.row)
    }
    
    
    @objc func addItem() {
        let newNote = Note(title: "Crabnote", text: "Type your note here...", changed: Date(timeIntervalSinceNow: 0))
        crabnotes.append(newNote)
        if let detailVC = storyboard?.instantiateViewController(identifier: "Detail") as? NoteDetailVC {
            detailVC.note = newNote
            detailVC.delegate = self
            detailVC.noteIndex = crabnotes.count - 1
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        PersistenceManager.shared.saveNotes(notes: crabnotes)
        tableView.reloadData()
    }
    
    
    func updateChangedNote(note: Note, noteIndex: Int) {
        crabnotes.remove(at: noteIndex)
        crabnotes.insert(note, at: noteIndex)
        PersistenceManager.shared.saveNotes(notes: crabnotes)
        tableView.reloadData()
    }
}
