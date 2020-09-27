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
import Resolver
import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var taskRepository: TaskRepository = Resolver.resolve()
    @Published var taskCellViewModels: [TaskCellViewModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        taskRepository.$tasks.map { tasks in
            tasks.map { task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
    }

    func addTask(_ task: Task) {
        taskCellViewModels.append(TaskCellViewModel(task: task))
    }

    func removeTask(atOffsets indexSet: IndexSet) {
        taskCellViewModels.remove(atOffsets: indexSet)
    }
}

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var task: Task
    @Published var completionIcon: (name: String, color: Color) = ("", .clear)
    var id: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(task: Task) {
        self.task = task

        $task.map {
            $0.completed ? ("largecircle.fill.circle", Color(UIColor.systemBlue)) :
                ("circle", Color(UIColor.systemGray))
        }
        .assign(to: \.completionIcon, on: self)
        .store(in: &cancellables)

        $task.map { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

    static func newTask() -> TaskCellViewModel {
        TaskCellViewModel(task: Task(title: "", important: false, completed: false))
    }
}
