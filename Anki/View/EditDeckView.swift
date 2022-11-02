import SwiftUI

struct EditDeckView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var editDeck: EditDeckViewModel
    
    private let onSubmit: (Deck) -> ()
    private let onDelete: (() -> ())?
    
    init(_ vm: EditDeckViewModel, onSubmit: @escaping (Deck) -> (), onDelete: (() -> ())? ) {
        self.editDeck = vm
        self.onSubmit = onSubmit
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $editDeck.name)
                    ColorPicker("Color", selection: $editDeck.color, supportsOpacity: false)
                    if editDeck.isExisting {
                        Section {
                            Button("Delete", role: .destructive) {
                                editDeck.showDeleteConfirmation()
                            }
                        }
                    }
                }
            }
            .background(Color.systemGroupedBackground)
            .navigationTitle(editDeck.isNew ? "New Deck" : "Edit Deck")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        onSubmit(editDeck.result)
                        dismiss()
                    }
                }
            }
            .confirmationDialog("Are you sure?", isPresented: $editDeck.showDeleteConfirm) {
                Button("Delete deck", role: .destructive) {
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        onDelete?()
                    }
                }
            } message: {
                Text("You cannot undo this action. Are you sure?")
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditDeckView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EditDeckViewModel()
        EditDeckView(vm) { result in
        } onDelete: {}
    }
}
