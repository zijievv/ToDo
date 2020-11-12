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

    @Published var isScheduledDate: Bool {
        didSet {
            if !isScheduledDate {
                isScheduledTime = false
            }
        }
    }

    @Published var isScheduledTime: Bool {
        didSet {
            if isScheduledTime {
                isScheduledDate = true
            }
        }
    }

    @Published var scheduledDate: Date

    init() {
        self.id = UUID()
        self.title = ""
        self.isCompleted = false
        self.isImportant = false
        self.isScheduledDate = false
        self.isScheduledTime = false
        self.createdDate = Date()
        self.scheduledDate = Date()
    }

    func assign(to item: Task) {
        item.id = id
        item.title = title
        item.isCompleted = isCompleted
        item.isImportant = isImportant
        item.isScheduledDate = isScheduledDate
        item.isScheduledTime = isScheduledTime
        item.createdDate = createdDate
        item.scheduledDate = scheduledDate
    }
}
