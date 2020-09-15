//
//  SignUpModel.swift
//  ParentCraftVendor
//
//  Created by admin on 02/07/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
struct SignUpData: Codable {
    let status, message: String?
    let key: String?
    let code: String?
    let vendor_master_verticle_id: String?
    let result: [sResult]?
}

// MARK: - Result
struct sResult: Codable {
    let id, fullName, dob, gender: String?
    let mobile, email, otp, verified, pic : String?
    let otpAttempt, age, state, city: String?
    let lat, lon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "full_name"
        case dob, gender, mobile, email, otp, verified
        case otpAttempt = "otp_attempt"
        case age, state, city, lat, lon, pic
    }
}

struct OTPResend: Codable {
    let code: String?
    let status, message: String?
}

struct BannerData: Codable {
    let status, message: String?
   
    let result: [BannerList]?
}

struct BannerList: Codable {
    let id, pic, updated: String?
}
  
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case pic, updated
    
    }

