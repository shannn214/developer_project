//
//  LoginManager.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class LoginManager: UIViewController {
    
    static let shared = LoginManager()
    
    weak var delegate = UIApplication.shared.delegate as? AppDelegate
    
    var authViewController = UIViewController()
    
    var authSession: SFAuthenticationSession?
    
    let code = "code"
    
    func startLoginFlow() {
                
        guard let authURL = URL(string: TGPConstans.authURL) else { return }
        
        self.authSession = SFAuthenticationSession(url: authURL, callbackURLScheme: TGPConstans.callBackUrlScheme, completionHandler: { (callBack: URL?, error: Error?) in
            
            guard error == nil, let successURL = callBack else {
                print(error!)
                print("=======")
                return }
            
//            let callBackRedirect = getQueryStringParameter(url: successURL.absoluteString, param: self.code)
            
            let callBackRedirect = NSURLComponents(string: successURL.absoluteString)?.queryItems?.filter({ $0.name == self.code }).first
            
            print(callBackRedirect)
            
        })
        self.authSession?.start()
        
    }
    
    
}

func getQueryStringParameter(url: String, param: String) -> String? {
    
    guard let url = URLComponents(string: url) else { return nil }
    
    return url.queryItems?.first(where: { $0.name == param })?.value
    
}




