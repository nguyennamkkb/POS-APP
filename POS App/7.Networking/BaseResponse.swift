//
//  BaseResponse.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation

import ObjectMapper

class BaseResponse: Mappable {
    var statusCode: Int?
    var message: String?
    var data: Any?
    var meta: Meta?
    
    init() {
        
    }

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        statusCode <- map["statusCode"]
        message <- map["message"]
        data <- map["data"]
        meta <- map["meta"]

    }

}

class Meta: Mappable {
    var totalCount: Int?
    var currentPage: Int?
    var totalPages: Int?
    
    init() {
        
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        totalCount <- map["totalCount"]
        currentPage <- map["currentPage"]
        totalPages <- map["totalPages"]
        
    }
    
}
