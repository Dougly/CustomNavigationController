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


class MasterViewController: UIViewController {

    let topBarView = UIView()
    let leftNavButton = UIButton(type: .system)
    let centerButton = UIButton(type: .system)
    let rightNavButton = UIButton(type: .system)
    var centerX: NSLayoutConstraint?
    
    var rootVC: UIViewController!
    let childVCContainerView = UIView()
    var currentVC: UIViewController!
    
    lazy var leftViewController: LeftViewController = {
        let leftVC = LeftViewController()
        self.addViewControllerAsChildViewController(childViewController: leftVC, isRootVC: false)
        return leftVC
    }()
    
    lazy var rightViewController: RightViewController = {
        let rightVC = RightViewController()
        self.addViewControllerAsChildViewController(childViewController: rightVC, isRootVC: false)
        return rightVC
    }()
    
    convenience init(rootVC: UIViewController) {
        self.init()
        self.rootVC = rootVC
        self.addViewControllerAsChildViewController(childViewController: rootVC, isRootVC: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    
    func leftNavButtonTapped(_ seder: UIButton) {
        updateContainerView(to: .left)
        animatedNavBar(direction: .left)
    }
    
    func rightNavButtonTapped(_ sender: UIButton) {
        updateContainerView(to: .right)
        animatedNavBar(direction: .right)
    }
    
    func centerButtonTapped(_ sender: UIButton) {
        updateContainerView(to: .center)
        animatedNavBar(direction: .center)
    }
    
    private func updateContainerView(to direction: Direction) {
        
        switch direction {
        case .left:
            self.push(newVC: leftViewController, inDirection: .left)
        case .right:
            push(newVC: rightViewController, inDirection: .right)
        case .center:
            if centerButton.center.x > UIScreen.main.bounds.width / 2 {
                push(newVC: rootVC, inDirection: .right)
            } else {
                push(newVC: rootVC, inDirection: .left)

            }
        }
    }
    
    private func push(newVC: UIViewController, inDirection: Direction) {
        
        var startXPosition = UIScreen.main.bounds.width
        if inDirection == .left {
            startXPosition *= -1
        }
        
        newVC.view.frame = CGRect(x: startXPosition, y: 0, width: childVCContainerView.frame.width, height: childVCContainerView.frame.height)

        
        
        UIView.animate(withDuration: 0.5, animations: {
            newVC.view.frame = CGRect(x: 0, y: 0, width: self.childVCContainerView.frame.width, height: self.childVCContainerView.frame.height)
            self.currentVC.view.frame = CGRect(x: startXPosition * -1, y: 0, width: self.childVCContainerView.frame.width, height: self.childVCContainerView.frame.height)
            self.view.layoutIfNeeded()
        }) { (success) in
            if success {
                newVC.didMove(toParentViewController: self)
                self.currentVC = newVC
            }
        }

    }
    
    private func animatedNavBar(direction: Direction) {
        switch direction {
        case .left: animateNavBar(multiplier: 50)
        case .right: animateNavBar(multiplier: -50)
        case .center: animateNavBar(multiplier: 0)
        }
    }
    
    private func animateNavBar(multiplier: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.centerX?.constant = multiplier
            self.view.layoutIfNeeded()
        }
    }
    
   
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController, isRootVC: Bool) {
        addChildViewController(childViewController)
        self.childVCContainerView.addSubview(childViewController.view)
        
        childViewController.view.frame = CGRect(x: 0,
                                                y: 0,
                                                width: childVCContainerView.frame.width,
                                                height: childVCContainerView.frame.height)
        
        
        childViewController.view.bounds = childVCContainerView.bounds
        
        if isRootVC {
            currentVC = childViewController
            childViewController.didMove(toParentViewController: self)
        }
        
    }
    
//    private func removeViewControllerAsChildViewController(childViewController: UIViewController) {
//        childViewController.willMove(toParentViewController: nil)
//        childViewController.view.removeFromSuperview()
//        childViewController.removeFromParentViewController()
//    }
//    
//    private func pop(childViewController: UIViewController) {
//        removeViewControllerAsChildViewController(childViewController: childViewController)
//    }
    
    private func setupView() {
        
        
        
        
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
        
        centerX = centerButton.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor)
        centerX?.isActive = true
        centerButton.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
        centerButton.heightAnchor.constraint(equalTo: topBarView.heightAnchor).isActive = true
        centerButton.widthAnchor.constraint(equalTo: centerButton.heightAnchor).isActive = true
        
        leftNavButton.trailingAnchor.constraint(equalTo: centerButton.leadingAnchor).isActive = true
        leftNavButton.widthAnchor.constraint(equalTo: centerButton.widthAnchor).isActive = true
        leftNavButton.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        leftNavButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        
        rightNavButton.leadingAnchor.constraint(equalTo: centerButton.trailingAnchor).isActive = true
        rightNavButton.widthAnchor.constraint(equalTo: centerButton.widthAnchor).isActive = true
        rightNavButton.topAnchor.constraint(equalTo: topBarView.topAnchor).isActive = true
        rightNavButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
    
    }
}

