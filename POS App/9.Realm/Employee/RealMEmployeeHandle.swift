//
//  RealMEmployeeHandle.swift
//  POS App
//
//  Created by namnl on 13/05/2023.
//

import Foundation

import RealmSwift

class RealMEmployeeHandle {
    public static let share = RealMEmployeeHandle()
    let realm = try! Realm()
    func saveData(fullName: String, phone: String) {
        let data = REmployee()
        data.fullName = fullName
        data.phone = phone
        try! realm.write {
            realm.add(data)
        }
    }
    func getData(){
        let list = realm.objects(REmployee.self)
        print(list)
    }
}
