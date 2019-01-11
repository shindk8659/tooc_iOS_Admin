//
//  APIRouter.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Alamofire

struct APIConfiguration {
    static let baseURL = "http://52.78.222.197:8080"
}

struct APIRouter {
    var url: String
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var data: Data?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, data: Data? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.data = data
    }
    
}
extension APIRouter {
    var requestUrl: String {
        return APIConfiguration.baseURL + url
    }
}
