//
//  Font.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/30/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import UIKit

struct FontStyle {
    static let Bold       = "Poppins-Bold"
    static let Light      = "Poppins-Light"
    static let Medium     = "Poppins-Medium"
    static let Regular    = "Poppins-Regular"
    static let SemiBold   = "Poppins-SemiBold"
}


struct AppFont {
    static let Font14 = UIFont(name: FontStyle.Medium, size: 14)
    static let Font12 = UIFont(name: FontStyle.Medium, size: 12)
    static let Font16 = UIFont(name: FontStyle.Medium, size: 16)
    static let Font18 = UIFont(name: FontStyle.Medium, size: 18)
    static let Font20 = UIFont(name: FontStyle.Medium, size: 20)
    static let Font24 = UIFont(name: FontStyle.Medium, size: 24)
    static let Font10 = UIFont(name: FontStyle.Medium, size: 10)
    
    static let FontRegular10 = UIFont(name: FontStyle.Regular, size: 10)
    static let FontRegular16 = UIFont(name: FontStyle.Regular, size: 16)
    static let FontRegular12 = UIFont(name: FontStyle.Regular, size: 12)
    static let FontRegular14 = UIFont(name: FontStyle.Regular, size: 14)
    
    static let FontSemi10 = UIFont(name: FontStyle.SemiBold, size: 10)
    static let FontSemi16 = UIFont(name: FontStyle.SemiBold, size: 16)
    static let FontSemi12 = UIFont(name: FontStyle.SemiBold, size: 12)
    static let FontSemi14 = UIFont(name: FontStyle.SemiBold, size: 14)
    
    static let FontBold18 = UIFont(name: FontStyle.Bold, size: 18)
    static let FontBold20 = UIFont(name: FontStyle.Bold, size: 20)
    static let FontBold16 = UIFont(name: FontStyle.Bold, size: 16)
    static let FontBold10 = UIFont(name: FontStyle.Bold, size: 10)
    static let FontBold12 = UIFont(name: FontStyle.Bold, size: 12)
    static let FontBold14 = UIFont(name: FontStyle.Bold, size: 14)
}
