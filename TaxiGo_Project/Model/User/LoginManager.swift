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
    
    let APPID = "-LKPYysKDcIdNs7CLYa3"
    
    let redirectUri = "https://dev-user.taxigo.com.tw/oauth/test"
    
    let appSecret = "ktOg9LHSZeGOIHxrp5beuYjNpacI7nu4xMAf"
    
    let callBackUrlScheme = "SFAuthenticationExample://"
    
    let code = "code"
    

    func startAuthenticationFlow() {
        
        //NOTE: Test safari
        guard let authURL = URL(string: "https://user.taxigo.com.tw/oauth/authorize?app_id=" + "\(APPID)" + "&redirect_uri=" + "\(redirectUri)") else { return }
        
        self.authViewController = SFSafariViewController.init(url: authURL)
        delegate?.window?.rootViewController?.present(self.authViewController,
                                                      animated: true,
                                                      completion: nil)
        
        // NOTE: Cannot grab the code from URL
        startAuthSession()
        
    }
    
    func startAuthSession() {
                
        guard let authURL = URL(string: "https://user.taxigo.com.tw/oauth/authorize?app_id=" + "\(APPID)" + "&redirect_uri=" + "\(redirectUri)") else { return }
        
        self.authSession = SFAuthenticationSession(url: authURL, callbackURLScheme: callBackUrlScheme, completionHandler: { (callBack: URL?, error: Error?) in
            
            guard error == nil, let successURL = callBack else {
                print(error!)
                print("=======")
                return }
            
//            let callBackRedirect = getQueryStringParameter(url: successURL.absoluteString, param: self.code)
            
            let callBackRedirect = NSURLComponents(string: successURL.absoluteString)?.queryItems?.filter({ $0.name == "code" }).first
            
            print(callBackRedirect)
            
        })
        self.authSession?.start()
        
    }
    
    
}

func getQueryStringParameter(url: String, param: String) -> String? {
    
    guard let url = URLComponents(string: url) else { return nil }
    
    return url.queryItems?.first(where: { $0.name == param })?.value
    
}




