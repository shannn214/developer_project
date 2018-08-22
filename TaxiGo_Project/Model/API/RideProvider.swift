//
//  RideProvider.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

private enum RideAPI: SHHTTPRequest {
    
    case getRides
    
    case getSpecificRide

    func urlParameter() -> String {
        
        switch self {
            
        case .getRides:
            return "/ride"
            
        case .getSpecificRide:
            return "/ride/id"
            
        }
        
    }
    
    func httpMethod() -> SHHTTPMethod {
        
        switch self {
            
        case .getRides:
            return .get
         
        case .getSpecificRide :
            return .get
            
        }
        
    }
    
    func requestHeader() -> [String : String] {
        
        return requestHeader().self
        
    }
}

struct RideProvider {
    
    private weak var httpClient = SHHTTPClient.shared
    
    func getRidesHistory() {
        
    }
    
}


