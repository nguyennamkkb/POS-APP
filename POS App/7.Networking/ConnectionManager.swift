//
//  ConnectionManager.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import UIKit

class ConnectionManager {

static let sharedInstance = ConnectionManager()
    private var reachability : Reachability!// = Reachability()

func observeReachability(){
//    self.reachability = Reachability()
    NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
    do {
        try self.reachability = Reachability()
        try self.reachability.startNotifier()
    }
    catch(let error) {
        print("Error occured while starting reachability notifications : \(error.localizedDescription)")
    }
}

@objc func reachabilityChanged(note: NSNotification) {
    let reachability = note.object as! Reachability
    switch reachability.connection {
    case .cellular:
        print("Network available via Cellular Data.")
        Common.isInternet = true
        break
    case .wifi:
        print("Network available via WiFi.")
        Common.isInternet = true
        break
    case .none:
        print("Network is not available.")
        Common.isInternet = false
        break
    case .unavailable:
        print("Network is  unavailable.")
        Common.isInternet = false
        break
    }
    
//    if UIApplication.topViewController() is BaseVC {
//        let home = UIApplication.topViewController() as! BaseVC
//        home.commitOff()
//    }
  }
}

