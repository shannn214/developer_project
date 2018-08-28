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
                
        LoginManager.shared.startLoginFlow()
        
    }
    
    let paramsKey = "code"
    
    let authCode = "jNhArR3v6SrWEbGegOjNxfzEjc"
    
//    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserManager.shared.getUserToken(authCode: authCode)
                
        UserManager.shared.getRidesHistory(id: "POyQHX")
//        userManager.getRidesHistory(id: "POyQHX")
        
//        UserManager.shared.lovaStyleRequest(latitude: 25.019946, longitude: 121.528717, address: "台北市羅斯福路三段162號", parameter: [:])
        
//        UserManager.shared.cancelRide(id: "/TUXdzd")
        

//        userManager.testOfSpecificRide(id: "POyQHX", success: { (ride) in
//            print(ride)
//        }) { (error) in
//            print("Noooooooo")
//            //TODO
//        }
        
        //tQdHHi
        //stQiyS
//        POyQHX
//        TxEVFx
//        TUXdzd
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
