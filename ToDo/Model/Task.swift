//
//  Task.swift
//  ToDo
//
//  Created by zijie vv on 05/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//
//
//import SwiftUI
//import Foundation
//import CoreData
//
//public class Task: NSManagedObject, Identifiable {
//    @NSManaged public var id: UUID?
//    @NSManaged public var title: String?
//    @NSManaged public var createdDate: Date?
//    @NSManaged public var scheduledDate: Date?
//    @NSManaged public var isImportant: Bool
//    @NSManaged public var isCompleted: Bool
//}
//
//extension Task {
//    static func allToDoFetchRequest() -> NSFetchRequest<Task> {
//        let request: NSFetchRequest<Task> = Task.fetchRequest() as! NSFetchRequest<Task>
//
//        // The @FetchRequest property wrapper in the ContentView requires a sort descriptor
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        return request
//    }
//}
