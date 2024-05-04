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
    static let user = ServiceManager.ROOT + "user"
    static let checkuser = ServiceManager.ROOT + "user/checkuser"
    static let sendOtpFogotPassword = ServiceManager.ROOT + "user/sendOtpFogotPassword"
    static let verifyChangePassword = ServiceManager.ROOT + "user/verifyChangePassword"
    
    static let verify = ServiceManager.ROOT + "user/verify"
    static let customer = ServiceManager.ROOT + "customer"
    static let employee = ServiceManager.ROOT + "employee"
    static let auth = ServiceManager.ROOT + "auth/signin"
    static let book = ServiceManager.ROOT + "books"
    static let report = ServiceManager.ROOT + "books/report"
    static let bookinsuccess = ServiceManager.ROOT + "books/bookinsuccess"
    static let service = ServiceManager.ROOT + "products"
}

fileprivate enum ECommonURLs {
    case user
    case customers
    case auth
    case employee
    case book
    case service
    case checkuser
    case verify
    case report
    case bookinsuccess
    case sendOtpFogotPassword
    case verifyChangePassword
    
    
    func getPath() -> String {
        switch self {
        case .user:
            return ListCommonService.user
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
        case .checkuser:
            return ListCommonService.checkuser
        case .report:
            return ListCommonService.report
        case .bookinsuccess:
            return ListCommonService.bookinsuccess
            
            
        case .verify:
            return ListCommonService.verify
        case .sendOtpFogotPassword:
            return ListCommonService.sendOtpFogotPassword
            
        case .verifyChangePassword:
            return ListCommonService.verifyChangePassword
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
    
    
    func signIn(param: LoginParam?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
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
    
    func getUsers(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath() + (param ?? "")
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
    func checkUser(param: PStore?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.checkuser.getPath()
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
    //xac thuc nguoi dung voi otp
    func verifyUser(param: PStore?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.verify.getPath()
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
    
    func createUser(param: PStore, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath()
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
    func updateUser(param: PStore, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
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
    func deleteUser(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.user.getPath() + "/\(param)"
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
    func sendOtp(param: PStore?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.sendOtpFogotPassword.getPath()
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
    func verifyChangePassword(param: PStore?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.verifyChangePassword.getPath()
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
    func getoOneCustomer(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.customers.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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
    
    func updateCustomer(param: PCustomer, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.customers.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
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
    func deleteCustomer(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.customers.getPath() + "/\(param)"
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
    
    //Employee
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
    func getoOneEmployee(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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
    func getAllEmployees(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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
    
    func updateEmployee(param: PEmployee, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
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
    func deleteEmployee(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath() + "/\(param)"
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
    func getAllBookInSuccess(param: String?, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        
        
        let router = ECommonURLs.bookinsuccess.getPath() + (param ?? "")
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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
    func getoOneBook(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.book.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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
    
    func deleteBook(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
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
    func editBook(param: PBookCalender, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.book.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
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
    func getoOneServices(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.employee.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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
    func updateServices(param: PServices, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.service.getPath()
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
        BaseNetWorking.shared.requestData(fromURl: router, method: .put, parameter: param.toJSON()) { (success, result, error) in
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
    func deleteServices(param: Int, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.service.getPath() + "/\(param)"
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
    // bao cao, report
    func getReport(param: String, completion: @escaping (_ reponse: BaseResponse?) -> Void) {
        let router = ECommonURLs.report.getPath() + "/\(param)"
        if !ServiceManager.isConnectedToInternet() {
            completion(nil)
        }
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

