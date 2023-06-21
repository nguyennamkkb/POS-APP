//
//  ParamSearch.swift
//  POS App
//
//  Created by namnl on 22/06/2023.
//

import Foundation
import ObjectMapper


class ParamSearch: Mappable {
    var store_id: Int?
    var status: Int?
    var keySearch: String?
    var name: String?
    var cksRequest: String?
    var timeRequest: Int?
    
    init(){}
    
    
    init(store_id: Int, status: Int, keySearch: String? = nil, name: String? = nil){
        let mili = Common.getMilisecondNow()
        self.store_id  = store_id
        self.status = status
        self.keySearch = keySearch
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }

    func mapping(map: ObjectMapper.Map) {
        store_id <- map["store_id"]
        status <- map["status"]
        keySearch <- map["keySearch"]
        name <- map["name"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
    }
}
