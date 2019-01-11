//
//  MyPageMainModel.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/12/19.
//  Copyright © 2019 신동규. All rights reserved.
//


import Foundation
struct MyPageMainModel : Codable {
    let storeIdx : Int?
    let ownerName : String?
    let ownerImgUrl : String?
    let serviceCount : Int?
    let reviewCount : Int?
    let storeGrade : Int?
    let onOff : Int?
    let storeName : String?
    let address : String?
    let addressNumber : String?
    let openTime : Int?
    let closeTime : Int?
    let storeUrl : String?
    let storeCall : String?
    
    enum CodingKeys: String, CodingKey {
        
        case storeIdx = "storeIdx"
        case ownerName = "ownerName"
        case ownerImgUrl = "ownerImgUrl"
        case serviceCount = "serviceCount"
        case reviewCount = "reviewCount"
        case storeGrade = "storeGrade"
        case onOff = "onOff"
        case storeName = "storeName"
        case address = "address"
        case addressNumber = "addressNumber"
        case openTime = "openTime"
        case closeTime = "closeTime"
        case storeUrl = "storeUrl"
        case storeCall = "storeCall"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeIdx = try values.decodeIfPresent(Int.self, forKey: .storeIdx)
        ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
        ownerImgUrl = try values.decodeIfPresent(String.self, forKey: .ownerImgUrl)
        serviceCount = try values.decodeIfPresent(Int.self, forKey: .serviceCount)
        reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount)
        storeGrade = try values.decodeIfPresent(Int.self, forKey: .storeGrade)
        onOff = try values.decodeIfPresent(Int.self, forKey: .onOff)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addressNumber = try values.decodeIfPresent(String.self, forKey: .addressNumber)
        openTime = try values.decodeIfPresent(Int.self, forKey: .openTime)
        closeTime = try values.decodeIfPresent(Int.self, forKey: .closeTime)
        storeUrl = try values.decodeIfPresent(String.self, forKey: .storeUrl)
        storeCall = try values.decodeIfPresent(String.self, forKey: .storeCall)
    }
    
}
