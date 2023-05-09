//
//  MainUser.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class MainUser: Mappable {

    var phone: String?
    var password: String?
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        phone <- map["phone"]
        password <- map["password"]
    }
}
