//
//  LocalNotification.swift
//  ToDo
//
//  Created by zijie vv on 05/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import os
import SwiftUI

class LocalNotification: ObservableObject {
//    let notificationCenter = UNUserNotificationCenter.current()

    init() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound]) { allowed, _ in
                //This callback does not trigger on main loop be careful
                if allowed {
                    os_log(.debug, "Allowed")
                } else {
                    os_log(.debug, "Error")
                }
            }
    }

    func scheduleNotification(of task: Task) {
        guard let date = task.scheduledDate else { return }
        guard date > Date() else { return }

        let content = UNMutableNotificationContent()
        let categoryIdentifier = "Delete Notification Type"

        content.title = task.title!
        content.body = task.scheduledDate!.dateFormatterString()

        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = categoryIdentifier

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: date.timeIntervalSinceNow,
            repeats: false
        )
        let identifier = task.id!.uuidString

        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
