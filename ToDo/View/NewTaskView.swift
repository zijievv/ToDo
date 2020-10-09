//
//  NewTaskView.swift
//  ToDo
//
//  Created by zijie vv on 09/10/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct NewTaskView: View {
    @Binding var showAddNew: Bool
    @ObservedObject var newTaskVM: NewTaskViewModel
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("New Reminder", text: $title)
                }
                
                Section {
                    important
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
    
    private var important: some View {
        HStack {
            Image(systemName: "star.square.fill")
                .foregroundColor(.orange)
            
            Toggle(isOn: .constant(true), label: {
                Text("Important")
            })
        }
        .font(.system(.title3, design: .rounded))
    }
    
    private var cancelButton: some View {
        Button(action: {
            showAddNew.toggle()
        }, label: {
            Text("Cancel")
        })
    }
    
    private var doneButton: some View {
        Button(action: {
            newTaskVM.addNewTask(title: title)
            showAddNew.toggle()
        }, label: {
            Text("Done")
        })
        .disabled(title.isEmpty)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(showAddNew: .constant(true), newTaskVM: NewTaskViewModel())
    }
}
