//
//  BaseResponse.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation

import ObjectMapper

class BaseResponse: Mappable {
    var msgCode: Int?
    var msgContent: String?
    var msgContent_en: String?
    var result: Any?
    var totalMoney: Double?
    
    init() {
        
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        msgCode <- map["msgCode"]
        msgContent <- map["msgContent"]
        msgContent_en <- map["msgContent_en"]
        result <- map["result"]
        totalMoney <- map["totalMoney"]
    }

    func isSuccessCode() -> Bool {
        return msgCode == 1
    }
}


