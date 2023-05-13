//
//  REmployee.swift
//  POS App
//
//  Created by namnl on 13/05/2023.
//

import Foundation
import RealmSwift

class REmployee: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @objc dynamic var fullName: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var birthday: Int64 = 0
    @objc dynamic var gender: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var loyalty: Int64 = 0
    @objc dynamic var type: Int64 = 0
    @objc dynamic var bankCode: String = ""
    @objc dynamic var accountNumber: String = ""
    @objc dynamic var status: Int = 0
    @objc dynamic var timeCreate: Int64 = 0
   convenience init( fullName: String, phone: String, address: String, birthday: Int64, gender: Int, image: String, email: String, loyalty: Int64, type: Int64, bankCode: String, accountNumber: String, status: Int, timeCreate: Int64) {
        self.init()
        self.fullName = fullName
        self.phone = phone
        self.address = address
        self.birthday = birthday
        self.gender = gender
        self.image = image
        self.email = email
        self.loyalty = loyalty
        self.type = type
        self.bankCode = bankCode
        self.accountNumber = accountNumber
        self.status = status
        self.timeCreate = timeCreate
    }
}
