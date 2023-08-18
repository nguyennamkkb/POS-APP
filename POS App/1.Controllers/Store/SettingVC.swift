//
//  SettingVC.swift
//  LN POS
//
//  Created by namnl on 17/08/2023.
//

import UIKit
import UserNotifications

class SettingVC: UIViewController {
    
    
    @IBOutlet var msgTF: UITextField!
    @IBOutlet var hourTF: UITextField!
    @IBOutlet var minTF: UITextField!
    @IBOutlet var secondTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendThongBao(_ sender: Any) {
//        setLich ()
        let mili = Common.getMilisecondNow()
        Notification.scheduleLocalNotificationAtMilis(title: "Thông báo", message: "Bạn là ai", time: Int64(mili + 2000))
    }
    func setLich (){
        let identifier = "my-noti"
        let title = "Thong báo"
        let body = msgTF.text ?? ""
        let hour = Int(hourTF.text ?? "0")
        let minute = Int(minTF.text ?? "0")
        let noti = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let calender = Calendar.current
        var dateComponents =  DateComponents(calendar: calender, timeZone: TimeZone(abbreviation: "UTC+7"))
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        noti.removePendingNotificationRequests(withIdentifiers: [identifier])

//        noti.add(request)
        noti.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Local notification scheduled successfully.")
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
