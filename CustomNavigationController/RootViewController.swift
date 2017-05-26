//
//  RootViewController.swift
//  CustomNavigationController
//
//  Created by Douglas Galante on 5/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let label = UILabel()
        self.view.addSubview(label)
        label.frame = view.frame
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 23)
        label.text = "CENTER"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hit viewWillAppear for RootViewController")
    }
}
