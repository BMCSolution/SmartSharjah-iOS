//
//  OTPClass.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 11/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class OTPClass: UIViewController {

    var v:Int!
    var number:Int!
    var mobileNum:String!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var entryField: TextField!
    @IBOutlet weak var label: UILabel!
    var code:String!
    var methodName:String!
    var apiUrl:String!
    @IBOutlet weak var resendOTPBtn: UIButton!
    
     var time = 20
    var isResendPressed: Bool!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.isResendPressed = nil
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let name = User().getUserData(field: User().OTP_key) as? String{
            self.code = name
            
        }
        else{
            self.code = ""
        }
        
        self.entryField.textField.delegate = self
        if (self.navBar != nil)
        {
            var v = "Verifications"
            if Utility.isArabicSelected()
            {
                v = "التحقق"
            }
            
            navBar.title.text = v
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        self.entryField.textField.text = self.code
       // v = 2
        if (v == 2)
        {
            var t = "Enter the OTP received on your mobile number"
            
            var e = "Enter the OTP code here"

            if Utility.isArabicSelected()
            {
                t = " OTP يرجى ادخال كود"
                e = "ادخل كود OTP هنا"
            }
            self.startTimer()
            self.label.text = t
            //self.entryField.hintLbl.text = e
            self.entryField.textField.text = self.code
        }
        else{
            var t = "Enter the OTP code here"
            if Utility.isArabicSelected()
            {
                //t = "ادخل رقم الهاتف المتحرك"
                t = "ادخل كود OTP هنا"
            }
            self.label.text = t
            self.entryField.hintLbl.text = t
            
            self.startTimer()
        }

        
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        
        //self.entryField.textField.text = self.code
        //self.entryField.textField.text = "1234"
        if (sender.tag != 200)
        {
            self.isResendPressed = nil
            if validateNumber(text: self.entryField.textField.text!)
            {
                self.apiCall()
            }
            
        }
        else
        {
            if (self.entryField.textField.text! == self.code)
            {
                
                if let usern = UserDefaults.standard.value(forKey: "username") as? String{
                    
                    if let fullname =  UserDefaults.standard.value(forKey: "fullname") as? String{
                        
                        
                        if let otpFlag = User().getUserData(field: User().OTPFlag_key) as? String{
                        
                            if(otpFlag == "True")
                            {
                                self.methodName = "loginotp"
                               self.apiUrl = "api/WebApi/VerifyOTP"
                            }else{
                                  self.methodName = "signupotp"
                            self.apiUrl = "api/Registration/VerifyOTP"
                              }
                           
                               
                        
                        }
                               
                        
                    
                        APILayer().getOTPSMSNew(name: self.methodName, method: .post, path: self.apiUrl, params: ["OTP":self.entryField.textField.text, "UserName":usern,  "DeviceUDID":Utility.getUdid()] , headers: [:]) { (success, response) in
//                        APILayer().postDataToAPI(name: "User", method: .post, path: "updateUserInfo/Post?userName=\(usern)", params: ["emailAddr":usern, "username":usern,  "userActStatus":1, "phoneNo":  self.mobileNum! , "fullName": fullname] as! [String: Any], headers: [:]) { (success, response) in
                        
                        if (success){
//                            self.editable = !self.editable
//                            self.tableView.reloadData()
                            let username = UserDefaults.standard.object(forKey: "temp_username") as? String
                            let password = UserDefaults.standard.object(forKey: "temp_password") as? String
                             self.performSegue(withIdentifier: "backtologin", sender: self)
//                            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
//
//                            APILayer().postDataToAPI(name: "UserLogin", method: .post, path: "verifyCredential/Post?username=\(username!)&password=\(password!)", params: ["username":username!, "password":password!], headers: [:]) { (success, response) in
//                                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
//                                print ("Success: \(success)")
//
//                                if (success)
//                                {
//                                    let userDefaults = UserDefaults.standard
//                                    userDefaults.set(username!, forKey: "username")
//                                    userDefaults.set(true, forKey: "rememberMe")
//                                    userDefaults.synchronize()
//                                    self.performSegue(withIdentifier: "signupNext", sender: self)
//
////                                    self.performSegue(withIdentifier: "loginNext", sender: self)
//
//                                }
//                                else
//                                {
//                                    SetDefaultWrappers().showAlert(info:"Login unsuccessful!", viewController: self)
//                                }
//
//
//                            }
                        }
                        else
                        {
                            
                            
                            SetDefaultWrappers().showAlert(info:"Update unsuccessful!", viewController: self)
//                            self.editable = !self.editable
//                            self.tableView.reloadData()
                        }
                    }
                    
                }
                
            }
            else
            {
                var m = "Invalid Code"
                if Utility.isArabicSelected()
                {
                    m = "الرمز غير صحيح"
                }
                SetDefaultWrappers().showAlert(info: m, viewController: self)
            }
        }else
        {
           var m = "Invalid Code"
           if Utility.isArabicSelected()
           {
               m = "الرمز غير صحيح"
           }
            SetDefaultWrappers().showAlert(info: m, viewController: self)
        }
        }
        
    }
    
    
    
    func apiCall() {
        

//        APILayer
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        

        APILayer().getOTPSMS(name: "otp", method: .post, path: "sendOTPSMS/sendOTP?mobileNum="+self.entryField.textField.text!, params: [:], headers: [:]) { (status, responseCode) in
            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
            self.code = responseCode
            //SetDefaultWrappers().showAlert(info:"OTP sent Successfully to your number!", viewController: self)
            
            if status
            {
                // create the alert
                
                var m = "OTP sent successfully to your number!"
                if Utility.isArabicSelected()
                {
                    m = "تم إرسال رمز التحقق الى رقمك بنجاح"
                }
                let alert = UIAlertController(title: SMART_SHARJAH.localized(), message: m, preferredStyle: UIAlertController.Style.alert)
                
                // add the actions (buttons)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    
                    //                if let topVC = UIApplication.getTopViewController()
                    //                {
                    //
                    if self.isResendPressed == nil
                    {
                        self.performSegue(withIdentifier: "signupNext", sender: self)
                    }
                    //                    if topVC != self
                    //                    {
                    //                        print("hello....******")
                    //                        self.performSegue(withIdentifier: "signupNext", sender: self)
                    //                    }
                    //                    else
                    //                    {
                    //                        print("Already presented")
                    //                    }
                    //                }
                    //                else
                    //                {
                    //                    print("Top VC not available")
                    //                }
                    
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                SetDefaultWrappers().showAlert(info:"Request Failed!", viewController: self)
                
            }
            
           
            
            
            
           
            
        }
        
    }
    
    @objc func startTimer()
    {
        if time > 0
        {
            self.resendOTPBtn.isEnabled  = false
            self.resendOTPBtn.setTitle("RETRY...\(self.time)", for: .normal)
            var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: ["timer":"SMS20"], repeats: false)
            time -= 1
        }
        else
        {
            self.resendOTPBtn.setTitle("Resend OTP", for: .normal)
             self.resendOTPBtn.isEnabled = true
            self.time = 20
            //self.codeBtn.isEnabled = true
        }
    }
    
    @IBAction func resendPressed(_ sender: UIButton) {
        self.isResendPressed = true
    
                              if let username =  UserDefaults.standard.value(forKey: "username") as? String{
                                  
                                  
                                  if let otpFlag = User().getUserData(field: User().OTPFlag_key) as? String{
                                  
                                      if(otpFlag == "True")
                                      {
                                          self.methodName = "logingetnewotp"
                                         self.apiUrl = "api/WebApi/sendOTP"
                                      }else{
                                            self.methodName = "getnewotp"
                                      self.apiUrl = "api/Registration/sendOTP"
                                        }
                                     
                                         
                                  
                                  }
                        
                                  APILayer().getNewOtp(name: self.methodName, method: .post, path: self.apiUrl, params: ["UserName":username] , headers: [:]) { (success, response) in
         
                                  if (success){
        

          if let user = response as? NSDictionary{
          
            self.code = user.object(forKey: "OTPCode") as? String ?? ""
              self.entryField.textField.text = user.object(forKey: "OTPCode") as? String ?? ""
             
             
              
          }
                                  }
                                  else
                                  {
                                      
                                      
                                      SetDefaultWrappers().showAlert(info:"Update unsuccessful!", viewController: self)
        
                                  }
                              }
                              
                          }
        
//       if self.mobileNum != ""
//       {
//        if validateNumber(text: self.mobileNum)
//        {
//            self.apiCall()
//        }
//
//        }
        
       
        
    }
    
    
//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let dest = segue.destination as? OTPClass
        {
            dest.v = 2
            dest.code = self.code
            dest.mobileNum = self.entryField.textField.text!
            dest.isResendPressed = nil
        }
        
        
    }

    
    func validateNumber(text: String) -> Bool
    {
        print("Prefix: \(text.prefix(2))")
        if text == ""
        {
            SetDefaultWrappers().showAlert(info: "Invalid Phone number (e.g: 971XXXXXXXXX)".localized(), viewController: self)
                       return false
        }
        else if text.prefix(2) != "97"
        {
            SetDefaultWrappers().showAlert(info: "Invalid Phone number (e.g: 971XXXXXXXXX)".localized(), viewController: self)
            return false
        }
        return true
    }

}

extension OTPClass: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
       
        
        
        
        
        if self.entryField.tag == 10
        {
            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
//            if textField.text!.count == 2 && textField.text != "97"
//            {
//                textField.text = ""
//                SetDefaultWrappers().showAlert(info: "Invalid Phone number (e.g: 971XXXXXXXXX)".localized(), viewController: self)
//                return false
//            }
//            else
//            {
                return newString.length <= maxLength
//            }
        }
        return true
    }
}
