//
//  AppDelegate+Resolving.swift
//  ToDo
//
//  Created by zijie vv on 27/09/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // Register for creating instances of TestDataTaskRepository
        register { TestDataTaskRepository() as TaskRepository }.scope(application)
    }
}
