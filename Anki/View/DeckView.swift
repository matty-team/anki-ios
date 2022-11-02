import SwiftUI

struct DeckView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var deck: Deck
    
    @State private var showEditScreen = false
    
    private let onDelete: () -> ()
    
    init(for deck: Binding<Deck>, onDelete: @escaping () -> ()) {
        self._deck = deck
        self.onDelete = onDelete
    } 
    
    var body: some View {
        VStack {
            Header()
                .padding()
            Spacer()
            Cards()
            Spacer()
            Footer()
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                EditDeckButton()
            }
        }
        .sheet(isPresented: $showEditScreen) {
            EditDeckScreen()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func Header() -> some View {
        HStack {
            Text(deck.name)
                .font(.largeTitle)
                .foregroundColor(Color(cgColor: deck.color))
                .bold()
            Spacer()
        }
    }
    
    private func Cards() -> some View {
        Group {
            if deck.hasCards {
                EmptyView()
            } else {
                Text("No Cards")
                    .foregroundColor(.gray)
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
    
    private func EditDeckScreen() -> some View {
        let vm = EditDeckViewModel(deck)
        return EditDeckView(vm) { result in
            deck.name = result.name
            deck.color = result.color
        } onDelete: {
            dismiss()
            onDelete()
        }
    }
    
    private func EditDeckButton() -> some View {
        Button {
            showEditScreen = true
        } label: {
            Image(systemName: "square.and.pencil")
                .font(.headline)
        }
    }
    
    private func NewCardButton() -> some View {
        Button {
            //TODO: -
        } label: {
            Label("New Card", systemImage: "plus.circle.fill")
                .foregroundColor(Color(cgColor: deck.color))
        }
    }
    
    private func LearnButton() -> some View {
        Button {
            //TODO: -
        } label: {
            Text("Learn")
                .foregroundColor(Color(cgColor: deck.color))
                .bold()
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct DeckView_Previews: PreviewProvider {
    
    static var previews: some View {
        DeckViewPreview()
    }
    
    struct DeckViewPreview: View {
        @State private var deck = Deck(name: "English", color: UIColor.systemRed.cgColor)
        
        var body: some View {
            NavigationView {
                DeckView(for: $deck) { }
            }
        }
    }
}
