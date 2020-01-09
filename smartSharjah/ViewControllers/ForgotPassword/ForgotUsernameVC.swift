//
//  ForgotUsernameVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 18/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class ForgotUsernameVC: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var navBar: NavBar!
    var code:String!
    var username:String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var dest = segue.destination as! ForgotOTPVC
        dest.code = self.code
        dest.username = self.username
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "هل نسيت كلمة المرور؟"
            } else {
                navBar.title.text = "Forgot Password?"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
    }
    
    @IBAction func SubmitPressed(_ sender: UIButton) {
        
        if(!self.usernameTF.text!.isValidEmail()) || self.usernameTF.text! == ""
        {
            SetDefaultWrappers().showAlert(info:enterEmailMsg.localized(), viewController: self)
        }
        else
        {
             SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
            APILayer().getDataFromAPI(name: "forgotUsername", method: .get, path: "DataAccess/GetUserProfileDetails?userName='\(self.usernameTF.text!)'", params: [:], headers: [:]) { (success, response) in
                
                if (success)
                {
                    SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                    self.username = self.usernameTF.text!
                    print("success: \(success)")
                    if response!.count > 0
                    {
                        var profile = response!.first!
                        print ("Profile: \(profile)")
                        
                        if let mobileNumber = profile.value(forKey: "phoneNo") as? String{
                            
                            if mobileNumber != ""
                            {
                                APILayer().getOTPSMS(name: "otp", method: .post, path: "sendOTPSMS/sendOTP?mobileNum="+mobileNumber, params: [:], headers: [:]) { (status, responseCode) in
                                    
                                    self.code = responseCode
                                    self.performSegue(withIdentifier: "otpNext", sender: self)
                                }
                            }
                            else
                            {
                                SetDefaultWrappers().showAlert(info:"Mobile Number Not Found", viewController: self)
                            }
                           
                            
                        }
                        else{
                            
                        }
                        
                        //                    if
                    }
                }
                else
                {
                    print("Response: \(response)")
                    SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                     SetDefaultWrappers().showAlert(info:"Request Failed!", viewController: self)
                }
            }
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
