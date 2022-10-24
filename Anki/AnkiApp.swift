//
//  AnkiApp.swift
//  Anki
//
//  Created by Vlad on 24.10.2022.
//

import SwiftUI

@main
struct AnkiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
