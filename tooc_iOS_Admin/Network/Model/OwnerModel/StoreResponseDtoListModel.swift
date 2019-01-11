//
//  StoreResponseDtoListModel.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct StoreResponseDtoList : Codable {
    let bagDtos : [BagDtos]?
    let endTime : Int?
    let price : Int?
    let progressType : String?
    let reserveIdx : Int?
    let startTime : Int?
    let stateType : String?
    let userIdx : Int?
    let userImg : String?
    let userName : String?
    
    enum CodingKeys: String, CodingKey {
        case bagDtos = "bagDtos"
        case endTime = "endTime"
        case price = "price"
        case progressType = "progressType"
        case reserveIdx = "reserveIdx"
        case startTime = "startTime"
        case stateType = "stateType"
        case userIdx = "userIdx"
        case userImg = "userImg"
        case userName = "userName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bagDtos = try values.decodeIfPresent([BagDtos].self, forKey: .bagDtos)
        endTime = try values.decodeIfPresent(Int.self, forKey: .endTime)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        progressType = try values.decodeIfPresent(String.self, forKey: .progressType)
        reserveIdx = try values.decodeIfPresent(Int.self, forKey: .reserveIdx)
        startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
        stateType = try values.decodeIfPresent(String.self, forKey: .stateType)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        userImg = try values.decodeIfPresent(String.self, forKey: .userImg)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
}
