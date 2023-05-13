//
//  RMainUser.swift
//  POS App
//
//  Created by namnl on 13/05/2023.
//

import Foundation
import RealmSwift
import ObjectMapper
class RMainUser: Object,Mappable {
    
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var phone: String = ""
    @Persisted var password: String = ""
    convenience init(phone: String, password: String) {
        self.init()
        self.phone = phone
        self.password = password
    }
    
    func getJSON() -> [String: Any] {
            return ["phone": self.phone,"password": self.password]
    }
    required convenience init?(map: ObjectMapper.Map) {
            self.init()
        }
    
    func mapping(map: ObjectMapper.Map) {
        _id <- map["_id"]
        phone <- map["phone"]
        password <- map["password"]
    }
}

