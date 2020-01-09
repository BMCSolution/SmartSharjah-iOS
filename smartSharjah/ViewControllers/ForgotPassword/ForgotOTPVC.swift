//
//  ForgotOTPVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 18/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ForgotOTPVC: UIViewController {

    @IBOutlet weak var otpCode: UITextField!
    @IBOutlet weak var navBar: NavBar!
    var code:String!
    var username:String!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        var dest = segue.destination as! ForgotNewPassVC
        dest.username = self.username
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (self.navBar != nil)
        {
            navBar.title.text = "Verifications OTP"
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
    }
    
    @IBAction func verifyOtp(_ sender: UIButton) {
        
        if self.otpCode.text! == self.code{
            
            self.performSegue(withIdentifier: "otpNext", sender: self)
        }
        else{
            SetDefaultWrappers().showAlert(info:"Wrong OTP Code", viewController: self)
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
