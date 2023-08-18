//
//  Notifications.swift
//  LN POS
//
//  Created by namnl on 17/08/2023.
//

import Foundation
import UserNotifications



class Notification {
    public static func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Local notification permission granted.")
            } else {
                print("Local notification permission denied.")
            }
        }
    }
    
    public static func viewPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            if requests.isEmpty {
                print("No pending notifications.")
            } else {
                print("Pending notifications:")
                for request in requests {
                    print("Title: \(request.content.title), Body: \(request.content.body), Trigger Date: \(request.trigger.debugDescription), identifier \(request.identifier)")
                }
            }
        }
    }
    
    public static func viewDeliveredNotifications() {
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            if notifications.isEmpty {
                print("No delivered notifications.")
            } else {
                print("Delivered notifications:")
                for notification in notifications {
                    print("Title: \(notification.request.content.title), Body: \(notification.request.content.body), Date: \(notification.date.debugDescription)")
                }
            }
        }
    }
    public static func deleteNotification(withIdentifier identifier: String) {
        let center = UNUserNotificationCenter.current()

        center.getPendingNotificationRequests { requests in
            let identifiers = requests.filter { $0.identifier == identifier }.map { $0.identifier }

            if !identifiers.isEmpty {
                center.removePendingNotificationRequests(withIdentifiers: identifiers)
            }
        }
    }
    public static func scheduleLocalNotificationAtMilis(title: String?, message: String?, time: Int64, identifier: String?) {
        let identifier = identifier ?? ""
        let title = title ?? ""
        let body = message ?? ""
        let noti = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calender = Calendar.current
        var dateComponents =  DateComponents(calendar: calender, timeZone: TimeZone(abbreviation: "UTC+7"))
        let time = Common.timeFromUnixTimestamp(milliseconds: Double(time))
        
        dateComponents.hour = time.hour
        dateComponents.minute = time.minute
        dateComponents.second = time.second
        
//        print(time.year)
//        print(time.month)
//        print(time.hour)
//        print(time.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        noti.removePendingNotificationRequests(withIdentifiers: [identifier])

        noti.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Local notification scheduled successfully.")
            }
        }
    }
    
}

