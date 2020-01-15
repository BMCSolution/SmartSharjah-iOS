//
//  TradeNameVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 04/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class TradeNameVC: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "اسم تجاري"
            } else {
                self.navBar.title.text = "Trade Name Availability"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        // Do any additional setup after loading the view.
    }
}
