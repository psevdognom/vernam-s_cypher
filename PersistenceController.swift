//
//  PersistenceController.swift
//  Vernam's_cypher
//
//  Core Data stack for SwiftUI
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Vernam_s_cypher")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // Log the error for debugging purposes
                print("Core Data failed to load: \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                // Log the error for debugging purposes
                print("Core Data save error: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
