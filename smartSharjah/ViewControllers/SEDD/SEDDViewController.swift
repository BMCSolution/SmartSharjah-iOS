//
//  SEDDViewController.swift
//  smartSharjah
//
//  Created by OzzY on 7/18/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit

class SEDDViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBarItems()
    }
    
    func setupNavigationBarItems() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       // navigationController.
    }
}
