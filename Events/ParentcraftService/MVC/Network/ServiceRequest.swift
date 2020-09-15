//
//  ServiceRequest.swift
//  ChatModule
//
//  Created by Souvik on 2/20/19.
//  Copyright © 2019 Souvik. All rights reserved.
//

import Foundation
import Alamofire

class ParentCraft_API_SERVICE: APIService {
    
    
   

    //MARK: - login
    static func postLoginData(params:[String: AnyObject]?,
                              completion: @escaping (_ result: SignUpData?, _ error: Error?) -> Void) {
        perform(servideType: .login, method: .post, params: params) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(SignUpData.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
    
    
    
    //MARK: - Vendor List
       static func approvedVendorListData(params:[String: AnyObject]?,
                                      completion: @escaping (_ result: vendorListData?, _ error: Error?) -> Void) {
           perform(servideType: .approvedServices, method: .post, params: params) { (result, error) in
               if let lError = error {
                   completion(nil, lError)
                   return
               }
               
               if let lResult = result{
                   print(lResult)
                   do{
                       let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                       let decoded = try JSONDecoder().decode(vendorListData.self, from: jsonData)
                       completion(decoded, nil)
                   }catch let encodeError{
                       print(encodeError)
                       completion(nil, encodeError)
                   }
               }
           }
           
       }
    
    
   
    
    // approveed Vendor Vertical List
    static func postApprovedVerticalListData(params:[String: AnyObject]?,
                                             completion: @escaping (_ result: verticalListDAta?, _ error: Error?) -> Void) {
        perform(servideType: .approvedVerticalList, method: .post, params: params) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(verticalListDAta.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
  
    //MARK: - Dashboard
    static func getDashBoardData(params:[String: AnyObject]?,
                                 completion: @escaping (_ result: dashboardData?, _ error: Error?) -> Void) {
        perform(servideType: .dashBoard, method: .post, params: params) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(dashboardData.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
   
    //MARK:- Event type
    static func getEventType(params:[String: AnyObject]?,
                            completion: @escaping (_ result: EventTypeData?, _ error: Error?) -> Void) {
        perform(servideType: .eventType, method: .get, params: nil) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(EventTypeData.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
    
     //MARK:- Add Event
    static func addEvent(params:[String: AnyObject]?,
                            completion: @escaping (_ result: EventTypeData?, _ error: Error?) -> Void) {
        perform(servideType: .addEvent, method: .post, params: params) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(EventTypeData.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
    
    //MARK:- Event list
    static func postEventList(params:[String: AnyObject]?,
                            completion: @escaping (_ result: EventListData?, _ error: Error?) -> Void) {
        perform(servideType: .eventList, method: .post, params: params) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(EventListData.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
    
    //MARK:- Event Details
    static func postEventDetails(params:[String: AnyObject]?,
                            completion: @escaping (_ result: EventListData?, _ error: Error?) -> Void) {
        perform(servideType: .eventDetails, method: .post, params: params) { (result, error) in
            if let lError = error {
                completion(nil, lError)
                return
            }
            
            if let lResult = result{
                print(lResult)
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoded = try JSONDecoder().decode(EventListData.self, from: jsonData)
                    completion(decoded, nil)
                }catch let encodeError{
                    print(encodeError)
                    completion(nil, encodeError)
                }
            }
        }
        
    }
    
    
   //MARK:- summary
    static func eventSummaryData(params:[String: AnyObject]?,
                                    completion: @escaping (_ result: EventListData?, _ error: Error?) -> Void) {
                perform(servideType: .eventSummary, method: .post, params: params) { (result, error) in
                    if let lError = error {
                        completion(nil, lError)
                        return
                    }
                    
                    if let lResult = result{
                        print(lResult)
                        do{
                            let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoded = try JSONDecoder().decode(EventListData.self, from: jsonData)
                            completion(decoded, nil)
                        }catch let encodeError{
                            print(encodeError)
                            completion(nil, encodeError)
                        }
                    }
                }
                
            }
    
    
    
    
     //MARK:- Payment
    static func payCoinData(params:[String: AnyObject]?,
                                       completion: @escaping (_ result: CoinData?, _ error: Error?) -> Void) {
                   perform(servideType: .payCoin, method: .post, params: params) { (result, error) in
                       if let lError = error {
                           completion(nil, lError)
                           return
                       }
                       
                       if let lResult = result{
                           print(lResult)
                           do{
                               let jsonData = try JSONSerialization.data(withJSONObject: lResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                               let decoded = try JSONDecoder().decode(CoinData.self, from: jsonData)
                               completion(decoded, nil)
                           }catch let encodeError{
                               print(encodeError)
                               completion(nil, encodeError)
                           }
                       }
                   }
                   
               }
    
   
}
