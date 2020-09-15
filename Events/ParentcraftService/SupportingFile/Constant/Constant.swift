//
//  Constant.swift
//  ParentCraftVendor
//
//  Created by admin on 20/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

import UIKit




class Constant {
    
    
    
    static let DEVICE_ID               = UIDevice.current.identifierForVendor!.uuidString
    
    static let FONTNAME: NSString      = ""
    
    static let FONTNAME_BOLD: NSString = ""
    
    static let OFFLINE_MESSAGE = "The Internet connection appears to be offline"
    
    static let FEATURE_MESSAGE = "Login to use this feature"
    
    static let SCREEN_WIDTH            = UIScreen.main.bounds.size.width
    
    static let SCREEN_HEIGHT           = UIScreen.main.bounds.size.height
    
    static let appDelegate             = UIApplication.shared.delegate as? AppDelegate
    
    
}
