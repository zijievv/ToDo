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
        let weight = UIFontDescriptor.SymbolicTraits.traitBold
        let design = UIFontDescriptor.SystemDesign.rounded
        let descriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!
            .withSymbolicTraits(weight)!
        let font = UIFont(descriptor: descriptor, size: 34)

        // Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: self.color,
            .font: font,
        ]

        // Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: self.color,
        ]
    }

    var body: some View {
        GeometryReader { _ in
            NavigationView {
                VStack(alignment: .leading) {
                    List {
                        ForEach(self.taskListVM.taskCellViewModels) { vmTaskCell in
                            TaskCell(taskCellVM: vmTaskCell)
                        }
                        .onDelete { indexSet in
                            self.taskListVM.removeTask(atOffsets: indexSet)
                        }
                    }
                    .listStyle(InsetListStyle())

                    Button(action: {}) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(Color(self.color))
                    }
                    .padding(.leading)
                }
                .navigationTitle("Reminder")
            }
        }
    }

    var navigationTitle: some View {
        HStack {
            Text("Reminders")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(color))
            Spacer()
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
                        self.onCommit(.success(taskCellVM.task))
                    } else {
                        self.onCommit(.failure(.empty))
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
