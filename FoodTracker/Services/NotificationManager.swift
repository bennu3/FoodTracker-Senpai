//
//  NotificationManager.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/18/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static func showNotification(withId id: String, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body  = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
