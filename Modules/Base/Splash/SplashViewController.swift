//
//  SplashViewController.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigate()
    }
    
    func navigate() {
        let vc = ListViewController.initialize(.list)
        let vm = ListViewModelImplementation()
        vc.listviewModel = vm
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
