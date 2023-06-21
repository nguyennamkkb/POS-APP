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
    var cksRequest: String?
    var timeRequest: Int?
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        phone <- map["phone"]
        password <- map["password"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
