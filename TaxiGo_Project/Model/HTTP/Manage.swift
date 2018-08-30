//
//  Manage.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/30.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

enum functions {
    
    case requestARide
    
    case getSpecificRide
    
    case getRidesHistory
    
    case cancelRide
    
    case getRiderInfo
    
    case getNearbyDriver
    
}

func rideData(data: [String: Any]?) -> Ride? {
    
    let id = data?["id"] as? String
    let startLatitude = data?["start_latitude"] as? Double
    let startLongitude = data?["start_longitude"] as? Double
    let startAddress = data?["start_address"] as? String
    let endLatitude = data?["end_latitude"] as? Double ?? 0
    let endLongitude = data?["end_longitude"] as? Double ?? 0
    let endAddress = data?["end_address"] as? String ?? ""
    let requestTime = data?["request_time"] as? Double
    let status = data?["status"] as? String
    
    let ride = Ride(id: id!, startLatitude: startLatitude!, startLongitude: startLongitude!, startAddress: startAddress!, endLatitude: endLatitude, endLongitude: endLongitude, endAddress: endAddress, requestTime: requestTime!, status: status!)
    
//    print(ride)
    
    return ride
}

func driverData(data: [String: Any]?) -> Driver? {
    
    if let driver = data?["driver"] as? [String: Any] ?? nil {
        let driverId = driver["driver_id"] as? Double
        let driverLatitude = driver["driver_latitude"] as? Double
        let driverLongitude = driver["driver_longitude"] as? Double
        let eta = driver["eta"] as? Double
        let name = driver["name"] as? String
        let plateNumber = driver["plate_number"] as? String
        let vehicle = driver["vehicle"] as? String
        
        let driverInfo = Driver(driverId: driverId!, driverLatitude: driverLatitude!, driverLongitude: driverLongitude!, eta: eta!, name: name!, plateNumber: plateNumber!, vehicle: vehicle!)
        
//        print(driverInfo)
        
        return driverInfo
    }
    
    print("No driver data.")
    return nil
}

func riderData(data: [String: Any]?) -> Rider? {
    
    var favArray = [Favorite]()
    guard let name = data?["name"] as? String,
        let profileImg = data?["profile_img"] as? String else { return nil }
    
    if let favorite = data?["favorite"] as? [[String: Any]] ?? nil {
        
        for info in favorite {
            guard let address = info["address"] as? String,
                let lat = info["lat"] as? Double,
                let lng = info["lng"] as? Double
                else { return nil }
            
            let fav = Favorite(address: address, lat: lat, lng: lng)
            favArray.append(fav)
        }
        
        let rider = Rider(name: name, profileImg: profileImg, favorite: favArray)
        print(rider)
        
        return rider
    }
    
    print("No rider data.")
    return nil
}

func nearbyDriversData(data: [String: Any]?) -> [NearbyDrivers]? {
    
    var nbDrivers = [NearbyDrivers]()
    
    if let nearbyDrivers = data as? [[String: Any]] ?? nil {
        
        for driver in nearbyDrivers {
            
            let lat = driver["lat"] as? Double
            let lng = driver["lng"] as? Double
            
            let drivers = NearbyDrivers(lat: lat!, lng: lng!)
            nbDrivers.append(drivers)

        }
        print(nbDrivers)
        print("-------")
        return nbDrivers
    }
    
    return nil
}
