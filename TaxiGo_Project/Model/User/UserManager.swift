//
//  UserManager.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class UserManager {
    
    private init(){}
    
    static let shared = UserManager()
    
    func getUserToken(authCode: String) {
        
        guard let url = URL(string: "https://dev-user.taxigo.com.tw/oauth") else { return }
        let session = URLSession.shared
        let authorizationCode = authCode
        let parasDictionary = ["app_id": "-LKPYysKDcIdNs7CLYa3",
                               "app_secret": "ktOg9LHSZeGOIHxrp5beuYjNpacI7nu4xMAf",
                               "code": authCode]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parasDictionary, options: []) else { return }
        
        request.httpBody = httpBody

        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response else { return }
            
            print(response)
            print("========")
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
            } catch {
                
                print(error)
                
            }
        }.resume()
        
    }
    
    func requestARide() {
        
        
        
    }
    
    
    
    // NOTE: Use authorization code to get Redirect
    // TODO: Need to find out how to get code from URL first
    
    func getRedirect(params: [String: String]) {
        
//        let urlComp = NSURLComponents(string: "https://https://dev-user.taxigo.com.tw/oauth/test")
//
//        var items = [URLQueryItem]()
//
//        for (key, value) in params {
//
//            items.append(URLQueryItem(name: key, value: value))
//
//        }
//
//        items = items.filter({ !$0.name.isEmpty })
//
//        if !items.isEmpty {
//
//            urlComp?.queryItems = items
//
//        }
//
//        var urlRequest = URLRequest(url: (urlComp?.url)!)
//
//        urlRequest.httpMethod = "GET"
//
//        let config = URLSessionConfiguration.default
//
//        let session = URLSession(configuration: config)
//
//        let task = session.dataTask(with: urlRequest) { (data, response, error) in
//
//            print(data)
//
//        }
//        task.resume()
        
    }
    
}
