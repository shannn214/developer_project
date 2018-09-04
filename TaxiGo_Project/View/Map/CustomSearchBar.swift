//
//  CustomSearchBar.swift
//  TaxiGo_Project
//
//  Created by 尚靖 on 2018/9/4.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        self.cornerRadius = 10
        preferredFont = font
        preferredTextColor = textColor
        
        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0..<searchBarView.subviews.count {
            
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
            
        }
        
        return index
        
    }
    
    override func draw(_ rect: CGRect) {
        
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            
            searchField.frame = CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10)
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.backgroundColor = barTintColor
            
        }
        
        super.draw(rect)
        
    }
    
}
