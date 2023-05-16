//
//  CacheManager.swift
//  POS App
//
//  Created by namnl on 09/05/2023.
//

import Foundation


class CacheManager {
    public static let share = CacheManager()
    let defaults = UserDefaults.standard
    func isRegister() -> Bool {
        return defaults.bool(forKey: KeyCommon.shared.isRegister)
    }
    func setRegister(_ value: Bool) {
        return defaults.setValue(value, forKey: KeyCommon.shared.isRegister)
    }
    
    func getUserMaster() -> String {
        return defaults.string(forKey: KeyCommon.shared.userMaster) ?? ""
    }
    func setUserMaster(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.userMaster)
    }
    //dataStores
    func getDataStores() -> String {
        return defaults.string(forKey: KeyCommon.shared.dataStores) ?? ""
    }
    func setDataStores(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.dataStores)
    }
    
    //dataCustomers
    func getDataCustomers() -> String {
        return defaults.string(forKey: KeyCommon.shared.dataCustomers) ?? ""
    }
    func setDataCustomers(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.dataCustomers)
    }
    
    //dataEmployees
    func getDataEmployees() -> String {
        return defaults.string(forKey: KeyCommon.shared.dataEmployees) ?? ""
    }
    func setDataEmployees(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.dataEmployees)
    }
    
    
    //dataBooks
    func getDataBooks() -> String {
        return defaults.string(forKey: KeyCommon.shared.dataBooks) ?? ""
    }
    func setDataBooks(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.dataBooks)
    }
    
    //dataProducts
    func getDataProducts() -> String {
        return defaults.string(forKey: KeyCommon.shared.dataProducts) ?? ""
    }
    func setDataProducts(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.dataProducts)
    }
    
    //dataServicess
    func getDataServicess() -> String {
        return defaults.string(forKey: KeyCommon.shared.dataServicess) ?? ""
    }
    func setDataServicess(value: String?) {
        return defaults.setValue(value ?? "", forKey: KeyCommon.shared.dataServicess)
    }
    
}
