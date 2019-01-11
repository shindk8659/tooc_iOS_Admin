//
//  ReservationListModel.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct ReservationListModel: Codable {
    let reserveResponseDtoList : [ReserveResponseDtoList]?
    let storeResponseDtoList : [StoreResponseDtoList]?
    
    enum CodingKeys: String, CodingKey {
        
        case reserveResponseDtoList = "reserveResponseDtoList"
        case storeResponseDtoList = "storeResponseDtoList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reserveResponseDtoList = try values.decodeIfPresent([ReserveResponseDtoList].self, forKey: .reserveResponseDtoList)
        storeResponseDtoList = try values.decodeIfPresent([StoreResponseDtoList].self, forKey: .storeResponseDtoList)
    }
}
