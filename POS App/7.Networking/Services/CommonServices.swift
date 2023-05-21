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
    static let storemains = ServiceManager.ROOT + "storemains"
    static let customers = ServiceManager.ROOT + "customers"
    
}

fileprivate enum ECommonURLs {
    case storemains
    case customers
    
    
    func getPath() -> String {
        switch self {
        case .storemains:
            return ListCommonService.storemains
        case .customers:
            return ListCommonService.customers
            
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
    
    
    func getStoreMain(param: String?, completion: @escaping (_ reponse: PStore?) -> Void) {
        let router = ECommonURLs.storemains.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if let result: String = result as? String {
                    if let baseResponse = Mapper<PStore>().mapArray(JSONString: result) {
                        completion(baseResponse.itemAtIndex(index: 0))
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
    
    func createCustomer(param: PStore, completion: @escaping (_ reponse: PCustomer?) -> Void) {
        let router = ECommonURLs.customers.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .post, parameter: param.toJSON()) { (success, result, error) in
            if success {
                if result != nil{
                    if let baseResponse = Mapper<PCustomer>().map(JSONObject: result) {
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
    func getAllCustomers(param: String?, completion: @escaping (_ reponse: [PCustomer]?) -> Void) {
        let router = ECommonURLs.storemains.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        
        BaseNetWorking.shared.requestData(fromURl: router, method: .get, parameter: nil) { (success, result, error) in
            if success {
                if let result: String = result as? String {
                    if let res = Mapper<PCustomer>().mapArray(JSONString: result) {
                        completion(res)
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

