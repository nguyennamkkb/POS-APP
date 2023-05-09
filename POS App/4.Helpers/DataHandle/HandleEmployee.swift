//
//  HandleEmployee.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation

class HandleEmployee {
   
    public func SortData(data: [PEmployee]?) -> [PEmployee]? {
        var dataFilter = [PEmployee]()
        guard let data = data else {return dataFilter}
        if data.count > 1 {
            dataFilter = data.sorted{ $0.timeCreate ?? 1 > $1.timeCreate ?? 0 }
        }
        return dataFilter
    }
    
    public func findById(data: [PEmployee], id: String) -> PEmployee? {
        var dataFilter: PEmployee?
        if data.count > 0 {
            dataFilter = data.first{$0.id == id}
        }
        return dataFilter
    }
//    public func findByName(data: [PEmployee], name: String) -> [PEmployee]? {
//        var dataFilter: [PEmployee]?
//        if data.count > 0 {
//            dataFilter = data.filter{ $0.fullName?.contains(name) ?? false }
//            if !dataFilter.isEmpty {
//                dataFilter = SortData(data: dataFilter)
//            }
//            
//            
//        }
//        return dataFilter
//    }
}
