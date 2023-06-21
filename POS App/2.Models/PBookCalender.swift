//
//  PBookCalender.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PBookCalender: Mappable {
    var id: Int?
    var store_id: Int?
    var start: String?
    var idEmployee: Int?
    var idCustomer: Int?
    var listService: String?
    var amount: Int?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    var employee: PEmployee?
    var customer: PCustomer?
    var cksRequest: String?
    var timeRequest: Int?
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        store_id <- map["store_id"]
        start <- map["start"]
        idEmployee <- map["idEmployee"]
        idCustomer <- map["idCustomer"]
        listService <- map["listService"]
        amount <- map["amount"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        customer <- map["customer"]
        employee <- map["employee"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
        
    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
