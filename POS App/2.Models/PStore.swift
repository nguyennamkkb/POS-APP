//
//  PStore.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PStore: Mappable {
    
    var id: String?
    var storeName: String?
    var phone: String?
    var address: String?
    var bankCode: String?
    var accountNumber: String?
    var email: String?
    var status: Int?
    var timeCreate: Int64?
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        storeName <- map["storeName"]
        phone <- map["phone"]
        address <- map["address"]
        bankCode <- map["bankCode"]
        accountNumber <- map["accountNumber"]
        email <- map["email"]
        status <- map["status"]
        timeCreate <- map["timeCreate"]
    }
    
}
