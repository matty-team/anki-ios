import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var decks = [Deck]()
    @Published var showNewCardScreen = false
    @Published var showNewDeckScreen = false
    
    private let deckStore: AnyDeckStore
    
    init(deckStore: AnyDeckStore = DeckStore.shared) {
        self.deckStore = deckStore
        decks = deckStore.fetchAllDecks()
    }
    
    var noDecks: Bool {
        return decks.isEmpty
    }
    
    func createNewCard() {
        showNewCardScreen = true
    }
    
    func createNewDeck() {
        showNewDeckScreen = true
    }
    
    func cancelNewCard() {
        showNewCardScreen = false
    }
    
    func cancelNewDeck() {
        showNewDeckScreen = false
    }
    
    func addDeck(_ deck: Deck) {
        decks.append(deck)
        deckStore.add(deck)
        showNewDeckScreen = false
    }
    
    func deleteDeck(_ deck: Deck) {
        decks.remove(deck)
    }
    
    func learn() {
        //TODO: -
    }
    
    func index(of deck: Deck) -> Int? {
        return decks.firstIndex(of: deck)
    }
}
