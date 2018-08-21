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
    
    func startAuthenticationFlow() {
        
        //NOTE: Test safari
        guard let authURL: URL? = URL(string: "https://www.google.com.tw") else { return }
        
        self.authViewController = SFSafariViewController.init(url: authURL!)
        delegate?.window?.rootViewController?.present(self.authViewController,
                                                      animated: true,
                                                      completion: nil)
        
    }
    
    
}
