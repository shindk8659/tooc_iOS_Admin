//
//  NetworkManager.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    let jwt = UserDefaults.standard.string(forKey: "jwt")
    
    func login(email:String, password:String, completion: @escaping (ErrorModel?,ErrorModel?,Error?) -> Void) {
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let router = APIRouter(url:"/api/users/login", method: .post, parameters: parameters)
        NetworkRequester(with: router).request1 { (login: ErrorModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(errorModel,errorModel,error)
        }
    }
    
    func getStoreIdx(completion: @escaping (StoreIdx?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        print(gsno(jwt))
        let router = APIRouter(url: "/api/owner/store", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request1 { (Idx: StoreIdx?, errorModel:ErrorModel?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(Idx,errorModel,error)
        }
    }
    
    func getReservationInfo(code:String,completion: @escaping (ReservationCodeModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let storeIdx = UserDefaults.standard.integer(forKey: "storeIdx")
        let url = "/api/owner/reserve/\(storeIdx)/\(code)"
        let router = APIRouter(url: url, method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request1 { (resrvtionInfo:ReservationCodeModel?, errorModel:ErrorModel?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(resrvtionInfo,errorModel,error)
        }
    }
    
    func postInquiry(image: [String], content: String, createAt: Int, completion: @escaping(ErrorModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let param: [String:Any] = [
            "inquiryImgs" : image,
            "content" : content,
            "createAt" : createAt
        ]
        
        let router = APIRouter(url:"/api/inquiry", method: .post, parameters: param ,headers:header)
        
        NetworkRequester(with: router).request1 { (reservationDetail: ErrorModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(nil,errorModel,error)
        }
    }
    
    func uploadImg(data: Data, completion: @escaping(ImgModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let router = APIRouter(url: "/api/img", method: .post, parameters: nil, headers: header, data: data)
        
        NetworkRequester(with: router).requestMultipartFormData{
            (Img:ImgModel?, errorModel :ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(Img,errorModel,error)
        }
    }
    
    func inquireList(completion: @escaping(ReservationListModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        let router = APIRouter(url: "/api/owner/reserve", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request1 { (list: ReservationListModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(list,errorModel,error)
        }
    }
    
    
    func getStoreReview(completion: @escaping(StoreReviewModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let router = APIRouter(url: "/api/owner/review", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request1 { (storereview: StoreReviewModel?, errorModel:ErrorModel?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(storereview,errorModel,error)
        }
        
        
    }
    
    
    func getMyPage(completion: @escaping(MyPageMainModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let router = APIRouter(url: "/api/owner/mypage", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).request1 { (storereview: MyPageMainModel?, errorModel:ErrorModel?, error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(storereview,errorModel,error)
        }
        
        
    }
    
    func reserveSwitch(completion: @escaping (ErrorModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let router = APIRouter(url:"/api/owner/mypage/onoff", method: .put, parameters: nil, headers: header)
        NetworkRequester(with: router).request1 { (result: ErrorModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(result,errorModel,error)
        }
    }
    
    func reserveAndPick(img: [String], reserveIdx: Int, completion: @escaping (ErrorModel?,ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "jwt": gsno(jwt)
        ]
        
        let param = [
            "bagImgUrl": img
        ]
        
        let router = APIRouter(url:"/api/owner/reserve/\(reserveIdx)", method: .put, parameters: param, headers: header)
        NetworkRequester(with: router).request1 { (result: ErrorModel?, errorModel:ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(result,errorModel,error)
        }
    }
    
    
}
