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
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: authorizationCode, options: .prettyPrinted)
            
        } catch let error {
            
            print(error.localizedDescription)
            
        }
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard error == nil,
                let data = data
            else { return }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    print("json: \(json)")
                    print("=============")
                    
                }
                
            } catch {
                
                print(error.localizedDescription)
                
            }
            
        }
        
    }
    
}
