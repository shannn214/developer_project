//
//  MapViewController.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/29.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var codeMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        showSpot()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    latitude: 25.019946, longitude: 121.528717
    func showSpot() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.019946, longitude: 121.528717, zoom: 0.6)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(25.019946, 121.528717)
        marker.map = self.mapView
        
    }
    
    
    
}
