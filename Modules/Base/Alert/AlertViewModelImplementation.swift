//
//  AlertViewModelImplementation.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/30/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import Combine

class AlertViewModelImplementation: ViewModelImplementation, AlertViewModel {
    var text: CurrentValueSubject<String?, Never> = CurrentValueSubject("Something seems wrong")
    var topAction: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    var bottomAction: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    var topText: CurrentValueSubject<String, Never> = CurrentValueSubject("Okay")
    var bottomText: CurrentValueSubject<String, Never> = CurrentValueSubject("Try again")
    var hideBottom: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    
    init(topTap: (() -> Void)?, bottomTap: (() -> Void)?) {
        super.init()
        topAction.sink { (_) in
            topTap?()
        }.store(in: &bag)
        bottomAction.sink { (_) in
            bottomTap?()
        }.store(in: &bag)
    }
}
