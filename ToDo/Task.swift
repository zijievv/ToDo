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
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
    var priority: TaskPriority
}

enum TaskPriority {
    case high
    case medium
    case low
}

#if DEBUG
    let testTasksData: [Task] = [
        Task(title: "Learn SwiftUI", completed: false, priority: .high),
        Task(title: "Learn Combine", completed: false, priority: .medium),
        Task(title: "Watch WWDC", completed: true, priority: .low),
        Task(title: "Use Firebase", completed: false, priority: .medium),
        Task(title: "Implement the Reminder list UI", completed: true, priority: .high),
    ]
#endif
