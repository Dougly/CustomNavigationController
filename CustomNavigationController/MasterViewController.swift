//
//  ViewController.swift
//  CustomNavigationController
//
//  Created by Douglas Galante on 5/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

enum NavItem {
    case center, left, right
}

class MasterViewController: UIViewController {

    var rootVC: UIViewController!
    let childVCContainerView = UIView()
    
    lazy var leftViewController: LeftViewController = {
        let leftVC = LeftViewController()
        self.addViewControllerAsChildViewController(childViewController: leftVC)
        return leftVC
    }()
    
    lazy var rightViewController: RightViewController = {
        let rightVC = RightViewController()
        self.addViewControllerAsChildViewController(childViewController: rightVC)
        return rightVC
    }()
    
    convenience init(rootVC: UIViewController) {
        self.init()
        self.rootVC = rootVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewControllerAsChildViewController(childViewController: rootVC)
        setupView()
    }

    
    
    
    func leftNavButtonTapped() {
        updateContainerView(navItem: .left)
    }
    
    func rightNavButtonTapped() {
        updateContainerView(navItem: .right)
    }
    
    func centerButtonTapped() {
        updateContainerView(navItem: .center)
    }
    
    private func updateContainerView(navItem: NavItem) {
        leftViewController.view.isHidden = true
        rightViewController.view.isHidden = true
        rootVC.view.isHidden = true
        
        switch navItem {
        case .left: leftViewController.view.isHidden = false
        case .right: rightViewController.view.isHidden = false
        case .center: rootVC.view.isHidden = false
        }
        
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        self.childVCContainerView.addSubview(childViewController.view)
        
        childViewController.view.frame = self.childVCContainerView.frame
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
    
    private func setupView() {
        
        updateContainerView(navItem: .center)
        
        let topBarView = UIView()
        let leftNavButton = UIButton(type: .system)
        let centerButton = UIButton(type: .system)
        let rightNavButton = UIButton(type: .system)
        
        // View Propertes
        topBarView.backgroundColor = .clear
        childVCContainerView.backgroundColor = .red
        leftNavButton.setTitle("Left", for: .normal)
        leftNavButton.addTarget(self, action: #selector(leftNavButtonTapped), for: .touchUpInside)
        rightNavButton.setTitle("Right", for: .normal)
        rightNavButton.addTarget(self, action: #selector(rightNavButtonTapped), for: .touchUpInside)
        centerButton.setTitle("Center", for: .normal)
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        
        // addSubviews and constraints
        self.view.addSubview(topBarView)
        self.view.addSubview(childVCContainerView)

        topBarView.translatesAutoresizingMaskIntoConstraints = false
        childVCContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBarView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        topBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        childVCContainerView.topAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        childVCContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        childVCContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        childVCContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        topBarView.addSubview(leftNavButton)
        topBarView.addSubview(centerButton)
        topBarView.addSubview(rightNavButton)
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        leftNavButton.translatesAutoresizingMaskIntoConstraints = false
        rightNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        centerButton.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor).isActive = true
        centerButton.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
        centerButton.heightAnchor.constraint(equalTo: topBarView.heightAnchor).isActive = true
        centerButton.widthAnchor.constraint(equalTo: centerButton.heightAnchor).isActive = true
        
        leftNavButton.leadingAnchor.constraint(equalTo: topBarView.leadingAnchor).isActive = true
        leftNavButton.trailingAnchor.constraint(equalTo: centerButton.leadingAnchor).isActive = true
        leftNavButton.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        leftNavButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        
        rightNavButton.leadingAnchor.constraint(equalTo: centerButton.trailingAnchor).isActive = true
        rightNavButton.trailingAnchor.constraint(equalTo: topBarView.trailingAnchor).isActive = true
        rightNavButton.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        rightNavButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
    
    }
}

