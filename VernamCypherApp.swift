//
//  VernamCypherApp.swift
//  Vernam's_cypher
//
//  Updated to SwiftUI
//

import SwiftUI

@main
struct VernamCypherApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
