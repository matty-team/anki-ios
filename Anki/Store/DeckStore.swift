import SwiftUI

protocol AnyDeckStore {
    func add(_ deck: Deck)
    func delete(_ deck: Deck)
    func update(_ deck: Deck)
    func fetchAllDecks() -> [Deck]
}

class DeckStore: AnyDeckStore {
    
    static let shared = StubDeckStore()
    
    private init() { }
    
    func add(_ deck: Deck) {
        fatalError("Not implemented")
    }
    
    func delete(_ deck: Deck) {
        fatalError("Not implemented")
    }
    
    func update(_ deck: Deck) {
        fatalError("Not implemented")
    }
    
    func fetchAllDecks() -> [Deck] {
        fatalError("Not implemented")
    }
}

class StubDeckStore: AnyDeckStore {
    
    private var decks = [
        Deck(name: "English", color: UIColor.systemBlue.cgColor),
        Deck(name: "Swift", color: UIColor.systemRed.cgColor),
        Deck(name: "iOS", color: UIColor.systemGreen.cgColor)
    ]
    
    init(isEmpty: Bool = false) {
        if isEmpty {
            decks = []
        }
    }
    
    func add(_ deck: Deck) {
        decks.append(deck)
    }
    
    func delete(_ deck: Deck) {
        decks.remove(deck)
    }
    
    func update(_ deck: Deck) {
        decks.update(deck)
    }
    
    func fetchAllDecks() -> [Deck] {
        return decks
    }
}

extension Array where Element: Identifiable {
    
    mutating func remove(_ element: Element) {
        self = filter { $0.id != element.id }
    }
    
    mutating func update(_ element: Element) {
        self = map { $0.id == element.id ? element : $0 }
    }
    
    func firstIndex(of element: Element) -> Int? {
        return firstIndex { $0.id == element.id }
    }
}
