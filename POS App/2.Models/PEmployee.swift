//
//  PEmployee.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PEmployee: Mappable {
    var id: String?
    var store_id: Int?
    var fullName: String?
    var phone: String?
    var address: String?
    var birthday: Int64?
    var gender: Int?
    var image: String?
    var type: Int64?
    var bankCode: String?
    var accountNumber: String?
    var keySearch: String?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        store_id <- map["store_id"]
        fullName <- map["fullName"]
        phone <- map["phone"]
        address <- map["address"]
        birthday <- map["birthday"]
        gender <- map["gender"]
        image <- map["image"]
        type <- map["type"]
        bankCode <- map["bankCode"]
        accountNumber <- map["accountNumber"]
        keySearch <- map["keySearch"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        
    }
}
