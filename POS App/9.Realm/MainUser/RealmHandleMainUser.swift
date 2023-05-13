//
//  RealmHandleMainUser.swift
//  POS App
//
//  Created by namnl on 13/05/2023.
//

import Foundation
import RealmSwift
import ObjectMapper
class RealmHandleMainUser {
    public static let share = RealmHandleMainUser()
    public var data = [RMainUser]()
    let realm = try! Realm()
    func saveData(phone: String, password: String) {
        let data = RMainUser()
        data.phone = phone
        data.password = password
        try! realm.write {
            realm.add(data)
        }
    }
    func saveDataFromArray(data:  [RMainUser]) {
//        let data = json.data(using: .utf8)!
//        print(data)
        try! realm.write {
//            let json = try! JSONSerialization.jsonObject(with: json, options: [])
            realm.add(data)
        }
    }
    func getAllData() -> [RMainUser]?{
        let list = realm.objects(RMainUser.self)
        for item in list {
            if let t = Mapper<RMainUser>().map(JSON: item.getJSON()) {
                data.append(t)
            }
        }
        return data
    }
    func findById(id: String) -> RMainUser{
        var res:RMainUser = RMainUser()
        let item = realm.objects(RMainUser.self).filter("id == %@", id).first
        guard let item = item else {return res}
        if let t = Mapper<RMainUser>().map(JSON: item.getJSON()) {
            res = t
        }
        return res
    }
    func findData(param: MainUser) -> [RMainUser]?{
        var res:[RMainUser] = [RMainUser]()
        var list = realm.objects(RMainUser.self)
        if let phone = param.phone  {
            list = list.filter("phone CONTAINS '\(phone)'")
        }
        if let password = param.password  {
            list = list.filter("password CONTAINS '\(password)'")
        }
        for item in list {
            if let t = Mapper<RMainUser>().map(JSON: item.getJSON()) {
                res.append(t)
            }
        }
        return res
    }
    
}
