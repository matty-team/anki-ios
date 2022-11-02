import SwiftUI

struct Deck: Identifiable {
    let id = UUID()
    var name: String
    var color: CGColor
    var cards = [Card]()
}

extension Deck {
    
    var hasCards: Bool {
        return !cards.isEmpty
    }
}
