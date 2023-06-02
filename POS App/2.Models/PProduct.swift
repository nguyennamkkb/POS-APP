//
//  PProduct.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PProduct: Mappable {
    var id: String?
    var store_id: Int?
    var name: String?
    var price: Int?
    var image: String?
    var note: String?
    var point: Int?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        store_id <- map["store_id"]
        name <- map["name"]
        price <- map["price"]
        image <- map["image"]
        note <- map["note"]
        point <- map["point"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
    }
}
