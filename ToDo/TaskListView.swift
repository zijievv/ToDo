//
//  TaskListView.swift
//  ToDo
//
//  Created by zijie vv on 11/10/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import CoreData
import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    private static var sortDescriptiors = [
        NSSortDescriptor(keyPath: \Task.isCompleted, ascending: true),
        NSSortDescriptor(keyPath: \Task.scheduledDate, ascending: false),
        NSSortDescriptor(keyPath: \Task.createdDate, ascending: true),
    ]

    @FetchRequest(sortDescriptors: Self.sortDescriptiors, animation: .default)
    private var tasks: FetchedResults<Task>

    @State private var showCompleted: Bool = false
    @State private var addingNewTask: Bool = false
    @State private var editingTask: Bool = false
    @ObservedObject private var editedTaskVM: TaskViewModel = TaskViewModel()

    private var filteredTasks: [Task] {
        if showCompleted {
            return tasks.map { $0 }
        } else {
            return tasks.filter { !$0.isCompleted }
        }
    }

    var body: some View {
        VStack {
            List {
                ForEach(filteredTasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundColor(task.isCompleted ? .blue : .gray)
                            .onTapGesture(perform: {
                                task.isCompleted.toggle()
                            })

                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(.systemGray6))
                                .cornerRadius(8)

                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(task.title!)
                                        .font(.system(.body, design: .rounded))
                                        .frame(width: 260, height: 20, alignment: .leading)

                                    if let date = task.scheduledDate {
                                        Text(date, formatter: dateFormatter)
                                            .font(.caption)
                                            .foregroundColor(Color(.systemGray))
                                            .padding(.top, 3)
                                    }
                                }

                                Spacer()

                                if task.isImportant {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(10)
                        }
                        .onTapGesture {
                            editedTaskVM.get(task: task)
                            viewContext.delete(task)
                            editingTask = true
                        }
                        .sheet(isPresented: $editingTask) {
                            TaskDetailView(isPresented: $editingTask, editedTaskVM: editedTaskVM)
                        }
                    }
                }
                .onDelete(perform: withAnimation { deleteItems })
            }
            .listStyle(InsetListStyle())
            .listSeparatorStyle(.none)

            HStack {
                addNewTask
                Spacer()
                showCompletedTasks
            }
            .padding()
        }
        .navigationTitle("Reminder")
        .sheet(isPresented: $addingNewTask) {
            TaskDetailView(isPresented: $addingNewTask)
        }
    }

    private var addNewTask: some View {
        Button(action: {
            addingNewTask = true
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("New Reminder")
            }
            .font(.system(.headline, design: .rounded))
        }
    }

    private func deleteItems(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private var showCompletedTasks: some View {
        Button(action: { showCompleted.toggle() }) {
            Text(showCompleted ? "Hide Completed" : "Show Completed")
                .font(.system(.headline, design: .rounded))
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskListView()
                .environment(\.managedObjectContext,
                             PersistenceController.preview.container.viewContext)
        }
        //        .environment(\.colorScheme, .dark)
    }
}
