//
//  Reservation.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

extension API {
    
    func requestRide(urlString: String, parameters: [String: Any], completion: @escaping (Data) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                          options: .prettyPrinted)
            
        } catch let error {
            
            print("\(TaxiGoError.serverError)")
            
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        fetchData(from: request, completion: completion)
        
    }
    
    private func fetchData(from request: URLRequest, completion: @escaping (Data) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                
                print(error as Any)
                
            } else {
                
                guard let data = data else { return }
                
                completion(data)
                
            }
            
        }
        task.resume()
    }
    
}
