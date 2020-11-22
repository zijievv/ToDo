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

    @FetchRequest(sortDescriptors: Self.sortDescriptiors, animation: .easeInOut)
    private var tasks: FetchedResults<Task>

    @ObservedObject var taskVM = TaskViewModel()

    @State private var showCompleted: Bool = false
    @State private var showTaskDetailView: Bool = false

    private var filteredTasks: [Task] {
        showCompleted ? tasks.map { $0 } : tasks.filter { !$0.isCompleted }
    }

    var body: some View {
        VStack {
            List {
                ForEach(filteredTasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundColor(task.isCompleted ? .blue : .gray)
                            .onTapGesture { toggleAndSaveCompletion(of: task) }

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
                            taskVM.resetAllAttributes()
                            taskVM.edit(task: task)
                            showTaskDetailView = true
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
        .sheet(isPresented: $showTaskDetailView) {
            TaskDetailView(taskVM: taskVM)
        }
    }

    private var addNewTask: some View {
        Button(action: {
            taskVM.resetAllAttributes()
            showTaskDetailView = true
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
        Button(action: {
            showCompleted.toggle()
        }) {
            Text(showCompleted ? "Hide Completed" : "Show Completed")
                .font(.system(.headline, design: .rounded))
        }
    }

    private func toggleAndSaveCompletion(of task: Task) {
        task.isCompleted.toggle()
        try! viewContext.save()
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
//        NavigationView {
        TaskListView()
            .environment(\.managedObjectContext,
                         PersistenceController.preview.container.viewContext)
//        }
        //        .environment(\.colorScheme, .dark)
    }
}
