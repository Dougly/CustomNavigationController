//
//  RightViewController.swift
//  CustomNavigationController
//
//  Created by Douglas Galante on 5/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("hit view did appear for RIGHT view controller")
    }
}
