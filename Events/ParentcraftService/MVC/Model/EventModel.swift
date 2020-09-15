//
//  EventModel.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 22/05/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct EventTypeData: Codable {
    let status, message: String?
    let id_event : Int?
    let result: [typeResult]?
}

// MARK: - Result
struct typeResult: Codable {
    let id, name, icon: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, icon
    }
}

// MARK: - EventListData
struct EventListData: Codable {
    let status, message: String?
    let data: [eventListResult]?
    let events : [eventListResult]?
    let result: [eventListResult]?
}

// MARK: - Datum
struct eventListResult: Codable {
    let vendorName, vendorMasterEmail, verticleName, verticleEmail: String?
    let verticleType, evevntCategory, id, idVendor: String?
    let vendorMasterVerticleID, catID, title, datumDescription: String?
    let date, time, duration, seatCapacity: String?
    let priceSeat, address, city, state: String?
    let lat, lon, webLink, status: String?
    let reason, added, updated, bannerPic,is_highlighted: String?
    let pic: [Pic]?
    let pay_status, cost,order_no,tax_percentage: String?
    let tax_amount,total_amount: Double?
    let pay_response,tracking_id,bank_ref_no,payment_mode,invoice_url : String?
    let durationmin, coin_count: Int?
    let coin_balance : String?
    enum CodingKeys: String, CodingKey {
        case vendorName = "vendor_name"
        case vendorMasterEmail = "vendor_master_email"
        case verticleName = "verticle_name"
        case verticleEmail = "verticle_email"
        case verticleType = "verticle_type"
        case evevntCategory = "evevnt_category"
        case id = "_id"
        case idVendor = "id_vendor"
        case vendorMasterVerticleID = "vendor_master_verticle_id"
        case catID = "cat_id"
        case title,is_highlighted
        case datumDescription = "description"
        case date, time, duration
        case seatCapacity = "seat_capacity"
        case priceSeat = "price_seat"
        case address, city, state, lat, lon
        case webLink = "web_link"
        case status, reason, added, updated
        case bannerPic = "banner_pic"
        case pic
        case pay_status,cost,order_no,tax_percentage,tax_amount,total_amount
        case pay_response,tracking_id,bank_ref_no,payment_mode,invoice_url
        case durationmin, coin_count,coin_balance
    }
}

// MARK: - Pic
struct Pic: Codable {
    let id, idEvent, pic, status: String?
    let updated: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case idEvent = "id_event"
        case pic, status, updated
    }
}


struct InterestedData: Codable {
    let status, message: String?
    let result: [interestResult]?
}

// MARK: - Result
struct interestResult: Codable {
    let fullName, mobile, email, pic: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case mobile, email, pic
    }
}

// MARK: - RatingListData
struct RatingListData: Codable {
    let status, message: String?
    let totalRating, avgRating: Double?
    let ratingpercentage: [Ratingpercentage]?
    let allReviews: [AllReview]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case totalRating = "total_rating"
        case avgRating = "avg_rating"
        case ratingpercentage
        case allReviews = "all_reviews"
    }
}

// MARK: - AllReview
struct AllReview: Codable {
    let id, idEvent, idCustomer, rating: String?
    let review, isActive, dateadded, fullName: String?
    let pic: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case idEvent = "id_event"
        case idCustomer = "id_customer"
        case rating, review
        case isActive = "is_active"
        case dateadded
        case fullName = "full_name"
        case pic
    }
}

// MARK: - Ratingpercentage
struct Ratingpercentage: Codable {
    let star: Int?
    let value: Double?
}


// MARK: - CoinData
struct CoinData: Codable {
    let coinBalance: String?
    let coin_count: Int?
    let status, message: String?
    let result: [coinResult]?

    enum CodingKeys: String, CodingKey {
        case coinBalance = "coin_balance"
        case status, message, result, coin_count
    }
}

// MARK: - Result
struct coinResult: Codable {
    let id, coinValue, price, sortOrder: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case coinValue = "coin_value"
        case price
        case sortOrder = "sort_order"
    }
}

// MARK: - payment summary
struct PaymentSummary: Codable {
   
    let status, message: String?
    let result: [summaryResult]?

    enum CodingKeys: String, CodingKey {
        
        case status, message, result
    }
}

// MARK: - Result
struct summaryResult: Codable {
    let type, coin, message, added: String?

    enum CodingKeys: String, CodingKey {
        case type, coin, message, added
        
       
    }
}

