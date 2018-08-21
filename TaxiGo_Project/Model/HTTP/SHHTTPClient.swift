//
//  SHHTTPClient.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class SHHTTPClient {
    
    static let shared = SHHTTPClient()
    
    private let queue: DispatchQueue
    
    private init() {
        
        queue = DispatchQueue(label: String(describing: SHHTTPClient.self),
                              qos: .default,
                              attributes: .concurrent)
        
    }
    
    @discardableResult
    private func request(method: SHHTTPMethod) -> URLSessionDataTask? {
        
        var request: URLRequest?
        
        let url = TGPConstans.taxiGoUrl
        
//        switch method {
//
//        case .post:
//            request =
//
//        }
        
        guard let task: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: url)!) else { return nil }
        
        return task
        
    }
    
    
}
