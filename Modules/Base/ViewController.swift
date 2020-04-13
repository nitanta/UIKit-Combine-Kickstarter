//
//  ViewController.swift
//  KickStarter
//
//  Created by ebpearls on 4/11/20.
//  Copyright © 2020 ebpearls. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var width:CGFloat!
    var viewModel: ViewModel!
    var bag: Set<AnyCancellable> = Set()
    
    deinit {
        debugPrint("DEINIT:::: \(String(describing: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
        setupNavigationBar()
        bind()
    }
    
    func setupNavigationBar() {
        
    }
    
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        backgroundImageView = UIImageView()
        backgroundImageView.backgroundColor = Color.background
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.fillSuperView()
        view.sendSubviewToBack(backgroundImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        width = self.view.bounds.size.width
        self.view.backgroundColor = UIColor.white
    }
    
    func setupObservers() {
        guard let viewModel = viewModel else { return }
        viewModel.isLoading.subscribe(on: RunLoop.main).sink { (flag) in
            if flag {
                self.view.endEditing(true)
                self.presentLoader()
            }else{
                self.dismissLoader()
            }
        }.store(in: &bag)
        
        viewModel.alertViewModel.receive(on: DispatchQueue.main).sink { (vm) in
            let vc = AlertViewController.initialize(.main)
            vc.vm = vm
            self.navigationController?.present(vc, animated: true, completion: nil)
        }.store(in: &bag)
        
        viewModel.logout.receive(on: RunLoop.main).sink { (_) in

        }.store(in: &bag)
        
        viewModel.snackBar.subscribe(on: RunLoop.main).filter { $0 != nil }.sink { (value) in
            self.showSnackBar(message: value ?? "")
        }.store(in: &bag)
        
        viewModel.snackBar.subscribe(on: RunLoop.main).delay(for: .seconds(2), scheduler: RunLoop.main).filter { $0 != nil }.sink { (value) in
            self.dismissSnackBar()
        }.store(in: &bag)
        
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    
    func showSnackBar(message: String){
        let wrapperView = UIView(frame: CGRect(x: width * 0.1, y: 120, width: width * 0.8, height: width * 0.15))
        wrapperView.backgroundColor = AppColor.Alpha32
        wrapperView.layer.cornerRadius = 10
        wrapperView.clipsToBounds = true
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 120, height: 120)
        
        let text = UILabel()
        text.numberOfLines = 0
        text.text = message
        text.font = AppFont.Font16
        text.textColor = UIColor.white
        
        let stack = UIStackView(arrangedSubviews: [imageView, text])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = width * 0.02
        
        wrapperView.addSubview(stack)
        wrapperView.tag = 999
        
        stack.anchor(top: wrapperView.topAnchor, paddingTop: 10.0, bottom: wrapperView.bottomAnchor, paddingBottom: 10.0, left: wrapperView.leftAnchor, paddingLeft: 10.0, right: wrapperView.rightAnchor, paddingRight: 10.0, width: 0.0, height: 0.0)
        
        let root  = UIApplication.shared.windows.first!.rootViewController
        root?.view.addSubview(wrapperView)
        
    }
    
    func dismissSnackBar(){
        let root  = UIApplication.shared.windows.first!.rootViewController
        for item in (root?.view.subviews)! {
            if item.tag == 999 {
                item.removeFromSuperview()
            }
        }
    }
    
    func presentLoader(){
        let background = UIView(frame: self.view.bounds)
        background.backgroundColor = UIColor.white.withAlphaComponent(0.30)
        
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        }
        activityIndicator.color = Color.primary
        activityIndicator.hidesWhenStopped = true
        background.addSubview(activityIndicator)
        background.tag = 99
        activityIndicator.center = background.center
        activityIndicator.startAnimating()
        
        let root  = UIApplication.shared.windows.first!.rootViewController
        root?.view.addSubview(activityIndicator)
        
    }
    
    func dismissLoader(){
        let root  = UIApplication.shared.windows.first!.rootViewController
        for item in (root?.view.subviews)! {
            if item.tag == 99 {
                for sub in item.subviews {
                    if let idicator = sub as? UIActivityIndicatorView {
                        idicator.stopAnimating()
                        break
                    }
                }
                item.removeFromSuperview()
            }
        }
    }
}


extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (otherGestureRecognizer is UIScreenEdgePanGestureRecognizer)
    }
}

