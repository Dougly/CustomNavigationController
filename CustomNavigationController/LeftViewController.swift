//
//  LeftViewController.swift
//  CustomNavigationController
//
//  Created by Douglas Galante on 5/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hit view did appear for LEFT view controller")
    }
    
}
