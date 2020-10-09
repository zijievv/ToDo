//
//  TasksManager.swift
//  ToDo
//
//  Created by zijie vv on 25/09/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import Foundation

protocol TasksManagerProtocol {
    func fetchTaskList(includingCompleted: Bool) -> [Task]
    func addTask(withTitle title: String)
    func toggleCompleteStatus(of task: Task)
}

extension TasksManagerProtocol {
    func fetchTaskList(includingCompleted: Bool = false) -> [Task] {
        fetchTaskList(includingCompleted: includingCompleted)
    }
}

class TasksManager {
    static let shared: TasksManagerProtocol = TasksManager()

    private var tasks = [Task]()

    private init() {}
}

extension TasksManager: TasksManagerProtocol {
    func fetchTaskList(includingCompleted: Bool = false) -> [Task] {
        includingCompleted ? tasks : tasks.filter { !$0.isCompleted }
    }

    func addTask(withTitle title: String) {
        let task = Task(title: title, isImportant: false, isCompleted: false)
        tasks.insert(task, at: 0)
    }

    func toggleCompleteStatus(of task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

}

#if DEBUG
class TestTasksManager {
    private var todos = [Task]()

    init() {
        todos = testTasksData
    }

}

extension TestTasksManager: TasksManagerProtocol {
    func toggleCompleteStatus(of task: Task) {
        if let index = todos.firstIndex(where: { $0.id == task.id }) {
            todos[index].isCompleted.toggle()
        }
    }

    func fetchTaskList(includingCompleted: Bool = false) -> [Task] {
        includingCompleted ? todos : todos.filter { !$0.isCompleted }
    }

    func addTask(withTitle title: String) {
        let task = Task(title: title, isImportant: false, isCompleted: false)
        todos.insert(task, at: 0)
    }
}
#endif
