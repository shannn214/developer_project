//
//  MapViewController.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/29.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let infoMarker = GMSMarker()
    
    var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    var placesClient: GMSPlacesClient!
    
    var zoomLevel: Float = 15.0
    
    var likePlaces: [GMSPlace] = []
    
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        showSpot()
        
        mapView.delegate = self
        
        initialSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialSetting() {
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
    }
    
//    latitude: 25.019946, longitude: 121.528717
    func showSpot() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.019946,
                                              longitude: 121.528717,
                                              zoom: zoomLevel)
        
        self.mapView.isHidden = true
        self.mapView.camera = camera
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        
        let position = CLLocationCoordinate2D(latitude: 25.019946, longitude: 121.528717)
        let secondPosition = CLLocationCoordinate2D(latitude: 25.030992, longitude: 121.563741)
        let marker = GMSMarker(position: position)
        let secondMarker = GMSMarker(position: secondPosition)
//        marker.map = self.mapView
//        marker.title = "YAHAHA" //should modify the shape
//        secondMarker.map = self.mapView
//        marker.tracksViewChanges = true //increase battery isage
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        
        print("Tapped \(name): \(placeID), \(location.latitude), \(location.longitude)")
    
//        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination == "seguaToSelect" {
            if let nextVC = segue.destination as? PlacesViewController {
                
            }
        }
    }
    
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.last!
        print("location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        listLikelyPlaces()
        
    }
    
    // Handle authorization for location manager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likePlaces.removeAll()
        
        placesClient.currentPlace { (placeLikelihoods, err) in
            if let err = err {
                // TODO: Handle the error
                print("Current place error: \(err.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likePlaces.append(place)
                }
            }
            
        }
        
    }
    
}

