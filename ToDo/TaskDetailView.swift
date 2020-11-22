//
//  TaskDetailView.swift
//  ToDo
//
//  Created by zijie vv on 15/11/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import CoreData
import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var taskVM: TaskViewModel
    @State private var scheduledDate = Date()

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("New Reminder", text: $taskVM.title)
                }

                Section {
                    importantToggle
                }

                Section {
                    scheduleDateToggle

                    if taskVM.isScheduled {
                        DatePicker("Remind Date", selection: $scheduledDate)
                    }
                }

                Section {
                    completeToggle
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Detail")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.medium)
                }
            }
            .navigationBarItems(leading: cancel, trailing: done)
        }
    }

    private var done: some View {
        Button(action: {
            if taskVM.isScheduled { taskVM.scheduledDate = scheduledDate }
            taskVM.writeData(to: viewContext)
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
                .font(.system(.headline, design: .rounded))
        }
        .disabled(taskVM.title.isEmpty)
    }

    private var cancel: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
                .font(.system(.headline, design: .rounded))
        }
    }

    private func saveData() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func toggleRow(
        imageName: String,
        color: Color,
        isOn: Binding<Bool>,
        labelName: String
    ) -> some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(color)

            Toggle(isOn: isOn) {
                Text(labelName)
            }
        }
        .font(.system(.title3, design: .rounded))
    }

    private var importantToggle: some View {
        toggleRow(imageName: "star.fill",
                  color: .orange,
                  isOn: $taskVM.isImportant,
                  labelName: "Important")
    }

    private var scheduleDateToggle: some View {
        toggleRow(imageName: "calendar",
                  color: .red,
                  isOn: $taskVM.isScheduled,
                  labelName: "Date")
    }

    private var completeToggle: some View {
        toggleRow(imageName: "checkmark.circle.fill",
                  color: .blue,
                  isOn: $taskVM.isCompleted,
                  labelName: "Complete")
    }
}

struct TaskDetailView_Preview: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskVM: TaskViewModel())
            .environment(\.managedObjectContext,
                         PersistenceController.preview.container.viewContext)
//            .environment(\.colorScheme, .dark)
    }
}
