//
//  ViewModelImplementation.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import Foundation
import UIKit
import Combine

class ViewModelImplementation: ViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var snackBar: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
    var logout: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    var alertViewModel: PassthroughSubject<AlertViewModel, Never> = PassthroughSubject<AlertViewModel, Never>()
    init() {

    }
}
