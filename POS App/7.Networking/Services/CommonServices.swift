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
    static let login = ServiceManager.ROOT + "vmbank/services/account/requestComand"
    
}

fileprivate enum ECommonURLs {
    case login
    
    
    func getPath() -> String {
        switch self {
        case .login:
            return ListCommonService.login
            
        }
        
        
        func getMethod() -> HTTPMethod {
            switch self {
            default:
                return.post
            }
        }
    }
}



class CommonServices {
    
    
    func getLoginInfoV(param: LoginParam?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.login
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        
        BaseNetWorking.shared.requestData(fromURl: router.getPath(), method: .get, parameter: param?.toJSON()) { (success, result, error) in
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
}

