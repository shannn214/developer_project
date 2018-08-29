//
//  Constants.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/8/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct TGPConstans {
    
    static let taxiGoUrl = "https://api-sandbox.taxigo.io/v1"
    
    static let id = "id"
    
    static let authPage = "https://user.taxigo.com.tw/oauth/authorize?app_id=<APP_ID>&redirect_uri=<REDIRECT_URI>"
    
    static let appID = "-LKPYysKDcIdNs7CLYa3"
    
    static let redirectUri = "https://dev-user.taxigo.com.tw/oauth/test"
    
    static let appSecret = "ktOg9LHSZeGOIHxrp5beuYjNpacI7nu4xMAf"
    
    static let callBackUrlScheme = "SFAuthenticationExample://"
    
    // NOTE: 應該可以用 params 來拆
    static let authURL = "https://user.taxigo.com.tw/oauth/authorize?app_id=" + "\(appID)" + "&redirect_uri=" + "\(redirectUri)"
    
    static let oauthURL = "https://dev-user.taxigo.com.tw/oauth"
    
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjYzODE0OTMsImtleSI6IlUyRnNkR1ZrWDE5Ty9zdUZsTHR5WitENVIza1FTWjBoaGZ0ZmVVYW44blo1aWVaRmpLKytHbjdoUFMrZTl6M3crTk44dURJQ0RrWlkrRGFuT0xOOHd3PT0iLCJhcHBfaWQiOiItTEtQWXlzS0RjSWROczdDTFlhMyIsImlhdCI6MTUzNDg0NTQ5M30.zA7PfY4Q23_iBQ89M5n8VIpnA5ORqC8QXpuoVzDSBy8"
    
}
