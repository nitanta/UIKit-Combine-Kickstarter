//
//  OptionsManager.swift
//  Book share
//
//  Created by Nitanta Adhikari on 7/28/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

class OptionsManager {
    
    static let sharedInstance: OptionsManager = OptionsManager()
    var shouldShow: BehaviorRelay<Bool?> = BehaviorRelay(value:false)
    private init(){
    }
}
