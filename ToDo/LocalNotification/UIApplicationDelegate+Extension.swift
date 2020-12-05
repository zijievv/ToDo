//
//  UIApplicationDelegate+Extension.swift
//  ToDo
//
//  Created by zijie vv on 05/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

extension UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("Successfully registered for notifications!")
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
}

