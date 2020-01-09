//
//  LegalVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 04/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class LegalVC: UIViewController {

    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var textArea: UITextView!
    var titleString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            navBar.title.text = titleString
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
