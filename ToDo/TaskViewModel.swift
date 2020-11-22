//
//  TaskVM.swift
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
    @Published var id = UUID()
    @Published var title: String = ""
    @Published var isCompleted = false
    @Published var isImportant = false
    @Published var createdDate = Date()

    @Published var scheduledDate: Date? = nil
    @Published var isScheduled = false

    @Published var updatedTask: Task!

    func writeData(to context: NSManagedObjectContext) {
        // Update Task
        if updatedTask != nil {
            updatedTask.id = id
            updatedTask.title = title
            updatedTask.isCompleted = isCompleted
            updatedTask.isImportant = isImportant
            updatedTask.createdDate = createdDate
            updatedTask.scheduledDate = scheduledDate

            try! context.save()
            return
        }

        // Add New Task
        let newTask = Task(context: context)
        newTask.id = id
        newTask.title = title
        newTask.isCompleted = isCompleted
        newTask.isImportant = isImportant
        newTask.createdDate = Date()
        newTask.scheduledDate = scheduledDate

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func edit(task: Task) {
        updatedTask = task

        id = task.id!
        title = task.title!
        isCompleted = task.isCompleted
        isImportant = task.isImportant
        createdDate = task.createdDate!
        scheduledDate = task.scheduledDate
    }

    func resetAllAttributes() {
        updatedTask = nil
        id = UUID()
        title = ""
        isCompleted = false
        isImportant = false
        createdDate = Date()
        scheduledDate = nil
        isScheduled = false
    }
}
