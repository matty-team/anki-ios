import SwiftUI

struct MainView: View {
    
    @StateObject var mvm: MainViewModel
    
    init(vm: MainViewModel = MainViewModel()) {
        self._mvm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Header()
                    .padding([.top, .leading, .trailing])
                Decks()
                Footer()
                    .padding()
            }
            .background(Color.systemGroupedBackground)
            .navigationTitle("My Decks")
            .navigationBarHidden(true)
            .sheet(isPresented: $mvm.showNewCardScreen) {
                EmptyView()
            }
            .sheet(isPresented: $mvm.showNewDeckScreen) {
                NewDeckScreen()
            }
        }
        .environmentObject(mvm)
    }
    
    private func Header() -> some View {
        HStack {
            Text("My Decks")
                .bold()
            Spacer()
            Button("+") {
                mvm.createNewDeck()
            }
        }
        .font(.title)
    }
    
    private func Decks() -> some View {
        Group {
            if mvm.noDecks {
                Spacer()
                Text("No Decks")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List(mvm.decks) { deck in
                    DeckRow(for: deck)
                }
                Spacer()
            }
        }
    }
    
    private func DeckRow(for deck: Deck) -> some View {
        NavigationLink {
            if let index = mvm.index(of: deck) {
                DeckView(for: $mvm.decks[index]) {
                    mvm.deleteDeck(deck)
                }
            }
        } label: {
            HStack {
                ColorCircle(deck.color, size: 10)
                Text(deck.name)
            }
        }
    }
    
    private func Footer() -> some View {
        HStack {
            NewCardButton()
            Spacer()
            LearnButton()
        }
    }
    
    private func NewCardButton() -> some View {
        Button {
            mvm.createNewCard()
        } label: {
            Label("New Card", systemImage: "plus.circle.fill")
        }
    }
    
    private func LearnButton() -> some View {
        Button {
            mvm.learn()
        } label: {
            Text("Learn")
                .bold()
        }
    }
    
    private func NewDeckScreen() -> some View {
        let vm = EditDeckViewModel()
        return EditDeckView(vm) { result in
            mvm.addDeck(result)
        } onDelete: {
            
        }
    }
}

struct ColorCircle: View {
    
    let color: CGColor
    let size: CGFloat
    
    init(_ color: CGColor, size: CGFloat) {
        self.color = color
        self.size = size
    }
    
    var body: some View {
        Circle()
            .fill(Color(cgColor: color))
            .frame(width: size, height: size)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let deckStore = StubDeckStore()
        let emptyDeckStore = StubDeckStore(isEmpty: true)
        let vm = MainViewModel(deckStore: deckStore)
        let emptyVm = MainViewModel(deckStore: emptyDeckStore)
        
        MainView(vm: vm)
        MainView(vm: emptyVm)
            .previewDisplayName("Empty Main View")
    }
}

extension Color {
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
}
