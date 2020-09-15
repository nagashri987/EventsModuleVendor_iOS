//
//  dashBoardModel.swift
//  ParentCraftVendor
//
//  Created by admin on 23/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
// MARK: - DashBoard
struct dashboardData: Codable {
    let status, message: String?
    let pro_status, vendor_approved:String?
   
    let result: [dashBoardResult]?
}


struct dashBoardResult: Codable {
    let id, name, icon, position: String?
    let isActive, icon_gray: String?
    let Notificationcount : Int?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, icon, position, icon_gray
        case isActive = "is_active"
        case Notificationcount = "count"
    }
}




