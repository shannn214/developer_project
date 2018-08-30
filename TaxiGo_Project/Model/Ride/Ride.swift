//
//  Ride.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct Driver: Codable {
    
    let driverId: Double
    
    let driverLatitude: Double
    
    let driverLongitude: Double
    
    let eta: Double
    
    let name: String
    
    let plateNumber: String
    
    let vehicle: String
    
    private enum CodingKeys: String, CodingKey {
        
        case driverId = "driver_id"
        
        case driverLatitude = "driver_latitude"
        
        case driverLongitude = "driver_longitude"
        
        case plateNumber = "plate_number"
        
        case eta, name, vehicle
        
    }

}

struct Ride: Codable {
    
    let id: String
    
    let startLatitude: Double
    
    let startLongitude: Double
    
    let startAddress: String
    
    let endLatitude: Double?
    
    let endLongitude: Double?
    
    let endAddress: String?
    
    let requestTime: Double
    
    let status: String
    
//    let driver: Driver?
    
    private enum CodingKeys: String, CodingKey {
        
        case startLatitude = "start_latitude"
        
        case startLongitude = "start_longitude"
        
        case startAddress = "start_address"
        
        case endLatitude = "end_latitude"
        
        case endLongitude = "end_longitude"
        
        case endAddress = "end_address"
        
        case requestTime = "request_time"
        
        case id, status
        
    }
    
}

struct Rider {
    
    let name: String
    
    let profileImg: String?
    
    let favorite: [Favorite]?
    
}

struct Favorite {
    
    let address: String
    
    let lat: Double
    
    let lng: Double
    
}

struct NearbyDrivers {
    
    let lat: Double
    
    let lng: Double
    
}

struct RequestRideLocation {
    
    let startLatitude: Double
    
    let startLongitude: Double
    
    let startAddress: String
    
    let endLatitude: Double?
    
    let endLongitude: Double?
    
    let endAddress: String?
    
}




