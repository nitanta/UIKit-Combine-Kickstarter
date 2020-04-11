//
//  ListViewController.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import UIKit

class ListViewController: ViewController {
    var listviewModel: ListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupObservers() {
        super.viewModel = listviewModel
        super.setupObservers()
        
        let alertVM = AlertViewModelImplementation(topTap: nil) { [weak self] in
            guard let wSelf = self else { return }
            print("Second button tap")
        }
        listviewModel.alertViewModel.send(alertVM)
    }
}
