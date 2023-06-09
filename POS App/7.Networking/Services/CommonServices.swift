//
//  CommonService.swift
//  QRYTe
//
//  Created by nguyen tam on 8/26/19.
//  Copyright © 2019 VuNM. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

fileprivate class ListCommonService {
    
    // account
    static let storemains = ServiceManager.ROOT + "main-store"
    static let customer = ServiceManager.ROOT + "customer"
    static let employee = ServiceManager.ROOT + "employee"
    static let auth = ServiceManager.ROOT + "auth"
    static let book = ServiceManager.ROOT + "books"
    static let service = ServiceManager.ROOT + "products"
}

fileprivate enum ECommonURLs {
    case storemains
    case customers
    case auth
    case employee
    case book
    case service
    
    
    func getPath() -> String {
        switch self {
        case .storemains:
            return ListCommonService.storemains
        case .customers:
            return ListCommonService.customer
        case .auth:
            return ListCommonService.auth
        case .employee:
            return ListCommonService.employee
        case .book:
            return ListCommonService.book
        case .service:
            return ListCommonService.service
            
        }
        func getMethod() -> HTTPMethod {
            switch self {
                
            default:
                return.get
            }
        }
    }
}



class CommonServices {
    
    
    func login(param: LoginParam?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.auth.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param?.toJSON()) { (success, result, error) in
            if success {
                if result != nil {
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }

    func getStoreMain(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.storemains.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil {
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func createStoreMain(param: PStore, completion: @escaping (_ reponse: PStore?) -> Void) {
        let router = ECommonURLs.storemains.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<PStore>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // customer
    func createCustomer(param: PCustomer, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.customers.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func getAllCustomers(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.customers.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        print(router)
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    //employee
    func createEmployee(param: PEmployee, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func getAllEmployees(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        print(router)
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    //book
    func createBook(param: PBookCalender, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.book.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func getAllBooks(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.book.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        print(router)
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func deleteBook(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.book.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        print(router)
        BaseNetWorking.shared.requestData(fromURl: router, method: .delete, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    //services
    
    func createService(param: PServices, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.service.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func getAllServices(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.service.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        print(router)
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<BaseResponse>().map(JSONObject: result) {
                        completion(baseResponse)
                    }
                }else{
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}

