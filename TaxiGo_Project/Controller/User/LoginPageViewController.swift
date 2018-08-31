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
    
    var location: RequestRideLocation?
        
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserManager.shared.getUserToken(authCode: authCode)
        
//        fakeSendLocationBtn(startLatitude: 25.019946, startLongitude: 121.528717, startAddress: "台北市羅斯福路三段162號")

        
//        UserManager.shared.getNearbyDrivers(lat: 25.019946, lng: 121.528717)
        
//        UserManager.shared.rewriteGetRiderInfo(success: { (rider) in
//            print(rider)
//        }) { (err) in
//            print("NONONO")
//        }
        
        UserManager.shared.rewriteNearbyDriver(lat: 25.019946, lng: 121.528717, success: { (drivers) in
            print(drivers)
        }) { (err) in
            print("can't get nearby drivers")
        }
        
//        UserManager.shared.rewriteCancelRide(id: "/QJxkGx", success: { (_) in
//            print("backkkkkk")
//        }) { (err) in
//            print(err)
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
    
    func fakeSendLocationBtn(startLatitude: Double,
                             startLongitude: Double,
                             startAddress: String,
                             endLatitude: Double? = nil,
                             endLongitude: Double? = nil,
                             endAddress: String? = nil) {
        
        let param: [String: Any] = ["start_latitude": startLatitude,
                                    "start_longitude": startLongitude,
                                    "start_address": startAddress,
                                    "end_latitude": endLatitude,
                                    "end_longitude": endLongitude,
                                    "end_address": endAddress]
        
        UserManager.shared.rewriteRequestARide(param: param, success: { (ride) in
            if ride != nil {
                print(ride)
            }
        }) { (err) in
            print("NONONO")
        }
        
    }
    


}
