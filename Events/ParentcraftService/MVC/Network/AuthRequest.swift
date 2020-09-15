//
//  AuthRequest.swift
//  ExactMVC
//
//  Created by Souvikm on 01/11/18.
//  Copyright © 2018 nareshchoudhary. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum RestAPI {
    case login
    case approvedVerticalList
    case dashBoard
    case approvedServices
    case eventType
    case addEvent
    case eventList
    case eventDetails
    case eventSummary
    case payCoin
    
    
    
    static func service(for aServiceType: RestAPI) ->String {
        var path = ""
        switch aServiceType {
        case .login:
            path = "vendor/login"
            return URLConstatns.BaseUrl + path
            
            
        case .approvedVerticalList:
            path = "vendor/approved_verticle_listing"
            return URLConstatns.BaseUrl + path
            
            
            
        case .dashBoard:
            path = "vendor/vendor_dashboard"
            return URLConstatns.BaseUrl + path
            
            
        case .approvedServices:
            path = "Vendortype/approvedlistservice"
            return URLConstatns.BaseUrl + path
            
            
        case .eventType:
            path = "events/category"
            return URLConstatns.BaseUrl + path
        case .addEvent:
            path = "events"
            return URLConstatns.BaseUrl + path
            
        case .eventList:
            path = "events/manageevents"
            return URLConstatns.BaseUrl + path
            
        case .eventDetails:
            path = "events/details_admin"
            return URLConstatns.BaseUrl + path
            
            
            
        case .eventSummary:
            path = "events/summary"
            return URLConstatns.BaseUrl + path
            
            
        case .payCoin:
            path = "events/paynow"
            return URLConstatns.BaseUrl + path
            
            
            
        }
    }
    
}

enum APIServiceMethod {
    case post
    case postForm
    case get
    case put
    case delete
}

typealias APIServiceCompletionHandler = ((_ result: Any?, _ error: Error?) ->Void)

class APIService {
    static func perform(servideType aType: RestAPI,
                        method: APIServiceMethod,
                        params: [String: Any]?,
                        completion: @escaping APIServiceCompletionHandler) {
        let urlPath = RestAPI.service(for: aType)
        
        print(urlPath)
        guard let url = URL(string: urlPath) else {
            let error = NSError(domain: "apiservice.error", code: 991, userInfo: [NSLocalizedDescriptionKey: "Request url is invalid.", NSLocalizedFailureReasonErrorKey: "Invalid url path for '\(urlPath)' service type"])
            completion(nil, error)
            return
        }
        
        switch method {
        case .post:
            sendPostRequest(url: url, params: params, completion: completion)
        case .get:
            sendGetRequest(url: url, params: params, completion: completion)
        case .postForm:
            sendPostRequestWithHeader(url: url, params: params, completion: completion)
        default:
            break
        }
    }
    
    
    
    static func sendPostRequest(url: URL,
                                params: [String: Any]?,
                                completion: @escaping APIServiceCompletionHandler) {
        let key =  UserDefaults.standard.string(forKey: "key")
        if let value = key{
            
            // let headers = ["Content-Type": "Application/json", "Authorization": value]
            print(params as Any)
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "Application/json", "Authorization": value]).responseJSON { (response: DataResponse) in
                // Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                switch response.result{
                case .success(_):
                    //                let statusCode = response.response?.statusCode
                    //                print(statusCode)
                    completion(response.value, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
            }
        }else{
            // let headers = ["Content-Type": "Application/json"]
            print(params as Any)
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "Application/json"]).responseJSON { (response:DataResponse) in
                // Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                switch response.result{
                case .success(_):
                    //                let statusCode = response.response?.statusCode
                    //                print(statusCode)
                    completion(response.value, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
            }
        }
        
    }
    
    static func sendPostRequestWithHeader(url: URL,
                                          params: [String: Any]?,
                                          
                                          completion: @escaping APIServiceCompletionHandler) {
        
        //  let headers = ["Content-Type": "Application/json"]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: ["Content-Type": "Application/json"]).responseJSON { (response:DataResponse) in
            // Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch response.result{
            case .success(_):
                //                let statusCode = response.response?.statusCode
                //                print(statusCode)
                completion(response.value, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    
    static func sendGetRequest(url: URL,
                               params: [String: Any]?,
                               completion: @escaping APIServiceCompletionHandler) {
        
        let key =  UserDefaults.standard.string(forKey: "key")
        if let value = key{
            //let headers = ["Content-Type": "Application/json", "Authorization": value]
            print(params as Any)
            
            // Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers:  ["Content-Type": "Application/json", "Authorization": value]).responseJSON { (response:DataResponse) in
                switch response.result{
                case .success(_):
                    //                let statusCode = response.response?.statusCode
                    //                print(statusCode)
                    completion(response.value, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
            }
        }else{
            // let headers = ["Content-Type": "Application/json"]
            print(params as Any)
            //            Alamofire.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            AF.request(url, method: .post, encoding: JSONEncoding.default, headers: ["Content-Type": "Application/json"]).responseJSON { (response:DataResponse) in
                switch response.result{
                case .success(_):
                    //                let statusCode = response.response?.statusCode
                    //                print(statusCode)
                    completion(response.value, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
                }
            }
        }
    }
    
}
