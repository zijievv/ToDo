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
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .leading) {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(0..<5) { _ in
                                TaskCell()
                            }
                        }
                    }

                    Button(action: {}) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.blue)
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

    let navigationTitle: some View = {
        HStack {
            Text("Reminders")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Spacer()
        }
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
//                Image(systemName: "largecircle.fill.circle")
                Image(systemName: "circle")
                    .font(.system(Font.TextStyle.title3))
                Text("Hello")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.light)
            }

            HStack(alignment: .center) {
                Image(systemName: "circle")
                    .font(.system(Font.TextStyle.title3))
                    .foregroundColor(.clear)
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 1)
            }
        }
    }
}
