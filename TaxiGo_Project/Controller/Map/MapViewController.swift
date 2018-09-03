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
import GooglePlacePicker

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchDestination: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchFrom: UITextField!
    
    var resultViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var fetcher: GMSAutocompleteFetcher?
    
    let infoMarker = GMSMarker()
    
    var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    var placesClient: GMSPlacesClient!
    
    var zoomLevel: Float = 15.0
    
    var likePlaces: [GMSPlace] = []
    
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.shared()
        
        setMapView()
        
        getCurrentPlace()
        
        setupResultSearch()
        
//        searchDestination.addTarget(self, action: #selector(triggerSearchAction), for: .touchDown)
        searchFrom.addTarget(self, action: #selector(triggerSearchAction), for: .touchDown)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func triggerSearchAction() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.modalPresentationStyle = .overCurrentContext
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func setupFetcher() {
        
        let visibleRegion = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.farRight)
        
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: nil)
        fetcher?.delegate = self
        
        searchDestination.addTarget(self, action: #selector(textFiedDidChange), for: .editingChanged)

    }
    
    @objc func textFiedDidChange() {
        
        fetcher?.sourceTextHasChanged(searchDestination.text)
        
    }
    
    
    func setupResultSearch() {
        
        resultViewController = GMSAutocompleteResultsViewController()
        resultViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultViewController)
        searchController?.searchResultsUpdater = resultViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 65, width: 350, height: 45))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
        
        navigationController?.navigationBar.isTranslucent = false
        searchController?.hidesNavigationBarDuringPresentation = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        
    }
    
    fileprivate func setMapView() {
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.019946,
                                              longitude: 121.528717,
                                              zoom: zoomLevel)
        let position = CLLocationCoordinate2D(latitude: 25.019946, longitude: 121.528717)

        mapView.camera = camera
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.camera = GMSCameraPosition(target: position, zoom: 15, bearing: 0, viewingAngle: 0)

//        let secondPosition = CLLocationCoordinate2D(latitude: 25.030992, longitude: 121.563741)
//        let marker = GMSMarker(position: position)
//        let secondMarker = GMSMarker(position: secondPosition)
//        marker.map = mapView
//        mapView.isUserInteractionEnabled = false
        
        initialSetting()
        
    }
    
    func getCurrentPlace() {
        
        placesClient.currentPlace { (placeList, error) in
            
            if let error = error {
                print("Pick place error: \(error.localizedDescription)")
            }
            
            self.locationLabel.text = "No current place."
            
            if let placeList = placeList {
                let place = placeList.likelihoods.first?.place
                if let place = place {
                    self.locationLabel.text = "\(place.name), lat: \(place.coordinate.latitude), lng: \(place.coordinate.longitude)"
                    self.searchFrom.text = "\(place.name)"
                    
                }
            }
            
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.modalPresentationStyle = .overCurrentContext
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func initialSetting() {
        
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//        placesClient = GMSPlacesClient.shared()
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        
        print("Tapped \(name): \(placeID), \(location.latitude), \(location.longitude)")
    
//        infoMarker.snippet = placeID // subtitle
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
        
    }
    
}

extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        print("Place name: \(place.name)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        // TODO: Handle error
        print("Error", error.localizedDescription)
    }
    
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
}

extension MapViewController: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        let resultStr = NSMutableString()
        for prediction in predictions {
            
            resultStr.appendFormat("%@\n", prediction.attributedPrimaryText)
            
        }
        
        print(resultStr)
    
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}


