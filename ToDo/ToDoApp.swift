//
//  ToDoApp.swift
//  ToDo
//
//  Created by zijie vv on 11/10/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                TaskListView()
                    .environment(\.managedObjectContext,
                                 persistenceController.container.viewContext)
            }
        }
    }
}
