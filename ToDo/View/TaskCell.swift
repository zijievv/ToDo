//
//  TaskCell.swift
//  ToDo
//
//  Created by zijie vv on 05/11/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct TaskCell: View {
//    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var taskListViewModel: TaskListViewModel
    var task: Task

    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "largecircle.fill.circle" : "circle")
                .font(.system(Font.TextStyle.title2))
                .foregroundColor(task.isCompleted ? .blue : .gray)
                .onTapGesture {
                    if !task.isCompleted {
                        print("delay")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            taskListViewModel.toggleCompleteStatus(of: task)
                        }
                    } else {
                        print("not delay")
                        taskListViewModel.toggleCompleteStatus(of: task)
                    }
                }

            ZStack {
                Rectangle()
                    .foregroundColor(Color(.systemGray6))
                    .cornerRadius(8)

                HStack {
                    Text(task.title)
                        .font(.system(.body, design: .rounded))
                    Spacer()

                    if task.isImportant {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(10)
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TaskCell(
                taskListViewModel: TaskListViewModel(),
                task: Task(title: "Hello", isImportant: true, isCompleted: false)
            )
        }
//        .environment(\.colorScheme, .dark)
    }
}
