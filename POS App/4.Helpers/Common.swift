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
    public static func getDateFormatFromMiliseonds(time: Int) -> String{
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(time)/1000)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: dateVar)

    }
}
