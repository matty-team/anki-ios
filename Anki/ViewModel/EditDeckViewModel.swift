import SwiftUI

class EditDeckViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var color = UIColor.systemOrange.cgColor
    
    @Published var showDeleteConfirm = false
    
    private let deck: Deck?
    
    var isNew: Bool {
        return deck == nil
    }
    
    var isExisting: Bool {
        return !isNew
    }
    
    var result: Deck {
        return Deck(name: name, color: color)
    }
    
    init(_ deck: Deck? = nil) {
        if let deck = deck {
            self.deck = deck
            self.name = deck.name
            self.color = deck.color
        } else {
            self.deck = nil
        }
    }
    
    func showDeleteConfirmation() {
        showDeleteConfirm = true
    }
}
