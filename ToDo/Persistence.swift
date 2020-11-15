//
//  Persistence.swift
//  ToDo
//
//  Created by zijie vv on 11/10/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "ToDo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

#if DEBUG
extension PersistenceController {
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let titles: [String] = [
            "0 Learn SwiftUI", "1 Learn Combine", "2 Watch WWDC",
            "3 Implement the UI", "4 Drink a cup of coffee",
        ]

        for title in titles {
            let newItem = Task(context: viewContext)
            let selectDate = Bool.random()
            newItem.id = UUID()
            newItem.createdDate = Date()
            newItem.isCompleted = Bool.random()
            newItem.isImportant = Bool.random()
            newItem.scheduledDate = selectDate ? Date() : nil
            newItem.title = title
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
#endif
