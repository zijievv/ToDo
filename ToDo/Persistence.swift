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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible,
                 * due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

//#if DEBUG
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
            newItem.id = UUID()
            newItem.createdDate = Date()
            newItem.isCompleted = Bool.random()
            newItem.isImportant = Bool.random()
            newItem.isScheduledDate = Bool.random()
            newItem.isScheduledTime = newItem.isScheduledDate ? Bool.random() : false
            newItem.scheduledDate = newItem.isScheduledDate ? Date() : nil
            newItem.title = title
        }

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application,
            // although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}

//#endif
