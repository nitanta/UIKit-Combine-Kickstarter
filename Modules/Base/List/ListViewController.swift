//
//  ListViewController.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import UIKit

class ListViewController: ViewController {
    @IBOutlet weak var listTableView: UITableView!
    var listviewModel: ListViewModel!
    
    let refreshControler: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewModel = listviewModel
        super.viewDidLoad()
    }
    
    override func setupObservers() {
        super.setupObservers()
        
    }
    
    override func setupUI() {
        super.setupUI()
        listTableView.refreshControl = refreshControler
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
    
    @objc func refresh() {
        guard let listviewModel = listviewModel else { return }
        listviewModel.refresh()
    }
}
