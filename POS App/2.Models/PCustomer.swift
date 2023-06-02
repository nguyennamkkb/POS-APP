//
//  PCustomer.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PCustomer: Mappable {
    var id: String?
    var store_id: Int?
    var fullName: String?
    var phone: String?
    var address: String?
    var birthday: String?
    var gender: String?
    var image: String?
    var keySearch: String?
    var email: String?
    var loyalty: Int64?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    
    init(){}
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
        keySearch <- map["keySearch"]
        image <- map["image"]
        email <- map["email"]
        loyalty <- map["loyalty"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        
    }
}
