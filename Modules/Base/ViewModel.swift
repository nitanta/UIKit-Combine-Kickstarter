//
//  ViewModel.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import Foundation
import Combine

protocol ViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var snackBar: CurrentValueSubject<String?, Never> { get }
    var logout: PassthroughSubject<Void, Never> { get }
    var alertViewModel: PassthroughSubject<AlertViewModel, Never> { get }
}
