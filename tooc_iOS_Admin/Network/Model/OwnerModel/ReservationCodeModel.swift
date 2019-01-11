//
//  ReservationCodeModel.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct ReservationCodeModel: Codable {
    let bagDtoList : [BagDtoList]?
    let bagImgDtos : [BagImgDtos]?
    let depositTime : Int?
    let endTime : Int?
    let overTime : Int?
    let payType : String?
    let price : Int?
    let progressType : String?
    let reserveIdx : Int?
    let startTime : Int?
    let stateType : String?
    let takeTime : Int?
    let userIdx : Int?
    let userImgUrl : String?
    let userName : String?
    let userPhone : String?
    
    enum CodingKeys: String, CodingKey {
        
        case bagDtoList = "bagDtoList"
        case bagImgDtos = "bagImgDtos"
        case depositTime = "depositTime"
        case endTime = "endTime"
        case overTime = "overTime"
        case payType = "payType"
        case price = "price"
        case progressType = "progressType"
        case reserveIdx = "reserveIdx"
        case startTime = "startTime"
        case stateType = "stateType"
        case takeTime = "takeTime"
        case userIdx = "userIdx"
        case userImgUrl = "userImgUrl"
        case userName = "userName"
        case userPhone = "userPhone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bagDtoList = try values.decodeIfPresent([BagDtoList].self, forKey: .bagDtoList)
        bagImgDtos = try values.decodeIfPresent([BagImgDtos].self, forKey: .bagImgDtos)
        depositTime = try values.decodeIfPresent(Int.self, forKey: .depositTime)
        endTime = try values.decodeIfPresent(Int.self, forKey: .endTime)
        overTime = try values.decodeIfPresent(Int.self, forKey: .overTime)
        payType = try values.decodeIfPresent(String.self, forKey: .payType)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        progressType = try values.decodeIfPresent(String.self, forKey: .progressType)
        reserveIdx = try values.decodeIfPresent(Int.self, forKey: .reserveIdx)
        startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
        stateType = try values.decodeIfPresent(String.self, forKey: .stateType)
        takeTime = try values.decodeIfPresent(Int.self, forKey: .takeTime)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        userImgUrl = try values.decodeIfPresent(String.self, forKey: .userImgUrl)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        userPhone = try values.decodeIfPresent(String.self, forKey: .userPhone)
    }
    
}
