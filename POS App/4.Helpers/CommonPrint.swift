//
//  CommonPrint.swift
//  LN POS
//
//  Created by Mac mini on 04/05/2024.
//

import Foundation

class CommonPrint {
    static var totalCharacterInline: Int = 32
    public static func removeVietnameseDiacritics(from input: String) -> String {
//        let mutableString = NSMutableString(string: input)
//ssssssssssss
//        if CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false) {
//            return mutableString as String
//        }
        
        return input.removeAccents()
    }
    public static func NamKVItem(left: String, right: String) -> String {
        let total: Int = right.count + left.count
        var newRString: String = left
        if total < totalCharacterInline {
            let spacesToAdd = totalCharacterInline - total
            for _ in 0..<spacesToAdd {
                newRString += " "
            }
        }
        return newRString + right
        
    }
}
