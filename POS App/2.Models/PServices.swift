//
//  PServices.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PServices: Mappable {
    var id: String?
    var name: String?
    var price: Double?
    var discount: Double?
    var note: String?
    var point: Int64?
    var image: String?
    var status: Int?
    var timeCreate: Int64?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
        discount <- map["discount"]
        note <- map["note"]
        point <- map["point"]
        image <- map["image"]
        timeCreate <- map["timeCreate"]
        status <- map["status"]
    }
}
