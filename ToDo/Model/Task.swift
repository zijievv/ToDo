//
//  Task.swift
//  ToDo
//
//  Created by zijie vv on 25/09/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//
import Foundation

struct Task: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isImportant: Bool
    var isCompleted: Bool
}

#if DEBUG
let testTasksData: [Task] = [
    Task(title: "Learn SwiftUI", isImportant: true, isCompleted: false),
    Task(title: "Learn Combine", isImportant: true, isCompleted: false),
    Task(title: "Watch WWDC", isImportant: false, isCompleted: true),
    Task(title: "Use Firebase", isImportant: false, isCompleted: false),
    Task(title: "Implement the Reminder list UI", isImportant: true, isCompleted: true),
]
#endif
