//
//  ViewController.swift
//  CustomNavigationController
//
//  Created by Douglas Galante on 5/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit


enum Direction {
    case left, right, center
}

// create 3 container views
// add respective VCs to container views
// animate container view constraints based on navigation item selected

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
        self.addViewControllerAsChildViewController(childViewController: rootVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addViewControllerAsChildViewController(childViewController: rootVC)
        setupView()
    }

    
    
    
    func leftNavButtonTapped(_ seder: UIButton) {
        updateContainerView(fromDirection: .center, toDirection: .left)
    }
    
    func rightNavButtonTapped(_ sender: UIButton) {
        updateContainerView(fromDirection: .center, toDirection: .right)
    }
    
    func centerButtonTapped(_ sender: UIButton) {
        updateContainerView(fromDirection: .left, toDirection: .center)
    }
    
    private func updateContainerView(fromDirection: Direction, toDirection: Direction) {
        leftViewController.view.isHidden = true
        rightViewController.view.isHidden = true
        rootVC.view.isHidden = true
        
        switch toDirection {
        case .left:
            self.push(childViewController: leftViewController, fromDirection: .right, toDirection: .left)

            
            
        case .right: rightViewController.view.isHidden = false
        case .center:
            self.push(childViewController: rightViewController, fromDirection: .left, toDirection: .right)
        }
    }
    
    private func push(childViewController: UIViewController, fromDirection: Direction, toDirection: Direction) {
        
        childViewController.view.isHidden = false
        
        
        var startXPosition = UIScreen.main.bounds.width
        
        if toDirection == .left {
            startXPosition *= -1
        }
        
        childViewController.view.frame = CGRect(x: startXPosition, y: 0, width: childVCContainerView.frame.width, height: childVCContainerView.frame.height)

        
        
        UIView.animate(withDuration: 0.5, animations: {
            childViewController.view.frame = CGRect(x: 0, y: 0, width: self.childVCContainerView.frame.width, height: self.childVCContainerView.frame.height)
            self.view.layoutIfNeeded()
        }) { (completion) in
            childViewController.didMove(toParentViewController: self)
        }

    }
    
    private func pop(childViewController: UIViewController) {
        removeViewControllerAsChildViewController(childViewController: childViewController)
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        self.childVCContainerView.addSubview(childViewController.view)
        
        childViewController.view.frame = CGRect(x: 0, y: 0, width: childVCContainerView.frame.width, height: childVCContainerView.frame.height)
        childViewController.view.bounds = childVCContainerView.bounds
        
        
        childViewController.didMove(toParentViewController: self)
        
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
    
    private func setupView() {
        
        
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
        childVCContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        childVCContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

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

