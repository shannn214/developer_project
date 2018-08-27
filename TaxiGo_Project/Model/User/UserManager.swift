//
//  UserManager.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SwifterSwift

class UserManager {
    
    private init(){}
    
    static let shared = UserManager()
    
    func getUserToken(authCode: String) {
        
        guard let url = URL(string: TGPConstans.oauthURL) else { return }
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
    
    func lovaStyleRequest(latitude: Float,
                          longitude: Float,
                          address: String,
                          parameter: [String: Any], complete: ((Error?, [String: Any]?) -> Void)? = nil) -> URLSessionDataTask {
        
        let url = URL(string: "https://api-sandbox.taxigo.io/v1/ride")
        
        var request: URLRequest?
        
        var params: [String: Any] = ["start_latitude": latitude,
                                     "start_longitude": longitude,
                                     "start_address": address]
        
        request = URLRequest(url: url!)
        request?.httpMethod = "POST"
        request?.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let body = params.queryParameters
        request?.httpBody = body.data(using: .utf8, allowLossyConversion: true)
        
        let token = "Bearer \(TGPConstans.token)"
        request?.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request!) { (binary, response, err) in
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print(statusCode)
            print("======")
            
            if let binary = binary, let json = try? JSONSerialization.jsonObject(with: binary, options: .allowFragments) as? [String: Any] {
                print(binary)
                print("------")
                print(json)
            }
            
        }
        task.resume()
        
        return task
        
    }
    
    // NOTE: This func includes two request: all rides and specific rides(with "id")
    // NOTE: Only show the ongoing trip & reservation history, when the trip was finished or cancel, it wouldn't list in the data
    func getRidesHistory(id: String?) {
        
        guard let url = URL(string: "https://api-sandbox.taxigo.io/v1/ride" + id!) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(TGPConstans.token)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response else { return }
            
            print("Response of Get Rides History: \(response)")
            print("=====")
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("Get Rides History JSON data: \(json)")
                print("======")
                
            } catch {
                print("Get Rides History JSON error: \(error)")
            }
        
        }.resume()
        
        
    }
    
    func shanDeleteRide(id: String) {
        
        guard let url = URL(string: "https://api-sandbox.taxigo.io/v1/ride" + id) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(TGPConstans.token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, err) in
            
            guard let data = data else {
                print("error calling delete")
                return }
            
            print("Delete ok")
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                print(data)
                print("------")
                print(json)
            }
            
            
        }
        task.resume()
        
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
