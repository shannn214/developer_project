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
    
    func requestARide(latitude: Float, longitude: Float, address: String) {
        
        guard let url = URL(string: TGPConstans.taxiGoUrl + "/ride") else { return }
        let session = URLSession.shared
        
        let userLocation: [String: Any] = ["start_latitude": latitude,
                                           "start_longitude": longitude,
                                           "start_address": address]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(TGPConstans.token)", forHTTPHeaderField: "Authorization")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userLocation, options: .prettyPrinted) else { return }
        
        request.httpBody = httpBody
        
        session.dataTask(with: request) { (data, response, errpr) in
            
            guard let response = response else { return }
            
            print("Request ride response: \(response)")
            print("=======")
            
            guard let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("Request ride JSON data: \(json)")
                print("======")
                
            } catch {
                print("Request ride JSON error: \(error)")
            }
            
        }.resume()
        
    }
    
    
//    https://api-sandbox.taxigo.io/v1/ride
//    -H "Content-Type:application/json"
//    -H "Authorization: Bearer user access token}" \
//    -d start_latitude: 25.019946, start_longitude: 121.528717, start_address: 台北市羅斯福路三段162號}"
    
    
    // NOTE: 先把東西要到在合併到 SHHTTPClient
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
