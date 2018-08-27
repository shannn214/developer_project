//
//  SHHTTPResponse.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct SHHTTPResponse <T: Codable> : Codable {
    let data: T
}
