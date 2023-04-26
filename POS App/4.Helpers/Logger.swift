//
//  Logger.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation

class Logger {
    static func log(_ content: Any) {
        #if DEBUG
            print(content)
        #endif
    }
    
    static func log(_ tag: String, _ content: Any) {
        #if DEBUG
            print(tag + ": \(content)")
        #endif
    }
}
