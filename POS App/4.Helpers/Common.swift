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
    public static var userMaster: PStore = PStore()
    public static var anhChupAvatar: String = ""
    static var dateFormatter = DateFormatter()
    public static func getDateFormatFromMiliseonds(time: String) -> String{
        let timestampString = time
        if let timestamp = TimeInterval(timestampString) {
            let date = Date(timeIntervalSince1970: timestamp)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            
            let formattedDateString = dateFormatter.string(from: date)
            return (formattedDateString) // Output: "11-03-2023 14:10"
        } else {
            return("Invalid timestamp")
        }
        
    }
    public static func convertTimestampToDate(timestampString: String, dateFormat: String) -> String{
        
        if let timestamp = TimeInterval(timestampString) {
            let timeInSeconds = floor(timestamp / 1000)
            //            let date = Date(timeIntervalSince1970: timestamp)
            let date = Date(timeIntervalSince1970: timeInSeconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
        
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
}
