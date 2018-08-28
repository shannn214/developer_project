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
        
        queue = DispatchQueue(label: String(describing: SHHTTPClient.self) + UUID().uuidString, qos: .default, attributes: .concurrent)
        
    }
    
    @discardableResult
    func request(_ HTTPRequest: SHHTTPRequest,
                 success: @escaping (Data) -> Void,
                 failure: @escaping (Error) -> Void) -> URLRequest? {

        do {
            // NOTE: HTTPRequest can't work
            return try request(HTTPRequest.request() as! SHHTTPRequest, success: success,failure: failure)
        } catch {
            failure(error)
            print("HTTPClient request failed.")
            return nil
        }
        
    }
    
//    func request(method: SHHTTPMethod, urlString: String, parameter: [String: Any], id: String?, success: String?, failure: String?) {
//
//        guard let url = URL(string: "https://api-sandbox.taxigo.io/v1/ride" + id!) else { return }
//        let session = URLSession.shared
//        var request = URLRequest(url: url)
//
//        var param = parameter
//
//        if method == .get {
//
//            request.httpMethod = method.rawValue
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("Bearer \(TGPConstans.token)", forHTTPHeaderField: "Authorization")
//
//
//        }
//
//    }
    
}


