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
    var tasks: [Task] = testTasksData
    let color: Color = .blue

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .leading) {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(self.tasks, id: \.id) { task in
                                TaskCell(task: task)
                            }
                            .onDelete { indexSet in
                                // TODO: delete
                                print(indexSet)
                            }
                        }
                    }

                    Button(action: {}) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(self.color)
                    }
                }
                .padding(.leading)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        self.navigationTitle
                            .padding()
                            .frame(width: geometry.size.width)
                    }
                }
            }
        }
    }

    var navigationTitle: some View {
        HStack {
            Text("Reminders")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(color)
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
    var task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
//                Image(systemName: "largecircle.fill.circle")
                Image(systemName: task.completed ? "largecircle.fill.circle" : "circle")
                    .font(.system(Font.TextStyle.title3))
                    .foregroundColor(task.completed ? .blue : .gray)
                    .onTapGesture {
                        // TODO: completed sign
                    }
                Text(task.title)
            }

            HStack(alignment: .center) {
                Image(systemName: "circle")
//                    .font(.system(Font.TextStyle.title3))
                    .foregroundColor(.clear)
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 0.7)
            }
        }
    }
}
