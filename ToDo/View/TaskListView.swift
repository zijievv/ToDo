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
    @ObservedObject var taskListVM: TaskListViewModel
    @State var isAddingNewTask: Bool = false

    let color: UIColor = .systemBlue

    init(taskListViewModel: TaskListViewModel = TaskListViewModel()) {
        self.taskListVM = taskListViewModel

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
                    ForEach(taskListVM.tasks) { task in
                        TaskCell(task: task)
                    }
//                    if isAddingNewTask {
//                        TaskCell(taskCellVM: TaskCellViewModel.newTask()) { result in
//                            if case let .success(task) = result {
//                                taskListVM.addTask(task)
//                            }
//                            isAddingNewTask.toggle()
//                        }
//                    }
                }
                .listStyle(InsetListStyle())
                .listSeparatorStyle(.none)
                .onAppear {
                    self.taskListVM.fetchTasks()
                }

                if !isAddingNewTask {
                    addNewButton
                        .padding()
                }
            }
            .navigationTitle("Reminder")
            .navigationBarItems(trailing: showOrHideCompleted)
        }
    }

    var showOrHideCompleted: some View {
        Button(action: {
            taskListVM.showCompleted.toggle()
            self.taskListVM.fetchTasks()
        }) {
            Text(taskListVM.showCompleted ? "Hide Completed" : "Show Completed")
        }
    }

    var addNewButton: some View {
        Button(action: { /* isAddingNewTask.toggle() */ }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("New Reminder")
            }
            .font(.system(.headline, design: .rounded))
            .foregroundColor(Color(color))
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        var view = TaskListView()
        view.taskListVM = TaskListViewModel(taskManager: MockTaskManager())
        return view
    }
}

struct TaskCell: View {
    @Environment(\.colorScheme) var colorScheme
    var task: Task

    var body: some View {
        HStack {
            Image(systemName: task.completed ? "largecircle.fill.circle" : "circle")
                .font(.system(Font.TextStyle.title2))
                .foregroundColor( task.completed ? .blue : .gray)
                .onTapGesture {
                    // TODO: tap to toggle complete status
                }

            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .opacity(colorScheme == .dark ? 0.25 : 0.15)
                    .cornerRadius(10)

                HStack {
                    Text(task.title)
                    Spacer()

                    if task.important {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(10)
            }
        }
    }
}
