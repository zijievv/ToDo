//
//  TaskListView.swift
//  ToDo
//
//  Created by zijie vv on 25/09/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @State var isAddingNewTask: Bool = false

    let color: UIColor = .systemBlue

    init() {
        let design = UIFontDescriptor.SystemDesign.rounded

        let largeWeight = UIFontDescriptor.SymbolicTraits.traitBold
        let largeDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!
            .withSymbolicTraits(largeWeight)!
        let largeFont = UIFont(descriptor: largeDescriptor, size: 34)

        let inlineDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .headline)
            .withDesign(design)!
        let inlineFont = UIFont(descriptor: inlineDescriptor, size: 20)

        // Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: color,
            .font: largeFont,
        ]

        // Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: color,
            .font: inlineFont,
        ]
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { vmTaskCell in
                        TaskCell(taskCellVM: vmTaskCell)
                    }
                    .onDelete { indexSet in
                        taskListVM.removeTask(atOffsets: indexSet)
                    }

                    if isAddingNewTask {
                        TaskCell(taskCellVM: TaskCellViewModel.newTask()) { result in
                            if case let .success(task) = result {
                                taskListVM.addTask(task)
                            }
                            isAddingNewTask.toggle()
                        }
                    }
                }
                .listStyle(InsetListStyle())

                if !isAddingNewTask {
                    Button(action: { isAddingNewTask.toggle() }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(Color(color))
                    }
                    .padding()
                }
            }
            .navigationTitle("Reminder")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Result<Task, InputError>) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: taskCellVM.completionIcon.name)
                    .font(.system(Font.TextStyle.title3))
                    .foregroundColor(taskCellVM.completionIcon.color)
                    .onTapGesture {
                        taskCellVM.task.completed.toggle()
                    }

                TextField("New Reminder", text: $taskCellVM.task.title, onCommit: {
                    if !taskCellVM.task.title.isEmpty {
                        onCommit(.success(taskCellVM.task))
                    } else {
                        onCommit(.failure(.empty))
                    }
                })
                    .id(taskCellVM.id)
            }
        }
    }
}

enum InputError: Error {
    case empty
}
