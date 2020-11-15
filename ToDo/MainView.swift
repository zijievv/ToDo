//
//  MainView.swift
//  ToDo
//
//  Created by zijie vv on 15/11/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TaskListView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext,
                         PersistenceController.preview.container.viewContext)
    }
}
