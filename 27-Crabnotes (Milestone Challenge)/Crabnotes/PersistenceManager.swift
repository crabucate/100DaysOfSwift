import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    
    private init() { }
    
    func saveNotes(notes: [Note]) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(notes)
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "notes")
        } catch {
            fatalError()
        }
        
    }
    
    func loadNotes() -> [Note] {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "notes") as? Data {
            let decoder = PropertyListDecoder()
            do {
                let notes = try decoder.decode([Note].self, from: data)
                return notes
            } catch {
                fatalError()
            }
        } else {
            return [Note]()
        }
    }
}
