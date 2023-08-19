//
//  Params.swift
//  QRYTe
//
//  Created by nguyen tam on 8/27/19.
//  Copyright © 2019 VuNM. All rights reserved.
//

import Foundation
import ObjectMapper


class LoginParam: Mappable {
    var phone: String?
    var password: String?
    
    init(){}
    init(phone: String){
        self.phone  = phone
    }
    
    init(phone: String, password: String){
        self.phone  = phone
        self.password = password
    }
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }

    func mapping(map: ObjectMapper.Map) {
        phone <- map["phone"]
        password <- map["password"]
    }
    
}
