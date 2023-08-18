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
        Notification.scheduleLocalNotificationAtMilis(title: "Thông báo", message: "Bạn là ai 1111", time: Int64(mili + 4000), identifier: String(mili + 4000))
        Notification.scheduleLocalNotificationAtMilis(title: "Thông báo", message: "Bạn là ai 2222", time: Int64(mili + 8000), identifier: String(mili + 8000))
        Notification.deleteNotification(withIdentifier: String(mili + 8000))
        Notification.viewPendingNotifications()
    }
    
}
