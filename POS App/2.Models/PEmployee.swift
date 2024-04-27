//
//  PEmployee.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PEmployee: Mappable {
    var id: Int?
    var store_id: Int?
    var fullName: String?
    var phone: String?
    var address: String?
    var birthday: String?
    var gender: Int?
    var image: String?
    var type: Int64?
    var luotKhach: Int?
    var keySearch: String?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    var cksRequest: String?
    var timeRequest: Int?
    
    init (){
        
        sign()
    }
    init (store_id: Int, fullName: String,  phone: String, address: String, birthday: String, gender: Int ){
        self.store_id = store_id
        self.fullName = fullName
        self.phone = phone
        self.address = address
        self.birthday = birthday
        self.gender = gender
        sign()
    }
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
        image <- map["image"]
        type <- map["type"]
        luotKhach <- map["luotKhach"]

        keySearch <- map["keySearch"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
        
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
