//
//  FilterManager.swift
//  Book share
//
//  Created by Amnil on 7/9/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import GoogleMaps


class FilterManager {
    
    static let sharedInstance: FilterManager = FilterManager()
    var location: BehaviorRelay<CLLocationCoordinate2D?> = BehaviorRelay(value:CLLocationCoordinate2D(latitude: 27.650540, longitude: 85.331396))
    var category: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var availableFrom: BehaviorRelay<String?> = BehaviorRelay(value:nil)
    var availableTo: BehaviorRelay<String?> = BehaviorRelay(value:nil)
    var sortBy: BehaviorRelay<String?> = BehaviorRelay(value:nil)
    var condition: BehaviorRelay<String?> = BehaviorRelay(value:nil)
    private init(){
    }
}
