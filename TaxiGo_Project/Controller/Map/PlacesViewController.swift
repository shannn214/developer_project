//
//  PlacesViewController.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/31.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import GooglePlacePicker

class PlacesViewController: UIViewController {

//    var mapPlacePicker = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let mapPlacePicker = GMSPlacePickerViewController(config: config)
        mapPlacePicker.delegate = self
        self.addChildViewController(mapPlacePicker)
        mapPlacePicker.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(mapPlacePicker.view)
        mapPlacePicker.didMove(toParentViewController: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    @IBAction func placePicker(_ sender: Any) {
//
//        let config = GMSPlacePickerConfig(viewport: nil)
//        let placePickers = GMSPlacePickerViewController(config: config)
//        placePickers.delegate = self
//        placePickers.modalPresentationStyle = .popover
////        placePickers.popoverPresentationController?.sourceView = pickAPlaceButton
////        placePickers.popoverPresentationController?.sourceRect = pickAPlaceButton.bounds
//
//        self.present(placePickers, animated: true, completion: nil)
//    }
    
  
}

extension PlacesViewController : GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Create the next view controller we are going to display and present it.
//        let nextScreen = PlaceDetailViewController(place: place)
//        self.splitPaneViewController?.push(viewController: nextScreen, animated: false)
//        self.mapViewController?.coordinate = place.coordinate
//
//        // Dismiss the place picker.
//        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        NSLog("An error occurred while picking a place: \(error)")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        NSLog("The place picker was canceled by the user")
        
        // Dismiss the place picker.
        viewController.dismiss(animated: true, completion: nil)
    }
}
