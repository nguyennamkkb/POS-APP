//
//  ParamSearchBook.swift
//  POS App
//
//  Created by namnl on 02/07/2023.
//

import Foundation
import ObjectMapper


class ParamSearchBook: Mappable {
    var store_id: Int?
    var status: Int?
    var idCustomer: Int?
    var idEmployee: Int?
    var from: Int64?
    var to: Int64?
    var cksRequest: String?
    var timeRequest: Int?
    
    init(){}
    
    
    init(store_id: Int, status: Int? = nil, from: Int64? = nil,to: Int64? = nil, idCustomer: Int? = nil, idEmployee: Int? = nil){
        let mili = Common.getMilisecondNow()
        self.store_id  = store_id
        self.status = status
        self.from = from
        self.to = to
        self.idCustomer = idCustomer
        self.idEmployee = idEmployee
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }

    func mapping(map: ObjectMapper.Map) {
        store_id <- map["store_id"]
        status <- map["status"]
        idCustomer <- map["idCustomer"]
        idEmployee <- map["idEmployee"]
        from <- map["from"]
        to <- map["to"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]
    }
}
