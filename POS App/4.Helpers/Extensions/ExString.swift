//
//  ExString.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    //extension String {
//    func localizableString() -> String {
//        let loc = Language.getLanguage()
//            let path = Bundle.main.path(forResource: loc, ofType: "lproj")
//            let bundle = Bundle(path: path!)
//            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//    }
//    
    func removeHtmlTag() -> String {
        return self.replacing(pattern: "<br>", withTemplate: "\n").replacing(pattern: "&nbsp;", withTemplate: " ").withoutHtmlTags()
    }
    
    func withoutHtmlTags() -> String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil).trim()
    }
    
    func replacing(pattern:String, withTemplate:String) -> String {
        if let regex = try? NSRegularExpression.init(pattern: pattern, options: .caseInsensitive){
            return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.utf16.count), withTemplate: withTemplate)
        }
        return self
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
    
    func hasSpecialCharacter() -> Bool {
        return self.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil
    }
    
    // chuyen hex sang text
    func hexToStr() -> String {

           let regex = try! NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive)
           let textNS = self as NSString
           let matchesArray = regex.matches(in: textNS as String, options: [], range: NSMakeRange(0, textNS.length))
           let characters = matchesArray.map {
               Character(UnicodeScalar(UInt32(textNS.substring(with: $0.range(at: 2)), radix: 16)!)!)
           }

        return String(characters).replacingOccurrences(of: "\0", with: "", options: .literal, range: nil)
    }
    
    func strToHex() -> String {
        let data = Data(self.utf8)
        return  data.map{ String(format:"%02x", $0) }.joined()
    }
    
    func index(from: Int) -> Index {
        if self.count > from {
            return self.index(startIndex, offsetBy: from)
        }
        return Index(encodedOffset: 0)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        if self.count >= r.upperBound {
            let startIndex = index(from: r.lowerBound)
            let endIndex = index(from: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
        return ""
    }
    
    func isPhoneNumberFormat() -> Bool {
        if self.count == 10 || self.count == 11 {
            let phoneRegEx = "[0-9]*$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            return phoneTest.evaluate(with: self)
        }
        return false
    }
    
    
    func index2(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring2(from: Int) -> String {
        let fromIndex = index2(from: from)
        return String(self[fromIndex...])
    }

    func substring2(to: Int) -> String {
        let toIndex = index2(from: to)
        return String(self[..<toIndex])
    }

    func substring2(with r: Range<Int>) -> String {
        let startIndex = index2(from: r.lowerBound)
        let endIndex = index2(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
