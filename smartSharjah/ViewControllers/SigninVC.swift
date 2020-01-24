//
//  SigninVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class SigninVC: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var password: TextField!
    @IBOutlet weak var email: TextField!
    
    @IBOutlet weak var checkbox: UIImageView!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var remember: UIButton!
    @IBOutlet weak var forgotpassword: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var loginasguest: UIButton!
    @IBOutlet weak var createnewaccount: UIButton!
    
    var checkedStatus = false
    
    var tempPassword = ""
    var originalFrame : CGRect!
    var localizationData : [NSDictionary] = []
    let isArabicSelected = Utility.isArabicSelected()
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.setAlignment()
        self.originalFrame = self.container.frame
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadLocalization();
        if Utility.isArabicSelected()
        {
            self.passwordTF.textContentType = .password
            self.passwordTF.isSecureTextEntry = true
        }
        
        let down = UISwipeGestureRecognizer(target : self, action : #selector(downSwipe))
        down.direction = .down
        self.view.addGestureRecognizer(down)
        self.passwordTF.delegate = self
        
        
        if Utility.isArabicSelected()
              {
//               self.passwordTF.attributedPlaceholder = NSAttributedString(string: "كلمة المرور", attributes: [
//                   .foregroundColor: UIColor.lightGray,
//                   .font: UIFont.systemFont(ofSize: 15.0) ])

                var placeHolder = NSMutableAttributedString()
                var Name  = "كلمة المرور"
                       
                // Set the Font
                placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])

               
                self.passwordTF.attributedPlaceholder = placeHolder
                
                placeHolder = NSMutableAttributedString()
                Name  = "اسم المستخدم"
                placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                self.emailTF.attributedPlaceholder = placeHolder
                
               }
               else
               {
                
                
                var placeHolder = NSMutableAttributedString()
                 var Name  = "Password"
                        
                 // Set the Font
                 placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])

                
                 self.passwordTF.attributedPlaceholder = placeHolder
                
                
                placeHolder = NSMutableAttributedString()
                Name  = "User Name"
                placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                self.emailTF.attributedPlaceholder = placeHolder
                
//                   self.passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
//                       .foregroundColor: UIColor.lightGray,
//                       .font: UIFont.systemFont(ofSize: 15.0) ])

                   
               }
        
        
    }
    
    @objc func downSwipe()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.container.frame.origin.y == 0 {
                let height = self.originalFrame.height - keyboardSize.height + 100
                self.container.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height )
                self.container.setNeedsDisplay()
                 print("View origin: \(self.view.frame.origin.y)")
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.container.frame = self.originalFrame
        self.view.setNeedsDisplay()
    }
    @IBAction func loginAsGuest(_ sender: UIButton) {
    
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "rememberMe")
        userDefaults.removeObject(forKey: "username")
        userDefaults.synchronize()
        History().removeServices()
//        self.performSegue(withIdentifier: "loginNext", sender: self)
        self.performSegue(withIdentifier: "guestLogin", sender: self)
    }
    
    func loadLocalization()
    {

         SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        APILayer().getLocalizationNew(name: "ListLocalization", method: .get, path: "api/LocalizationController/ListLocalizationByScreenName", params: ["ScreenName":"UserProfile"], headers: [:]) { (success, response) in
            
            if (success)
            {
                self.localizationData = (response as? [NSDictionary])!
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                print("success: \(success)")
                if response!.count > 0
                {
                    self.loadingLocalizationData();
                }
            }
            else
            {
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if(response != nil)
                {
                    print("Response: \(response)")
                    SetDefaultWrappers().showAlert(info:"Request Failed!", viewController: self)
                }
            }
        }
    }
    func loadingLocalizationData()
    {
        
        
        if(self.getItemFromKey(labelName: "UserName") != -1)
        {
            self.emailTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "UserName")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "Password") != -1)
        {
            self.passwordTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "Password")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "Yourlogindetails") != -1)
        {
            self.label.text = self.localizationData[self.getItemFromKey(labelName: "Yourlogindetails")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "RememberLogin") != -1)
        {
            self.remember.setTitle(self.localizationData[self.getItemFromKey(labelName: "RememberLogin")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
        if(self.getItemFromKey(labelName: "ForgotPassword") != -1)
        {
            self.forgotpassword.setTitle(self.localizationData[self.getItemFromKey(labelName: "ForgotPassword")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
        if(self.getItemFromKey(labelName: "Login") != -1)
        {
            self.login.setTitle(self.localizationData[self.getItemFromKey(labelName: "Login")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
        if(self.getItemFromKey(labelName: "LoginAsGuest") != -1)
        {
            self.loginasguest.setTitle(self.localizationData[self.getItemFromKey(labelName: "LoginAsGuest")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
        if(self.getItemFromKey(labelName: "CreateAccount") != -1)
        {
            self.createnewaccount.setTitle(self.localizationData[self.getItemFromKey(labelName: "CreateAccount")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
    
    }
    
    func getItemFromKey(labelName: String ) -> Int
    {
        var iterator = 0;
        for obj in self.localizationData {
            if(obj["localizationKey"] as? String == labelName)
            {
                return iterator;
            }
            iterator += 1
        }
        return -1;
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
     
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setAlignment() -> () {
        
        self.emailTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.passwordTF.textAlignment = Utility.isArabicSelected() ? .right : .left
    }
    
    @IBAction func rememberMeBtnPressed(_ sender: UIButton) {
        self.checkedStatus = !self.checkedStatus
        
        if (self.checkedStatus){
            self.checkbox.image = UIImage(named: "checked-blue")!
        }
        else {
            self.checkbox.image = UIImage(named: "unchecked")!
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        //self.emailTF.text = "testinggha@gmail.com"
       //self.passwordTF.text = "Abcd1234!!"
        //self.emailTF.text = "testz"
        //      self.passwordTF.text = "Abcd1234!!"
        
        //) || !(self.emailTF.text!.isValidEmail()
        if (self.emailTF.text! == "")
        {
             SetDefaultWrappers().showAlert(info:"Please enter a valid name".localized(), viewController: self)
        }
        else if (self.passwordTF.text! == ""){
            SetDefaultWrappers().showAlert(info:"Please enter a valid Password".localized(), viewController: self)
        }
        else
        {
            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
//            NetworkHelper().userLogin(email: self.emailTF.text!, password: self.passwordTF.text!) { (success, Object) in
//                if success
//                {
//                    User().setUserJson(d: Object)
//                    let userDefaults = UserDefaults.standard
//                    userDefaults.set(self.checkedStatus, forKey: "rememberMe")
//                    userDefaults.synchronize()
//                }
//                else
//                {
//                    SetDefaultWrappers().showAlert(info:"Invalid Username or Password", viewController: self)
//                }
//            }
//            var pass = self.passwordTF.text!
//            if isArabicSelected
//            {
//                pass = tempPassword
//            }
//            print("Password is : \(pass)")
//            APILayer().postDataToAPI(name: "UserLogin", method: .post, path: "verifyCredential/Post?username=\(self.emailTF.text!)&password=\(self.passwordTF.text!)", params: ["username":self.emailTF.text!, "password": self.passwordTF.text!], headers: [:]) { (success, response) in
//                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
//                print ("Success: \(success)")
            
            
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            
            APILayer().postDataToAPINew(name: "UserLogin", method: .post, path: "AuthenticationTokenService", params: [
                "grant_type":"password",
                "username":self.emailTF.text!,
                "password": self.passwordTF.text!,
                "ServiceTYPE": "login",
                "DeviceDetails": Utility.getDeviceDetail(),
                "DeviceUDID": Utility.getUdid(),
                "DeviceTYPE": "IOS",
                "MobileDateTime": Utility.getMobileDateTime()], headers: headers) { (success, response) in
                           SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                           print ("Success: \(success)")

                if (success)
                {
              
                                                if let user = response as? NSDictionary{
                                                 
                                                    
                                                    let userDefaults = UserDefaults.standard
                                                                       userDefaults.set(self.emailTF.text, forKey: "username")
                                                                       userDefaults.set(self.checkedStatus, forKey: "rememberMe")
                                                    userDefaults.set(user.object(forKey: "fullName") as? String ?? "", forKey: "fullName")
                                                    
                                                    userDefaults.set(user.object(forKey: "emirateID") as? String ?? "", forKey: "emirateID")
                                                                       userDefaults.set(user.object(forKey: "licenseNo") as? String ?? "", forKey: "licenseNo")
                                                                      userDefaults.set(user.object(forKey: "emailAddr") as? String ?? "", forKey: "emailAddr")
                                                                      userDefaults.set(user.object(forKey: "addressHome") as? String ?? "", forKey: "addressHome")
                                                    
                                                    userDefaults.set(user.object(forKey: "phoneNo") as? String ?? "", forKey: "phoneNo")
                                                                     if let val = user.object(forKey: "pictureUrl") as? String  {
                                                                       userDefaults.set(val, forKey: "pictureUrl")
                                                                      } else {
                                                                     userDefaults.set("", forKey: "pictureUrl")
                                                                                                           }

                                                                       userDefaults.synchronize()
                                                    
                                                    History().removeServices()
                                                                       
                                                                       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "profileUpdated"), object: nil)
                                                                                                      self.performSegue(withIdentifier: "loginNext", sender: self)
                                                }
                                                
                    

                   
                   // User().setUserJson(d: response, replaceProfilePic: false)
                   
                    
                   
                    

                }
                else
                {
                    
                    if let user = response as? NSDictionary{
                    
                        if (user.object(forKey: "OTPFlag") as? String == "True")
                        {
                            self.performSegue(withIdentifier: "OtpSignup", sender: self)
                        }else{
                            
                            SetDefaultWrappers().showAlert(info:"Incorrect Username or Password".localized(), viewController: self)
                        }
                       
                        
                        
                    }else{
                        SetDefaultWrappers().showAlert(info:"Incorrect Username or Password".localized(), viewController: self)
                    }
                    
                    
                }
            }
        }
    }
}

extension SigninVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        return true
    }
}
