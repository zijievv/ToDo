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
    var important: Bool
    var completed: Bool
}

#if DEBUG
let testTasksData: [Task] = [
    Task(title: "Learn SwiftUI", important: true, completed: false),
    Task(title: "Learn Combine", important: true, completed: false),
    Task(title: "Watch WWDC", important: false, completed: true),
    Task(title: "Use Firebase", important: false, completed: false),
    Task(title: "Implement the Reminder list UI", important: true, completed: true),
]
#endif
