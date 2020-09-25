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

class TaskListViewModel: ObservableObject {
    @Published var taskCellViewModels: [TaskCellViewModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.taskCellViewModels = testTasksData.map {
            TaskCellViewModel(task: $0)
        }
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
    @Published var completionIconName: String = ""
    var id: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(task: Task) {
        self.task = task

        $task.map { $0.completed ? "largecircle.fill.circle" : "circle" }
            .assign(to: \.completionIconName, on: self)
            .store(in: &cancellables)

        $task.map { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

    static func newTask() -> TaskCellViewModel {
        TaskCellViewModel(task: Task(title: "", completed: false, priority: .medium))
    }
}
