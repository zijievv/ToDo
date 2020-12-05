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
    init() {
        let design = UIFontDescriptor.SystemDesign.rounded
        let color = UIColor.systemBlue
        let largeWeight = UIFontDescriptor.SymbolicTraits.traitBold
        let largeDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!
            .withSymbolicTraits(largeWeight)!
        let largeFont = UIFont(descriptor: largeDescriptor, size: 34)

        let inlineDescriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: .headline)
            .withDesign(design)!
        let inlineFont = UIFont(descriptor: inlineDescriptor, size: 20)

        // Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: color,
            .font: largeFont,
        ]

        // Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: color,
            .font: inlineFont,
        ]
    }

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
//            .environment(\.colorScheme, .dark)
    }
}
