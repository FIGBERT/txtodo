//
//  GlobalVars.swift
//  txtodo
//
//  Created by FIGBERT on 3/18/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import UserNotifications

class GlobalVars: ObservableObject {
    @Published var showOnboarding: Bool
    @Published var notifications: Bool = UserDefaults.standard.bool(forKey: "notifications") {
        willSet {
            if !newValue {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            } else {
                enableNotifications()
            }
            UserDefaults.standard.set(newValue, forKey: "notifications")
        }
    }
    @Published var notificationID: String = UserDefaults.standard.string(forKey: "notificationID") ?? "not yet set" {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "notificationID")
        }
    }
    @Published var notificationHour: Int = UserDefaults.standard.integer(forKey: "notificationHour") {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "notificationHour")
            enableNotifications(timeChange: true)
        }
    }
    @Published var notificationMinute: Int = UserDefaults.standard.integer(forKey: "notificationMinute") {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "notificationMinute")
            enableNotifications(timeChange: true)
        }
    }
    func enableNotifications(toggleSwitch: Bool = false, timeChange: Bool = false) {
        if timeChange {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in
            if success {
                DispatchQueue.main.async {
                    if toggleSwitch {
                        self.notifications = true
                    }
                    let content = UNMutableNotificationContent()
                    content.title = "open txtodo"
                    content.body = "take some time to plan your day"
                    content.sound = UNNotificationSound.default
                    var time = DateComponents()
                    time.hour = self.notificationHour
                    time.minute = self.notificationMinute
                    let trigger = UNCalendarNotificationTrigger(
                        dateMatching: time,
                        repeats: true
                    )
                    let id = UUID().uuidString
                    self.notificationID = id
                    let request = UNNotificationRequest(
                        identifier: id,
                        content: content,
                        trigger: trigger
                    )
                    UNUserNotificationCenter.current().add(request)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            showOnboarding = true
        } else {
            showOnboarding = false
        }
    }
}
