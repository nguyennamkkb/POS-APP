//
//  inputCommon.swift
//  LN POS
//
//  Created by Mac mini on 25/04/2024.
//

import Foundation

class InputCommon {
    public static func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Z]{2,}"
        let regex = try! NSRegularExpression(pattern: emailRegex, options: .caseInsensitive)
        return regex.matches(in: email, range: NSRange(location: 0, length: email.count)).count > 0
    }
    
}
