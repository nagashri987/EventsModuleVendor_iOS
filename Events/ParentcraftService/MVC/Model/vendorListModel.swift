//
//  vendorListModel.swift
//  ParentCraftVendor
//
//  Created by admin on 03/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
struct vendorListData: Codable {
    let status, message: String?
    let result: [listResult]?
}

// MARK: - Result
struct listResult: Codable {
    let id, name, pic, isTabView: String?
    let tabCount, resultDescription, updated: String?
    let count:Int?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, pic
        case isTabView = "is_tab_view"
        case tabCount = "tab_count"
        case resultDescription = "description"
        case updated, count
    }
}

struct verticalListDAta: Codable {
    let status, message, typeName, vendorEmail: String?
    let result: [verticalResult]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case typeName = "type_name"
        case vendorEmail = "vendor_email"
        case result
    }
}

// MARK: - Result
struct verticalResult: Codable {
    let id, profilePhoto, name, verticleType: String?
    let experience, timingFrom, timingTo, fees: String?
    let address, contactNumber, specificAddress, email: String?
    let website, welcomeDescription, uploadCertificates, gender: String?
    let vendorTypeid, status: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case profilePhoto = "profile_photo"
        case name
        case verticleType = "verticle_type"
        case experience
        case timingFrom = "timing_from"
        case timingTo = "timing_to"
        case fees, address
        case contactNumber = "contact_number"
        case specificAddress = "specific_address"
        case email, website
        case welcomeDescription = "description"
        case uploadCertificates = "upload__certificates"
        case gender
        case vendorTypeid = "vendor_typeid"
        case status
    }
}





