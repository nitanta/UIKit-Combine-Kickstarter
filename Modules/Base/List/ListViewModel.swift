//
//  ListViewModel.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import Foundation
import Combine

protocol ListViewModel:ViewModel {
    var callApi: PassthroughSubject<Void, APIError> { get }
    var albums: CurrentValueSubject<[Album], Never> { get }
    func refresh()
}
