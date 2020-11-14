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

    var filteredTasks: [Task] {
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

                                    if task.isScheduledDate {
                                        Text(
                                            task.scheduledDate!,
                                            formatter: task
                                                .isScheduledTime ? timeFormatter : dateFormatter
                                        )
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
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(InsetListStyle())
            .listSeparatorStyle(.none)

            HStack {
                addNewTask
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Reminder")
        .navigationBarItems(
            trailing: showCompletedTasks
        )
        .sheet(isPresented: $addingNewTask) {
            AddNewTaskView(isPresented: $addingNewTask)
        }
    }

    private var addNewTask: some View {
        Button(action: {
            addingNewTask = true
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                Text("New Reminder")
                    .fontWeight(.semibold)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private var showCompletedTasks: some View {
        Button(action: { showCompleted.toggle() }) {
            Text(showCompleted ? "Hide Completed" : "Show Completed")
                .fontWeight(.semibold)
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    private let timeFormatter: DateFormatter = {
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
