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
    
    case getSpecificRide(String)
    
    case cancelRide(String)
    
    case requestARide([String: Any])

    func urlParameter() -> String {
        
        switch self {
            
        case .getRides, .requestARide:
            return "/ride"
            
        case .getSpecificRide(let id), .cancelRide(let id):
            return "/ride/\(id)"
            
        }
        
    }
    
    func httpMethod() -> SHHTTPMethod {
        
        switch self {
            
        case .getRides, .getSpecificRide:
            return .get
         
        case .requestARide:
            return .post
            
        case .cancelRide:
            return .delete
            
        }
        
    }
    
    func requestBody() -> [String : Any] {
        
        switch self {
        case .requestARide(let body):
            return body
        default:
            return [:] // NOTE: 之後加 API 要注意會直接跳到 default
        }
        
    }
    
}

struct RideProvider {
    
    private weak var httpClient = SHHTTPClient.shared
    
    private let decoder = JSONDecoder()
    
    func getRidesHistory(success: @escaping (Data) -> Void,
                         failure: @escaping (Error) -> Void) -> Void {
        
        
        
    }
    
    func getSpecificRide(id: String,
                         success: @escaping (Ride) -> Void,
                         failure: @escaping (Error) -> Void) -> Void {
        
        httpClient?.request(RideAPI.getSpecificRide("/\(id)"),
                            success: { (data) in
                                
                                do {

                                    let response = try self.decoder.decode(SHHTTPResponse<Ride>.self, from: data)
                                    
                                    success(response.data)

                                } catch {
//                                    TODO
                                }
            
        },
                            failure: { (error) in
            //TODO
        })
        
    }
    
    func requestARide(){
        
        
        
    }
    
    func cancelRide() {
        
        
        
    }
    
}


