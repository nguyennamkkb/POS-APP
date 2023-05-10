//
//  HandleEmployee.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation

class HandleEmployee {
   
    class HandleEmployee {
        public static let share = HandleEmployee()
        public func SortData(data: [PEmployee]?) -> [PEmployee]? {
            var dataFilter = [PEmployee]()
            guard let data = data else {return dataFilter}
            if data.count > 1 {
                dataFilter = data.sorted{ $0.timeCreate ?? 0 < $1.timeCreate ?? 0 }
            }else{
                return data
            }
            return dataFilter
        }
        
        public func findById(data: [PEmployee], id: String) -> PEmployee? {
            var dataFilter: PEmployee?
            if data.count > 0 {
                if let object = data.first(where: { $0.id == id }) {
                    dataFilter = object
                } else {
                }
            }
            return dataFilter
        }
        public func findByName(data: [PEmployee], name: String) -> [PEmployee]? {
            var dataFilter: [PEmployee]?
            if data.count > 0 {
                dataFilter = data.filter{ $0.fullName!.uppercased().contains(name.uppercased()) }
                if dataFilter!.isEmpty {
                    dataFilter = SortData(data: dataFilter)
                }
            }
            return dataFilter
        }
        
    }
}
