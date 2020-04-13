//
//  AlertViewModel.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/30/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import Foundation
import UIKit
import Combine

protocol AlertViewModel:ViewModel {
    var text: CurrentValueSubject<String?, Never> { get }
    var topAction: PassthroughSubject<Void, Never> { get }
    var bottomAction: PassthroughSubject<Void, Never> { get }
    var topText: CurrentValueSubject<String, Never> { get }
    var bottomText: CurrentValueSubject<String, Never> { get }
    var hideBottom: CurrentValueSubject<Bool, Never> { get }
}
