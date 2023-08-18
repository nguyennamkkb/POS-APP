//
//  NotificationVC.swift
//  LN POS
//
//  Created by namnl on 17/08/2023.
//

import UIKit
import UserNotifications


class NotificationVC: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()

            scheduleLocalNotification()
        }

        func scheduleLocalNotification() {
            let content = UNMutableNotificationContent()
            content.title = "Your Title"
            content.body = "Your Notification Message"
            content.sound = .default

            // Convert the timestamp to a Date object
            let timestamp = 1691009531000 / 1000 // Convert from milliseconds to seconds
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

            // Configure the trigger with the date and time
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

            // Create the notification request
            let request = UNNotificationRequest(identifier: "uniqueIdentifier", content: content, trigger: trigger)

            // Schedule the notification
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Local notification scheduled successfully.")
                }
            }
        }


}
