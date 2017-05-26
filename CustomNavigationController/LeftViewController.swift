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
        let label = UILabel()
        self.view.addSubview(label)
        label.frame = view.frame
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 23)
        label.text = "LEFT"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hit view did appear for LEFT view controller")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("hit view will disappear for LEFT view controller")
    }
    
}
