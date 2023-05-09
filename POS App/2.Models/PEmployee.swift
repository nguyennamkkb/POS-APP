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
    var fullName: String?
    var phone: String?
    var address: String?
    var birthday: Int64?
    var gender: Int?
    var image: String?
    var email: String?
    var loyalty: Int64?
    var type: Int64?
    var bankCode: String?
    var accountNumber: String?
    var status: Int?
    var timeCreate: Int64?
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        fullName <- map["fullName"]
        phone <- map["phone"]
        address <- map["address"]
        birthday <- map["birthday"]
        gender <- map["gender"]
        image <- map["image"]
        email <- map["email"]
        loyalty <- map["loyalty"]
        type <- map["type"]
        status <- map["status"]
        timeCreate <- map["timeCreate"]
        bankCode <- map["bankCode"]
        accountNumber <- map["accountNumber"]
        
    }
}