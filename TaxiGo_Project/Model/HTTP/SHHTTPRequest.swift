//
//  SHHTTPRequest.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

enum SHHTTPMethod: String {
    
    case post = "POST"

    case get = "GET"
    
    case delete = "DELETE"

}

enum SHHTTPHeader: String {
    
    case authorization = "Authorization"
    
    case contentType = "Content-Type"
    
}

enum SHHTTPContentType: String {
    
    case json = "application/json"
    
}

protocol SHHTTPRequest {
    
    func httpMethod() -> SHHTTPMethod
    
    func urlParameter() -> String
    
    //Optional
    
    func requestHeader() -> [String: String]
    
    func requestBody() -> [String: Any]
    
    func urlString() -> String
    
    func request() throws -> URLRequest
    
}

extension SHHTTPRequest {
    
    func requestBody() -> [String: Any] { return [:] }

    func urlString() -> String {
        return TGPConstans.taxiGoUrl
    }
    
    func request() throws -> URLRequest {
        
        let url = URL(string: urlString())
        
        guard let taxiGoUrl = url else { throw TaxiGoError.serverError }
        
        var request = URLRequest(url: taxiGoUrl)
        
        request.httpMethod = httpMethod().rawValue
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody(),
                                                      options: .prettyPrinted)
        
        return request
        
    }
    
}



