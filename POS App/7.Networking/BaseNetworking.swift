//
//  BaseNetworking.swift
//  QRYTe
//
//  Created by nguyen tam on 8/26/19.
//  Copyright © 2019 VuNM. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias NetworkingCompletionBlock = (_ success: Bool, _ result: Any?, _ error: Error?) -> Void

class BaseNetWorking {
    
    static let shared: BaseNetWorking = BaseNetWorking()
    
    static func getHeaderFields() -> HTTPHeaders {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(Common.userMaster.access_token ?? "")"
        return headers
    }
    
    func requestData(fromURl: String?, method: HTTPMethod, parameter: Dictionary<String, Any>?, completion: NetworkingCompletionBlock?) {
        do {
            var originalRequest = try URLRequest(url: fromURl ?? "" , method: method, headers: BaseNetWorking.getHeaderFields())
            originalRequest.timeoutInterval = 20
            let encoding : ParameterEncoding = JSONEncoding.default
            let encodeURLRequest = try encoding.encode(originalRequest, with: parameter)
            Alamofire.request(encodeURLRequest).responseString { (response) in
                if let error = response.error {
                    completion?(false,response.result.value, error)
                }else {
                    if response.value != nil {
                        do {
                            let data = Data((response.result.value ?? "").utf8)
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(json)
                                #endif
                                    completion?(true,json, response.error)
                            } else {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(response.result.value ?? "")
                                #endif
                                let str: String = response.result.value ?? ""
                                completion?(true,str,response.error)
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                            // new
//                            if UIApplication.topViewController() is BaseViewController {
//                                let view = UIApplication.topViewController() as! BaseViewController
//                                view.showAlert(type: .error, msg: "Có lỗi xảy ra, vui lòng thử lại sau")
//                            }
                            completion?(false,nil,nil)
                        }
                    }else{
                        completion?(false,nil,nil)
                    }
                }
            }
            
        }catch {
            completion?(false,nil,nil)
        }
    }
    
    func requestDataLong(fromURl: String?, method: HTTPMethod, parameter: Dictionary<String, Any>?, completion: NetworkingCompletionBlock?) {
        do {
            var originalRequest = try URLRequest(url: fromURl ?? "" , method: method, headers: BaseNetWorking.getHeaderFields())
            originalRequest.timeoutInterval = 100
            
            let encoding : ParameterEncoding = JSONEncoding.default
            let encodeURLRequest = try encoding.encode(originalRequest, with: parameter)
            Alamofire.request(encodeURLRequest).responseString { (response) in
                if let error = response.error {
                    completion?(false,response.result.value, error)
                }else {
                    if response.value != nil {
                        do {
                            let data = Data((response.result.value ?? "").utf8)
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(json)
                                #endif
                                    completion?(true,json, response.error)
                            } else {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(response.result.value ?? "")
                                #endif
                                let str: String = response.result.value ?? ""
                                completion?(true,str,response.error)
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                    }else{
                        completion?(false,nil,nil)
                    }
                }
            }
            
        }catch {
            completion?(false,nil,nil)
        }
    }
    
    func requestDataAAAA(fromURl: String?, method: HTTPMethod, parameter: Dictionary<String, Any>?, completion: NetworkingCompletionBlock?) {
        do {
            var originalRequest = try URLRequest(url: fromURl ?? "" , method: method, headers: BaseNetWorking.getHeaderFields())
            originalRequest.timeoutInterval = 20
            
            let encoding : ParameterEncoding = JSONEncoding.default
            let encodeURLRequest = try encoding.encode(originalRequest, with: parameter)
            Alamofire.request(encodeURLRequest).responseString { (response) in
                if let error = response.error {
                    completion?(false,response.result.value, error)
                }else {
                    if response.value != nil {
                        do {
                            let data = Data((response.result.value ?? "").utf8)
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(json)
                                #endif
                                    completion?(true,json, response.error)
                            } else {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(response.result.value ?? "")
                                #endif
                                let str: String = response.result.value ?? ""
                                completion?(true,str,response.error)
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                            completion?(false,nil,nil)
                        }
                    }else{
                        completion?(false,nil,nil)
                    }
                }
            }
            
        }catch {
            completion?(false,nil,nil)
        }
    }
    
    
    func requestData(_ timeOut: Int?,fromURl: String?, method: HTTPMethod, parameter: Dictionary<String, Any>?, completion: NetworkingCompletionBlock?) {
        do {
            var originalRequest = try URLRequest(url: fromURl ?? "" , method: method, headers: BaseNetWorking.getHeaderFields())
            originalRequest.timeoutInterval = TimeInterval(timeOut ?? 20)
            
            let encoding : ParameterEncoding = JSONEncoding.default
            let encodeURLRequest = try encoding.encode(originalRequest, with: parameter)
            Alamofire.request(encodeURLRequest).responseString { (response) in
                if let error = response.error {
                    completion?(false,response.result.value, error)
                }else {
                    if response.value != nil {
                        do {
                            let data = Data((response.result.value ?? "").utf8)
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(json)
                                #endif
                                    completion?(true,json, response.error)
                            } else {
                                #if DEBUG
                                    print(fromURl ?? "url sai/rong")
                                    print(parameter ?? "khong co")
                                    print(response.result.value ?? "")
                                #endif
                                let str: String = response.result.value ?? ""
                                completion?(true,str,response.error)
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                            completion?(false,nil,nil)
                        
                        }
                    }else{
                        completion?(false,nil,nil)
                    }
                }
            }
            
        }catch {
            completion?(false,nil,nil)
        }
    }
    
}
