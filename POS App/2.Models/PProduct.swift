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
    var name: String?
    var sku: Int64?
    var priceExport: Double?
    var priceImport: Double?
    var image: String?
    var note: String?
    var code: String?
    var status: Int?
    var timeCreate: Int64?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        sku <- map["sku"]
        priceExport <- map["priceExport"]
        priceImport <- map["priceImport"]
        image <- map["image"]
        note <- map["note"]
        code <- map["code"]
        timeCreate <- map["timeCreate"]
        status <- map["status"]
    }
}
