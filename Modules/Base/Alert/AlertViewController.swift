//
//  AlertViewController.swift
//  Book share
//
//  Created by Nitanta Adhikari on 3/30/19.
//  Copyright © 2019 The K Tech. All rights reserved.
//

import UIKit
import Combine

class AlertViewController: ViewController {
    var vm: AlertViewModel!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBAction func topTapped(_ sender: Any) {
        vm.topAction.send()
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var bottomButton: UIButton!
    @IBAction func bottomTapped(_ sender: Any) {
        vm.bottomAction.send()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.isOpaque = false
        self.view.backgroundColor = Color.dark.withAlphaComponent(0.80)
        self.backgroundImageView.backgroundColor = UIColor.clear
    }
    
    override func bind() {
        super.bind()
    }
    
    override func setupObservers() {
        super.setupObservers()
        
        vm.text.sink { (value) in
            self.textLabel.text = value
        }.cancel()
        
        vm.bottomText.sink { (value) in
            self.bottomButton.setTitle(value, for: .normal)
        }.cancel()
        
        vm.topText.sink { (value) in
            self.topButton.setTitle(value, for: .normal)
        }.cancel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
