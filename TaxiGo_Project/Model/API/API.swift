//
//  API.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

let api = API.shared

private enum RideAPI: SHHTTPRequest {
    
    case getRides
    
    case postRide


    func httpMethod() -> SHHTTPMethod {
        
        switch self {
            
        case .getRides:
            return .get
         
        case .postRide:
            return .post
            
        }
        
    }
    
    func urlParameter() -> String {

//        switch self {
//
//        case .getRides:
//            return ""
//
//        }

        return String()
        
    }
    
    func requestHeader() -> [String : String] {
        
        return requestHeader().self
        
    }
}

class API {
    
    static let shared: API = {
        
        let instance = API()
        return instance
        
    }()
    
}


