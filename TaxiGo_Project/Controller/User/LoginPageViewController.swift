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
    
//    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UserManager.shared.getUserToken(authCode: authCode)
                
//        UserManager.shared.getRidesHistory(id: "POyQHX")
        
//        UserManager.shared.lovaStyleRequest(location: requestLocation, parameter: [:])
        
//        UserManager.shared.requestARide(latitude: 25.019946, longitude: 121.528717, address: "台北市羅斯福路三段162號", parameter: [:])
        
//        UserManager.shared.cancelRide(id: "/TUXdzd")
        
//        UserManager.shared.requestARide(startLatitude: 25.019946, startLongitude: 121.528717, startAddress: "台北市羅斯福路三段162號", endLatitude: nil, endLongitude: nil, endAddress: nil, success: { (ride) in
//            if ride != nil {
//                print("request success")
//                print(ride)
//            }
//        }) { (err) in
//            print("request failed")
//        }
        
//        fakeSendLocationBtn(startLatitude: 25.019946, startLongitude: 121.528717, startAddress: "台北市羅斯福路三段162號")
        
//        UserManager.shared.getRidesHistory(id: "POyQHX", success: { (ride, driver) in
//            if ride != nil {
//                print(ride)
//            }
//            if driver != nil {
//                print(driver)
//            }
//        }) { (err) in
//            print("request failed.")
//        }
        
        UserManager.shared.getRiderInfo()
        UserManager.shared.getNearbyDrivers(lat: 25.019946, lng: 121.528717)
        
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
        
        UserManager.shared.requestARide(param: param, success: { (ride, driver) in
            if ride != nil {
                print(ride)
            }
            if driver != nil {
                print(driver)
            }
        }) { (err) in
            print("request failed.")
        }
        
    }
    


}
