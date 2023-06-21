//
//  PStore.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PStore: Mappable {
    
    var id: Int?
    var storeName: String?
    var phone: String?
    var address: String?
    var bankCode: String?
    var accountNumber: String?
    var email: String?
    var password: String?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    var access_token: String?
    var cksRequest: String?
    var timeRequest: Int?
    
    
    
    init (){}
    
    init (phone: String){
        self.phone = phone
    }
    
    init (phone: String, password: String){
        self.phone = phone
        self.password = password
    }
    
    init (storeName: String,phone: String,address: String,email: String,password: String){
        self.storeName = storeName
        self.phone = phone
        self.address = address
        self.email = email
        self.password = password
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        storeName <- map["storeName"]
        phone <- map["phone"]
        address <- map["address"]
        bankCode <- map["bankCode"]
        accountNumber <- map["accountNumber"]
        email <- map["email"]
        password <- map["password"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        access_token <- map["access_token"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
