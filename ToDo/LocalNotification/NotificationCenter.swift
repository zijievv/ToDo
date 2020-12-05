//
//  NotificationCenter.swift
//  ToDo
//
//  Created by zijie vv on 04/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

class NotificationCenter: NSObject, ObservableObject {
    var notificationResponse: UNNotificationResponse?

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationCenter: UNUserNotificationCenterDelegate  {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
            @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        //
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        notificationResponse = response
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                openSettingsFor notification: UNNotification?) {
        //
    }
}
