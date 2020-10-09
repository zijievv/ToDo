//
//  NewTaskViewModel.swift
//  ToDo
//
//  Created by zijie vv on 09/10/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import Foundation
import Combine

protocol NewTaskViewModelProtocol {
    func addNewTask(title: String)
}

final class NewTaskViewModel: ObservableObject {
    var taskManager: TasksManagerProtocol

    init(taskManager: TasksManagerProtocol = TasksManager.shared) {
        self.taskManager = taskManager
    }
}

extension NewTaskViewModel: NewTaskViewModelProtocol {
    func addNewTask(title: String) {
        taskManager.addTask(withTitle: title)
    }
}
