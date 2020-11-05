//
//  TaskListViewModel.swift
//  ToDo
//
//  Created by zijie vv on 25/09/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import Combine
import Foundation
import SwiftUI

protocol TaskListViewModelProtocol {
    var tasks: [Task] { get }
    var showCompleted: Bool { get set }
    func fetchTasks()
    func toggleCompleteStatus(of task: Task)
}

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var showCompleted = false

    var taskManager: TasksManagerProtocol

    init(taskManager: TasksManagerProtocol = TasksManager.shared) {
        self.taskManager = taskManager
        fetchTasks()
    }
}

extension TaskListViewModel: TaskListViewModelProtocol {
    func fetchTasks() {
        tasks = taskManager.fetchTaskList(includingCompleted: showCompleted)
    }

    func toggleCompleteStatus(of task: Task) {
        taskManager.toggleCompleteStatus(of: task)
        fetchTasks()
    }
}
