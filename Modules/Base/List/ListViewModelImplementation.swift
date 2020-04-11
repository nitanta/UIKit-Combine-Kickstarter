//
//  ListViewModelImplementation.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import Foundation
import Combine

class ListViewModelImplementation: ViewModelImplementation, ListViewModel {
    var tap: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    override init() {
        super.init()
    }
}
