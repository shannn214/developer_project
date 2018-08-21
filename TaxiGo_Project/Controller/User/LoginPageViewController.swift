//
//  LoginPageViewController.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var testbtn: UIButton!
    
    @IBAction func testButton(_ sender: Any) {
        
        LoginManager.shared.startAuthenticationFlow()
        
    }
    
    let authCode = "jNhArR3v6SrWEbGegOjNxfzEjc"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserManager.shared.getUserToken(authCode: authCode)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
