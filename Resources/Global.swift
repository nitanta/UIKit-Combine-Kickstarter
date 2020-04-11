//
//  Global.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/30/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation

struct Global {
    enum Storyboard: String {
        case main = "Main"
        case list = "List"
    }
    
   static var baseUrl: String{
        return "http://173.249.37.107:8282"
    }
}


