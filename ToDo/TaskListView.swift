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
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.isCompleted, ascending: true),
            NSSortDescriptor(keyPath: \Task.scheduledDate, ascending: false),
            NSSortDescriptor(keyPath: \Task.createdDate, ascending: true),
        ],
        animation: .default
    )
    private var tasks: FetchedResults<Task>

    @State var showTaskDetail: Bool = false
    @State private var showCompleted: Bool = false

    var filteredTasks: [Task] {
        return showCompleted ? tasks.map { $0 } : tasks.filter { !$0.isCompleted }
    }

    var body: some View {
        VStack {
            List {
                ForEach(filteredTasks) { task in
                    HStack {
                        Image(systemName: task.isCompleted ? "largecircle.fill.circle" : "circle")
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
                newTaskButton
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Reminder")
        .navigationBarItems(
            trailing: showCompletedTasksButton
        )
        .sheet(isPresented: $showTaskDetail) {
            TaskDetailView(showTaskDetail: $showTaskDetail)
        }
    }

    private func addItem() {
        withAnimation {
            showTaskDetail = true
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

    private var showCompletedTasksButton: some View {
        Button(action: { showCompleted.toggle() }) {
            Text(showCompleted ? "Hide Completed" : "Show Completed")
                .fontWeight(.semibold)
        }
    }

    private var newTaskButton: some View {
        Button(action: addItem) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                Text("New Reminder")
                    .fontWeight(.semibold)
            }
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
