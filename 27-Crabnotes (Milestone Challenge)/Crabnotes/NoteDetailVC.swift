import UIKit

class NoteDetailVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteView: UITextView!
    
    var note: Note?
    var noteIndex: Int?
    weak var delegate: NoteTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
        noteView.delegate = self
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
            if var note = note {
                note.text = noteView.text
                print(note.text)
                delegate.updateChangedNote(note: note, noteIndex: noteIndex!)
        }
    }
    
    
    func populateView() {
        titleLabel.text = note?.title
        noteView.text = note?.text
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = String()
    }
    

}
