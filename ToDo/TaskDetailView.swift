//
//  TaskDetailView.swift
//  ToDo
//
//  Created by zijie vv on 12/11/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import CoreData
import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var taskVM: TaskViewModel = TaskViewModel()
    @Binding var showTaskDetail: Bool

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
                    scheduleTimeToggle
                }

                Section {
                    completeToggle
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Detail")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.black)
                }
            }
            .navigationBarItems(leading: cancelButton, trailing: doneButton)
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
                  isOn: $taskVM.isScheduledDate,
                  labelName: "Date")
    }

    private var scheduleTimeToggle: some View {
        toggleRow(imageName: "clock.fill",
                  color: .blue,
                  isOn: $taskVM.isScheduledTime,
                  labelName: "Time")
    }

    private var completeToggle: some View {
        toggleRow(imageName: "checkmark.circle.fill",
                  color: .green,
                  isOn: $taskVM.isCompleted,
                  labelName: "Complete")
    }

    private var cancelButton: some View {
        Button(action: {
            showTaskDetail.toggle()
        }, label: {
            Text("Cancel")
        })
    }

    private var doneButton: some View {
        Button(action: {
            let item = Task(context: viewContext)

            taskVM.assign(to: item)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            showTaskDetail.toggle()
        }, label: {
            Text("Done")
        })
            .disabled(taskVM.title.isEmpty)
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(showTaskDetail: .constant(true))
    }
}
