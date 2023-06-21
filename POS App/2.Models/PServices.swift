//
//  PServices.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PServices: Mappable {
    var id: Int?
    var store_id: Int?
    var name: String?
    var price: Int?
    var note: String?
    var point: Int?
    var image: String?
    var status: Int?
    var createAt: String?
    var updateAt: String?
    var cksRequest: String?
    var timeRequest: Int?

    
    init (name: String, price: Int, point: Int, note: String){
        self.name = name
        self.price = price
        self.point = point
        self.note = note
        self.store_id = Common.userMaster.id
    }
    init (){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        store_id <- map["store_id"]
        name <- map["name"]
        price <- map["price"]
        note <- map["note"]
        point <- map["point"]
        image <- map["image"]
        status <- map["status"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
        
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
