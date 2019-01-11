//
//  LoginModel.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct LoginModel : Codable {
    
    let isReserve: Bool?
    enum CodingKeys: String, CodingKey {
        case isReserve = "isReserve"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isReserve = try values.decodeIfPresent(Bool.self, forKey: .isReserve)
    }
}
