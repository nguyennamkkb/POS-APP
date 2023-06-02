//
//  ServiceManager.swift
//  QRYTe
//
//  Created by nguyen tam on 8/26/19.
//  Copyright © 2019 VuNM. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
    static let ROOT = "http://14.225.254.151:3456/pos-api/"
    public static let common = CommonServices()
    
    public static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

//protocol Output {
//    func isSuccess(result: BaseResponse, key: String)
//    func isFail(type: String)
//}


