//
//  ViewController.swift
//  CustomNavigationController
//
//  Created by Douglas Galante on 5/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    var rootVC: UIViewController!
    let childVCContainerView = UIView()
    
    convenience init(rootVC: UIViewController) {
        self.init()
        self.rootVC = rootVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        
        let topBarView = UIView()
        let leftNavButton = UIButton(type: .system)
        let centerItem = UILabel()
        let rightNavButton = UIButton(type: .system)
        
        // View Propertes
        topBarView.backgroundColor = .gray
        childVCContainerView.backgroundColor = .red
        leftNavButton.setTitle("Left", for: .normal)
        rightNavButton.setTitle("right", for: .normal)
        centerItem.text = "TEST"
        
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
        topBarView.addSubview(centerItem)
        topBarView.addSubview(rightNavButton)
        
        centerItem.translatesAutoresizingMaskIntoConstraints = false
        leftNavButton.translatesAutoresizingMaskIntoConstraints = false
        rightNavButton.translatesAutoresizingMaskIntoConstraints = false
        
        centerItem.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor).isActive = true
        centerItem.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
        centerItem.heightAnchor.constraint(equalTo: topBarView.heightAnchor).isActive = true
        centerItem.widthAnchor.constraint(equalTo: centerItem.heightAnchor).isActive = true
        
        leftNavButton.leadingAnchor.constraint(equalTo: topBarView.leadingAnchor).isActive = true
        leftNavButton.trailingAnchor.constraint(equalTo: centerItem.leadingAnchor).isActive = true
        leftNavButton.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        leftNavButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        
        rightNavButton.leadingAnchor.constraint(equalTo: centerItem.trailingAnchor).isActive = true
        rightNavButton.trailingAnchor.constraint(equalTo: topBarView.trailingAnchor).isActive = true
        rightNavButton.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        rightNavButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
    
    }


}

