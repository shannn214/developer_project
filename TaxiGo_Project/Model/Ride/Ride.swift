//
//  Ride.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct Driver: Codable {
    
    let driver_id: Float
    
    let driverLatitude: Float
    
    let driverLongitude: Float
    
    let name: String
    
    let plateNumber: String
    
    let vehicle:String

}

struct Ride: Codable {
    
    let id: String
    
    let startLatitude: Float
    
    let startLongitude: Float
    
    let startAddress: String
    
    let endLatitude: Float?
    
    let endLongitude: Float?
    
    let endAddress: String?
    
    let requestTime: String
    
    let status: String
    
    let driver: Driver?
    
    private enum CodingKeys: String, CodingKey {
        
        case startLatitude = "start_latitude"
        
        case startLongitude = "start_longitude"
        
        case startAddress = "start_address"
        
        case endLatitude = "end_latitude"
        
        case endLongitude = "end_longitude"
        
        case endAddress = "end_address"
        
        case requestTime = "request_time"
        
        case id, status, driver
        
    }
    
}




