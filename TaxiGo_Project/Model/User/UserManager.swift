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
    
    func lovaStyleRequest(latitude: Float,
                          longitude: Float,
                          address: String,
                          parameter: [String: Any], complete: ((Error?, [String: Any]?) -> Void)? = nil) -> URLSessionDataTask {
        
        let url = URL(string: TGPConstans.taxiGoUrl + "/ride")
        
        var params: [String: Any] = ["start_latitude": latitude,
                                     "start_longitude": longitude,
                                     "start_address": address]
        let body = params.queryParameters
        let token = "Bearer \(TGPConstans.token)"

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8, allowLossyConversion: true)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (binary, response, err) in
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("Status Code: \(statusCode)")
            print("======")
            
            guard let binary = binary, let json = try? JSONSerialization.jsonObject(with: binary, options: .allowFragments) as? [String: Any] else { return }
            
            print(json!)
            
//            guard let binary = binary else { return }
//
//            if let data = try? self.decoder.decode(Ride.self, from: binary) {
//                print(data)
//            } else {
//                print("error nonononono")
//            }
            
            
        }
        task.resume()
        
        return task
        
    }
    
    // NOTE: This func includes two request: all rides and specific rides(with "id")
    // NOTE: Only show the ongoing trip & reservation history, when the trip was finished or cancel, it wouldn't list in the data
    func getRidesHistory(id: String?) {
        
        guard let url = URL(string: "https://api-sandbox.taxigo.io/v1/ride/" + id!) else { return }
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

//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print("Get Rides History JSON data: \(json)")
//                print("======")
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//                print(json)
                
//                    guard let slatitude = json["status"] as? String else { return }
//
//                    print(slatitude)
        
                let id = json["id"] as? String
                let startLatitude = json["start_latitude"] as? Double
                let startLongitude = json["start_longitude"] as? Double
                let startAddress = json["start_address"] as? String
                let endLatitude = json["end_latitude"] as? Double ?? 0
                let endLongitude = json["end_longitude"] as? Double ?? 0
                let endAddress = json["end_address"] as? String ?? ""
                let requestTime = json["request_time"] as? Double
                let status = json["status"] as? String
                
                let ride = Ride(id: id!, startLatitude: startLatitude!, startLongitude: startLongitude!, startAddress: startAddress!, endLatitude: endLatitude, endLongitude: endLongitude, endAddress: endAddress, requestTime: requestTime!, status: status!)
                
                print(ride)

                if let driver = json["driver"] as? [String: Any] ?? nil {
                    let driverId = driver["driver_id"] as? Double
                    let driverLatitude = driver["driver_latitude"] as? Double
                    let driverLongitude = driver["driver_longitude"] as? Double
                    let eta = driver["eta"] as? Double
                    let name = driver["name"] as? String
                    let plateNumber = driver["plate_number"] as? String
                    let vehicle = driver["vehicle"] as? String
                    
                    let driverInfo = Driver(driverId: driverId!, driverLatitude: driverLatitude!, driverLongitude: driverLongitude!, eta: eta!, name: name!, plateNumber: plateNumber!, vehicle: vehicle!)
                    
                    print(driverInfo)
                }
        

            } catch {
                print("Get Rides History JSON error: \(error)")
            }
        
        }.resume()
        
        
    }
    
    func cancelRide(id: String) {
        
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
    
    // NOTE: Luke Style Request
    func testOfSpecificRide(id: String, success: @escaping (Ride) -> Void, failure: @escaping (Error) -> Void) -> Void {
        
        provider.getSpecificRide(id: id, success: { (ride) in
            
            var rideObject = ride
            
//            print(rideObject.driver)
            
        }, failure: failure)
        
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
