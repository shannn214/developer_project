//
//  Dictionary.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/22.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SwifterSwift

extension Dictionary {
    
    var queryParameters: String {
        
        var parts: [String] = []
        for (key, value) in self {
            
            let part = String(format: "%@=%@", String(describing: key).urlEncoded , String(describing: value).urlEncoded)
            parts.append(part as String)
            
        }
        return parts.joined(separator: "&")
    }
    
}
