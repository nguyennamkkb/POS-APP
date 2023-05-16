//
//  PBookCalender.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation
import ObjectMapper

class PBookCalender: Mappable {
    var id: String?
    var timeStart: String?
    var idEmployee: String?
    var idCustomer: String?
    var listService: String?
    var timeExecution: String?
    var createAt: Int64?
    var updateAt: Int64?
    var status: Int?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        timeStart <- map["timeStart"]
        idEmployee <- map["idEmployee"]
        idCustomer <- map["idCustomer"]
        listService <- map["listService"]
        timeExecution <- map["timeExecution"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
    }
}
