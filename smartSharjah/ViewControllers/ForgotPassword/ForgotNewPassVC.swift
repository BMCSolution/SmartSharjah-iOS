//
//  ForgotNewPassVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 18/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ForgotNewPassVC: UIViewController {

    @IBOutlet weak var pass2: UITextField!
    @IBOutlet weak var pass1: UITextField!
    @IBOutlet weak var navBar: NavBar!
     var username:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (self.navBar != nil)
        {
            navBar.title.text = "New Password"
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
    }
    
    @IBAction func submitPassword(_ sender: UIButton) {
        
        
        if (pass1.text! == pass2.text! && pass1.text != "")
        {
            APILayer().postDataToAPI(name: "User", method: .post, path: "UpdateUserCredential?userName=\(username!)", params: ["username":self.username!, "password":  self.pass1.text! ] as! [String: Any], headers: [:]) { (success, response) in
                
                if (success){
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
                else
                {
                    SetDefaultWrappers().showAlert(info:"Update Unsuccessful!", viewController: self)
                }
            }
        }
        
//        self.navigationController?.dismiss(animated: true, completion: nil)
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
