//
//  UserManager.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SwifterSwift

struct UserManager {
    
    typealias Success = () -> Void
    typealias SuccessString = (_ string: String) -> Void
    typealias SuccessDict = (_ data: [String: Any]) -> Void
    typealias SuccessArray = (_ array: [[String: Any]]) -> Void
    
    typealias Failure = (_ err: Error) -> Void
    
    private init(){}
    
    static let shared = UserManager()
    
    private weak var httpClient = SHHTTPClient.shared
    
    private let provider = RideProvider()
    
    private let decoder = JSONDecoder()
    
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
    
    // Rewrite call function by using [:] type ------
    func rewriteCall(_ method: SHHTTPMethod, path: String?, parameter: [String: Any], complete: ((Error?, [String: Any]?, [[String: Any]]?) -> Void)? = nil) -> URLSessionDataTask {
        
        let url = URL(string: "\(TGPConstans.taxiGoUrl)" + "\(path ?? "")")
        let body = parameter
        let token = "Bearer \(TGPConstans.token)"
        
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json; charset=utf-8",
                         forHTTPHeaderField: "Content-Type")
        
        //send body
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            print("request error")
        }
        
        //callback
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response else { return }
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("Status Code: \(statusCode)")
            print("=====")
            
            DispatchQueue.main.async {
              
                do {
                    
                    if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        complete?(nil, json, nil)
                    } else if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                        print(json)
                        print("====")
                        complete?(nil, nil, json)
                    }
                    
                } catch {
                    
                    complete?(error, nil, nil)
                    
                }
            }
            
        }
        task.resume()
        
        return task
    }
    
    //ok
    func rewriteRequestARide(param: [String: Any],
                             success: @escaping (Ride?) -> Void,
                             failure: @escaping (Error) -> Void) {
        
        rewriteCall(.post, path: "/ride", parameter: param) { (err, data, array) in
            
            if err == nil {

                success(rideData(data: data))
                
            } else if let err = err {
                
                failure(err)
                print("QQ failed.")
                
            }
            
        }
        
    }
    
    //ok
    func rewriteGetHistory(id: String,
                           success: @escaping (Ride?, Driver?) -> Void,
                           failure: @escaping (Error) -> Void) {
        
        rewriteCall(.get, path: "/ride\(id)", parameter: [:]) { (err, data, array) in
            
            if err == nil {
                
                success(rideData(data: data), driverData(data: data))
                
            } else if let err = err {
                
                failure(err)
                print("QQ failed.")
                
            }
            
        }
        
    }
    
    //ok
    func rewriteGetRiderInfo(success: @escaping (Rider?) -> Void,
                             failure: @escaping (Error) -> Void) {
        
        rewriteCall(.get, path: "/me", parameter: [:]) { (err, data, array) in
            
            if err == nil {

                success(riderData(data: data))
                
            } else if let err = err {
                
                failure(err)
                print("get rider info failed.")
                
            }
            
        }
        
    }
    
    //ok
    func rewriteNearbyDriver(lat: Double,
                             lng: Double,
                             success: @escaping ([NearbyDrivers]?) -> Void,
                             failure: @escaping (Error) -> Void) {
        
        rewriteCall(.get, path: "/driver?lat=\(lat)&lng=\(lng)", parameter: [:]) { (err, data, array) in
            
            if err == nil {
                
                print(array)
                success(nearbyDriversData(array: array))
                
            } else if let err = err {
                
                failure(err)
                print("get rider info failed.")
                
            }
            
        }
        
    }
    
    //ok
    func rewriteCancelRide(id: String,
                           success: @escaping (String) -> Void,
                           failure: @escaping (Error) -> Void) {
        
        rewriteCall(.delete, path: "/ride\(id)", parameter: [:]) { (err, data, array) in
            
            if err == nil {
                
                print("Delete")
                print(data)
                
            } else if let err = err {
                
                failure(err)
                print("get rider info failed.")
                
            }
            
        }
        
    }
    
    func getNearbyDrivers(lat: Double, lng: Double) {
        
        guard let url = URL(string: "\(TGPConstans.taxiGoUrl)" + "/driver?lat=\(lat)&lng=\(lng)") else { return }
        let token = "Bearer \(TGPConstans.token)"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response else { return }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("Nearby Status Code: \(statusCode)")
            
            do {
                
                guard let data = data, let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else { return }
                
                print(json)
                print("==old function===")
                
            } catch {
                
                print("failed to get rider info.")
                
            }
            
        }
        task.resume()
        
    }
    
    
}
