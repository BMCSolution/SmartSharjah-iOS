//
//  SettingsVC.swift
//  smartSharjah
//
//  Created by Usman on 01/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var tcView: UIView!
    
    @IBOutlet weak var privacyPolicy_Btn: UIButton!
    @IBOutlet weak var terms_Btn: UIButton!
    
    @IBOutlet weak var navBar: NavBar!
  
    @IBOutlet weak var version_Lbl: UILabel!
    var selectedType: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            if Utility.isArabicSelected()
            {
                navBar.title.text = "الإعدادات"
                self.version_Lbl.text = "الإصدار:\(appVersion)"
            }
            else
            {
                self.version_Lbl.text = "Version:\(appVersion)"
                 navBar.title.text = "Settings"
            }
           
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        let radius: CGFloat = 10.0
        
        self.privacyPolicyView.layer.cornerRadius = radius
        self.tcView.layer.cornerRadius = radius
        // Do any additional setup after loading the view.
    }
    

    @IBAction func privacyBtnPressed(_ sender: UIButton) {
        self.selectedType = "Privacy Policy"
        self.performSegue(withIdentifier: "OpenDetails", sender: self)
    }
    
    
    @IBAction func termsBtnPressed(_ sender: UIButton) {
        self.selectedType = "Terms & Conditions"
        self.performSegue(withIdentifier: "OpenDetails", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenDetails"
        {
            let dest = segue.destination as! PrivacyDetailsVC
            dest.navTitle = self.selectedType
        }
    }

}
