//
//  ErrorModel.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation

struct ErrorModel : Codable {
    let field : String?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case field = "field"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        field = try values.decodeIfPresent(String.self, forKey: .field)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
