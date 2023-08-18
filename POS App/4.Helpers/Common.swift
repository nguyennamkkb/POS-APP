//
//  Common.swift
//  BaseApp
//
//  Created by namnl on 25/04/2023.
//

import Foundation
import ObjectMapper
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class Common {
    public static var KEY_APP = "50829317681RT3RUH3EZ"
    public static var isInternet = false//false bat tinh năng ckeck ẩn menu để false
    public static var isRunningUpOffW = false
    public static var MillisecondsOfDay: Int64 = 86400000 - 1
    public static var userMaster: PStore = PStore()
    public static var anhChupAvatar: String = ""
    static var dateFormatter = DateFormatter()
    public static func getDateFormatFromMiliseonds(time: String) -> String{
        let date = Date(milliseconds: Int64(time) ?? 0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd-MM-yyyy"
        
        let formattedDateString = dateFormatter.string(from: date)
        return (formattedDateString) // Output: "11-03-2023 14:10"
        
    }
    public static func convertTimestampToDate(timestampString: String, dateFormat: String) -> String{
        let date = Date(milliseconds: Int64(timestampString) ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let formattedDateString = dateFormatter.string(from: date)
        return (formattedDateString) // Output: "11-03-2023 14:10"
        
    }
    public static func getStringStatus(status: Int) -> String {
        switch status {
        case 0:
            return "Chưa thực hiện"
        case 1:
            return "Hoàn thành"
        case 2:
            return "Chờ thanh toán"
        case 3:
            return "Đang thực hiện"
            
        default:
            return "Đang thực hiện"
        }
    }
    //    0: Chưa thực hiện //xoa, sua, run
    //    1: hoàn thành // xoa
    //    2: Chờ thanh toán // xoa, pay, edit
    //    3: Đang thực hiện // xoa, tich
    
    public static func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return  digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    public static func getMilisecondNow() -> Int {
        let date = Date()
        let milliseconds = Int(date.timeIntervalSince1970 * 1000)
        return milliseconds
    }
    public static func  dateStringToMilis(dateString: String) -> Int64? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "vi_VN")
        
        if let date = dateFormatter.date(from: dateString) {
            return Int64(date.timeIntervalSince1970 * 1000)
        }
        
        return nil
    }
    public static func getCurrentDayMonthYear() -> (day: Int, month: Int, year: Int) {
        // Create a calendar instance
        let calendar = Calendar.current
        
        // Get the current date
        let currentDate = Date()
        
        // Extract day, month, and year components from the current date
        let day = calendar.component(.day, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        return (day, month, year)
    }
    
    public static func dateFromUnixTimestamp(milliseconds: Double) -> Date {
        return Date(timeIntervalSince1970: milliseconds / 1000.0)
    }
    public static func timeFromUnixTimestamp(milliseconds: Double) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let date  = Date(timeIntervalSince1970: milliseconds / 1000.0)
        let calendar = Calendar.current
        let second = calendar.component(.second, from: date)
        let minute = calendar.component(.minute, from: date)
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return (year, month, day, hour, minute, second)
        
    }
    
}
