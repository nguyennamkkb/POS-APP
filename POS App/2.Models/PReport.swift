//
//  PReport.swift
//  POS App
//
//  Created by namnl on 29/07/2023.
//

import Foundation
import ObjectMapper

class PReport: Mappable {
    var chartDay: [ChartDay]?
    var totalBook: TotalBook?
    var listEmplEach: [ListEmplEach]?
   
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        chartDay <- map["chartDay"]
        totalBook <- map["totalBook"]
        listEmplEach <- map["listEmplEach"]
     
    }
}

class ChartDay: Mappable {
    var date: String?
    var money: Int?
    var recordsCount: Int?
   
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
        }
        
    func mapping(map: ObjectMapper.Map) {
        date <- map["date"]
        money <- map["money"]
        recordsCount <- map["recordsCount"]
     
    }
}

class TotalBook: Mappable {
    var money: Int?
    var book: Int?
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        money <- map["money"]
        book <- map["book"]
    }
}


class ListEmplEach: Mappable {
    var idEmployee: Int?
    var name: String?
    var totalMoney: Int?
    var tolalBook: Int?

    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        idEmployee <- map["idEmployee"]
        name <- map["name"]
        totalMoney <- map["totalMoney"]
        tolalBook <- map["tolalBook"]
    }
}

