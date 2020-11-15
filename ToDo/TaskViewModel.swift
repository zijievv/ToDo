//
//  TaskViewModel.swift
//  ToDo
//
//  Created by zijie vv on 12/11/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import CoreData
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var id: UUID
    @Published var title: String
    @Published var isCompleted: Bool
    @Published var isImportant: Bool
    @Published var createdDate: Date
    @Published var scheduledDate: Date?

    init() {
        self.id = UUID()
        self.title = ""
        self.isCompleted = false
        self.isImportant = false
        self.createdDate = Date()
        self.scheduledDate = nil
    }

    init(task: Task) {
        self.id = task.id!
        self.title = task.title!
        self.isCompleted = task.isCompleted
        self.isImportant = task.isImportant
        self.createdDate = task.createdDate!
        self.scheduledDate = task.scheduledDate
    }

    func assign(to item: Task) {
        item.id = id
        item.title = title
        item.isCompleted = isCompleted
        item.isImportant = isImportant
        item.createdDate = createdDate
        item.scheduledDate = scheduledDate
    }

    func get(task: Task) {
        self.id = task.id!
        self.title = task.title!
        self.isCompleted = task.isCompleted
        self.isImportant = task.isImportant
        self.createdDate = task.createdDate!
        self.scheduledDate = task.scheduledDate
    }
}

extension TaskViewModel: Identifiable {}
