//
//  AddNewTaskView.swift
//  ToDo
//
//  Created by zijie vv on 12/11/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import CoreData
import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Binding var addingNewTask: Bool

    @State private var scheduledDate: Bool = false {
        didSet {
            if !scheduledDate {
                scheduledTime = false
            }
        }
    }

    @State private var scheduledTime: Bool = false {
        didSet {
            if scheduledTime {
                scheduledDate = true
            }
        }
    }

    @ObservedObject var taskVM = TaskViewModel()

    init(isPresented condition: Binding<Bool>) {
        self._addingNewTask = condition
    }

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
            .navigationBarItems(leading: cancel, trailing: done)
        }
    }

    private var done: some View {
        Button(action: {
            let newTask = Task(context: viewContext)

            taskVM.assign(to: newTask)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            addingNewTask = false
        }, label: {
            Text("Done")
        })
            .disabled(taskVM.title.isEmpty)
    }

    private var cancel: some View {
        Button(action: {
            addingNewTask = false
        }, label: {
            Text("Cancel")
        })
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
                  isOn: $scheduledDate,
                  labelName: "Date")
    }

    private var scheduleTimeToggle: some View {
        toggleRow(imageName: "clock.fill",
                  color: .blue,
                  isOn: $scheduledTime,
                  labelName: "Time")
    }

    private var completeToggle: some View {
        toggleRow(imageName: "checkmark.circle.fill",
                  color: .green,
                  isOn: $taskVM.isCompleted,
                  labelName: "Complete")
    }
}

struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView(isPresented: .constant(true))
//            .environment(\.colorScheme, .dark)
    }
}