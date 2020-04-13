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
        super.viewModel = listviewModel
        super.viewDidLoad()
    }
    
    override func setupObservers() {
        super.setupObservers()
        
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
    }
    
    override func bind() {
        super.bind()
        listviewModel.callApi.send(Void())
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        //listviewModel.isLoading.send(true)
        //listviewModel.snackBar.send("This is a snackbar")
        //listviewModel.logout.send(Void())
        //listviewModel.alertViewModel.send(AlertViewModelImplementation(topTap: nil, bottomTap: nil))
    }
}
