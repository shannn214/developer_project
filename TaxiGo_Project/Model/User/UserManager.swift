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
    
    func requestARide(param: [String: Any],
                      success: @escaping (Ride?, Driver?) -> Void,
                      failure: @escaping (Error) -> Void) {
        
        call(.post, path: "", parameter: param) { (err, ride, driver) in
            if err == nil {
                success(ride, driver)
            } else if let err = err {
                failure(err)
            }
        }
        
        
    }
    
    func getRidesHistory(id: String,
                         success: @escaping (Ride?, Driver?) -> Void,
                         failure: @escaping (Error) -> Void) {
        
        call(.get, path: "/\(id)", parameter: [:]) { (err, ride, driver) in
            if err == nil {
                success(ride, driver)
            } else if let err = err {
                failure(err)
            }
        }
        
    }
    
    func call(_ method: SHHTTPMethod, path: String?, parameter: [String: Any], complete: ((Error?, Ride?, Driver?) -> Void)? = nil) -> URLSessionDataTask {
        
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
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            guard let response = response else { return }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("Status Code: \(statusCode)")
            print("=====")
            
            do {
                
                guard let data = data, let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
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
                    
                    complete?(nil, ride, driverInfo)
                }
                
                
            } catch {
                print("Get Rides History JSON error: \(error)")
            }
            
        }
        task.resume()
        
        return task
        
    }
    
    // NOTE: This func includes two request: all rides and specific rides(with "id")
    // NOTE: Only show the ongoing trip & reservation history, when the trip was finished or cancel, it wouldn't list in the data
    func getHistory(id: String?) {
        
        guard let url = URL(string: "https://api-sandbox.taxigo.io/v1/ride/" + id!) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(TGPConstans.token)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response else { return }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("Status Code: \(statusCode)")
            print("=====")
            
            guard let data = data else { return }
                        
            do {

//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print("Get Rides History JSON data: \(json)")
//                print("======")
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
        
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
