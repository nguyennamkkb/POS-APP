//
//  Common.swift
//  BaseApp
//
//  Created by namnl on 25/04/2023.
//

import Foundation
import ObjectMapper

class Common {
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
}
