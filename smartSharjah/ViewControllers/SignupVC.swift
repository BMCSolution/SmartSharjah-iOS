//
//  SignupVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var fullname: TextField!
    @IBOutlet weak var name: TextField!
    @IBOutlet weak var emirates: TextField!
    @IBOutlet weak var license: TextField!
    @IBOutlet weak var address: TextField!
    @IBOutlet weak var phoneno: TextField!
    @IBOutlet weak var email: TextField!
    @IBOutlet weak var password: TextField!
    @IBOutlet weak var confirmPassword: TextField!

    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emiratesTF: UITextField!
    @IBOutlet weak var licenseTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phonenoTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var createaccount: UIButton!
    @IBOutlet weak var logintoexistingaccount: UIButton!
    
    var passT = ""
    var passRT = ""
    


    var originalFrame : CGRect!
    
    var localizationData : [NSDictionary] = []

    override func viewWillAppear(_ animated: Bool) {
        self.originalFrame = self.view.frame
        self.setAllignment()
        self.setNots()
    }

    func setNots()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                let height = self.originalFrame.height - keyboardSize.height + 100
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height )
                self.view.setNeedsDisplay()
                print("View origin: \(self.view.frame.origin.y)")
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame = self.originalFrame
        self.view.setNeedsDisplay()
    }


    func setAllignment()
    {
        self.emailTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.passwordTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.confirmPasswordTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.nameTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        
        self.fullnameTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.emiratesTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.licenseTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.addressTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.phonenoTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        
        //self.emailTF.textAlignment = .left
        //self.passwordTF.textAlignment = .left
        //self.confirmPasswordTF.textAlignment = .left
        //self.nameTF.textAlignment = .left
        
        //self.emiratesTF.textAlignment = .left
        //self.licenseTF.textAlignment = .left
        
        //self.phonenoTF.textAlignment = .left
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTF.delegate = self
        self.passwordTF.isSecureTextEntry = false
        // Do any additional setup after loading the view.
        
        if Utility.isArabicSelected()
        {
        
//        self.passwordTF.attributedPlaceholder = NSAttributedString(string: "كلمة المرور", attributes: [
//            .foregroundColor: UIColor.lightGray,
//            .font: AppFontArabic.bold
//             ])
//
//        self.passwordTF.attributedPlaceholder = NSAttributedString(string: "تأكيد كلمة المرور", attributes: [
//            .foregroundColor: UIColor.lightGray,
//            .font: AppFontArabic.bold
//        ])
        
                    var placeHolder = NSMutableAttributedString()
                    var Name  = "كلمة المرور"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    //self.passwordTF.attributedPlaceholder = placeHolder
        
                    placeHolder = NSMutableAttributedString()
                    Name  = "تأكيد كلمة المرور"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    //self.confirmPasswordTF.attributedPlaceholder = placeHolder
        
                    placeHolder = NSMutableAttributedString()
                    Name  = "اسم المستخدم"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.nameTF.attributedPlaceholder = placeHolder
        
                    placeHolder = NSMutableAttributedString()
                    Name  = "الاسم الكامل"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.fullnameTF.attributedPlaceholder = placeHolder
            
                    placeHolder = NSMutableAttributedString()
                    Name  = "الهوية الإماراتية"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.emiratesTF.attributedPlaceholder = placeHolder
            
                    placeHolder = NSMutableAttributedString()
                    Name  = "رقم الرخصة"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.licenseTF.attributedPlaceholder = placeHolder
            
                    placeHolder = NSMutableAttributedString()
                    Name  = "العنوان"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.addressTF.attributedPlaceholder = placeHolder
            
                    placeHolder = NSMutableAttributedString()
                    Name  = "الهاتف المتحرك"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.phonenoTF.attributedPlaceholder = placeHolder
            
                    //self.fullnameTF.textAlignment = Utility.isArabicSelected() ? .right : .left
                    //self.emiratesTF.textAlignment = Utility.isArabicSelected() ? .right : .left
                    //self.licenseTF.textAlignment = Utility.isArabicSelected() ? .right : .left
                    //self.addressTF.textAlignment = Utility.isArabicSelected() ? .right : .left
                    //self.phonenoTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        
            }
        else
        {
            
                    var placeHolder = NSMutableAttributedString()
                    var Name  = "Password"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.passwordTF.attributedPlaceholder = placeHolder
            
                    placeHolder = NSMutableAttributedString()
                    Name  = "Confirm Password"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.confirmPasswordTF.attributedPlaceholder = placeHolder
            
                    placeHolder = NSMutableAttributedString()
                    Name  = "User Name"
                    placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15.0)])
                    self.nameTF.attributedPlaceholder = placeHolder

        }
        //self.loadLocalization();
        
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
        if(self.getItemFromKey(labelName: "CreateAccount") != -1)
        {
            self.label.text = self.localizationData[self.getItemFromKey(labelName: "CreateAccount")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        
        if(self.getItemFromKey(labelName: "CreateAccountButtonText") != -1)
        {
            self.createaccount.setTitle(self.localizationData[self.getItemFromKey(labelName: "CreateAccountButtonText")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
        if(self.getItemFromKey(labelName: "LoginToExisting") != -1)
        {
        self.logintoexistingaccount.setTitle(self.localizationData[self.getItemFromKey(labelName: "LoginToExisting")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String, for: .normal)
        }
        
        if(self.getItemFromKey(labelName: "UserName") != -1)
        {
            self.nameTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "UserName")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "Email") != -1)
        {
            self.emailTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "Email")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "Password") != -1)
        {
            self.passwordTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "Password")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "ConfirmPassword") != -1)
        {
            self.confirmPasswordTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "ConfirmPassword")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "FullName") != -1)
        {
            self.fullnameTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "FullName")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "EmiratesId") != -1)
        {
            self.emiratesTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "EmiratesId")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "LicenseNo") != -1)
        {
            self.licenseTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "LicenseNo")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "Address") != -1)
        {
            self.addressTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "Address")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        if(self.getItemFromKey(labelName: "Phone") != -1)
        {
            self.phonenoTF.placeholder = self.localizationData[self.getItemFromKey(labelName: "Phone")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        
        //self.emailTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.passwordTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.confirmPasswordTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.nameTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        
        //self.fullnameTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.emiratesTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.licenseTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.addressTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        //self.phonenoTF.textAlignment = Utility.isArabicSelected() ? .right : .left
        
        
        
    
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

    @IBAction func loginBtnPressed(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signupTapped(_ sender: UIButton) {


//              self.nameTF.text = "testvvc"
//              self.passwordTF.text = "Abcd1234!!"
//                self.emailTF.text = "testvvc@gmail.com"
//            self.confirmPasswordTF.text = "Abcd1234!!"
        
        /* @IBOutlet weak var fullnameTF: UITextField!
           @IBOutlet weak var nameTF: UITextField!
           @IBOutlet weak var : UITextField!
           @IBOutlet weak var licenseTF: UITextField!
           @IBOutlet weak var addressTF: UITextField!
           @IBOutlet weak var phonenoTF: UITextField!
           @IBOutlet weak var emailTF: UITextField!
           @IBOutlet weak var passwordTF: UITextField!
           @IBOutlet weak var confirmPasswordTF: UITextField!
         let enterFullUsernameMsg  = "Please enter a valid full name"
         let enterEmiratesIdMsg  = "Please enter a valid emirates id"
         let enterLicenseNoMsg  = "Please enter a valid licence no"
         let enterAddressMsg  = "Please enter a valid address"
         let enterPhoneNoMsg  = "Please enter a valid phone no"
         */
            if (self.fullnameTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid name".localized(), viewController: self)
            }
            else if (self.nameTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid username".localized(), viewController: self)
            }
            else if (self.emiratesTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid emirates id".localized(), viewController: self)
            }
            else if (self.licenseTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid licence no".localized(), viewController: self)
            }
            else if (self.addressTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid address".localized(), viewController: self)
            }
            else if (self.phonenoTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid mobile number".localized(), viewController: self)
            }
            else if (!self.emailTF.text!.isValidEmail()) || self.emailTF.text! == ""
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid email".localized(), viewController: self)
            }
            else if (self.passwordTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter a valid Password".localized(), viewController: self)
            }
            else if (self.confirmPasswordTF.text! == "")
            {
                SetDefaultWrappers().showAlert(info:"Please enter matching Password".localized(), viewController: self)
            }
            else if (self.passwordTF.text! != self.confirmPasswordTF.text!)
            {
                SetDefaultWrappers().showAlert(info:"Password & Confirm Password do not match".localized(), viewController: self)
            }
            else
            {
                if (validatePass())
                {
                    
                    
                    /*"userName": "Rahim.Khawaja",
                    "passWord": "Rahim1234",
                    "fullName": "Rahim Khawaja",
                    "emirateID": "0123",
                    "licenseNo": "0123",
                    "emailAddr": "rahim.khawaja@bmcsolution.com",
                    "addressHome": "",
                    "pictureUrl": "/Userimage/bh_connect_logo.png",
                    "phoneNo": ""*/
                    let headers = [
                        "Content-Type": "application/json"
                    ]
                        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
                                    APILayer().postDataToAPINewInsertUser(name: "UserSignup", method: .post, path: "api/Registration/UserSignUp", params: ["userName":self.nameTF.text!, "passWord": self.passwordTF.text!
                                    ,"fullName": self.fullnameTF.text!
                                    ,"emirateID": self.emiratesTF.text!
                                    ,"licenseNo": self.licenseTF.text!
                                    ,"emailAddr": self.emailTF.text!
                                    ,"addressHome": self.addressTF.text!
                                    ,"pictureUrl": ""
                                    ,"phoneNo": self.phonenoTF.text!], headers: headers) { (success, response) in
                                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                        print ("------Success: \(success)")

                                        if (success)
                                        {
                                             print ("------Success: \(success)")
                                            
                                                       let userDefaults = UserDefaults.standard
                                                                                            userDefaults.set(self.nameTF.text, forKey: "username")
                                                                                            userDefaults.set(self.nameTF.text, forKey: "fullname")
                                                                                            
                                            
                                                                                            UserDefaults.standard.set(self.emailTF.text!, forKey: "temp_username")
                                                                                            UserDefaults.standard.set(self.passwordTF.text!, forKey: "temp_password")
                                            
                                            if let user = response as? NSDictionary{
                                            
                                                UserDefaults.standard.set(user.object(forKey: "OTP") as? String ?? "", forKey: "OTP")
                                               
                                                UserDefaults.standard.set("False", forKey: "OTPFlag")
                                                
                                               // userDefaults.synchronize()
                                                self.performSegue(withIdentifier: "signupNext", sender: self)
                                                
                                            }
                                                                                            
                                            //self.dismiss(animated: true, completion: nil)
    //                                        let userDefaults = UserDefaults.standard
    //                                        userDefaults.set(self.emailTF.text, forKey: "username")
    //                                        userDefaults.synchronize()
    //                    //                    self.performSegue(withIdentifier: "signupNext", sender: self)
    //
    //                                        APILayer().createNewUser(name: "UserSignup", method: .post , path: "createNewUser/Post", username: self.emailTF.text!, fullName: self.nameTF.text!, emiratesID: "", licenseNo: "", emailAddr: self.emailTF.text!, AddrHome: "", userActStatus: "", headers: [:]) { (success, response) in
    //                                            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
    //                                            print ("Success: \(success)")
    //
    //                                            if (success)
    //                                            {
    //                                                let userDefaults = UserDefaults.standard
    //                                                userDefaults.set(self.emailTF.text, forKey: "username")
    //                                                userDefaults.set(self.nameTF.text, forKey: "fullname")
    //                                                userDefaults.synchronize()
    //
    //                                                UserDefaults.standard.set(self.emailTF.text!, forKey: "temp_username")
    //                                                UserDefaults.standard.set(self.passwordTF.text!, forKey: "temp_password")
    //
    //                                                self.performSegue(withIdentifier: "signupNext", sender: self)
    //                                            }
    //                                            else
    //                                            {
    //                                                SetDefaultWrappers().showAlert(info:"Signup Unsuccessful!".localized(), viewController: self)
    //                                            }
    //                                        }


                                        }
                                        else
                                        {
                                            SetDefaultWrappers().showAlert(info:"Signup Unsuccessful!".localized(), viewController: self)
                                        }
                    }

    //                SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
    //                            APILayer().postDataToAPI(name: "UserSignup", method: .post, path: "createNewCredential/Post", params: ["username":self.emailTF.text!, "password": self.passwordTF.text!], headers: [:]) { (success, response) in
    //                                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
    //                                print ("------Success: \(success)")
    //
    //                                if (success)
    //                                {
    //                                    let userDefaults = UserDefaults.standard
    //                                    userDefaults.set(self.emailTF.text, forKey: "username")
    //                                    userDefaults.synchronize()
    //                //                    self.performSegue(withIdentifier: "signupNext", sender: self)
    //
    //                                    APILayer().createNewUser(name: "UserSignup", method: .post , path: "createNewUser/Post", username: self.emailTF.text!, fullName: self.nameTF.text!, emiratesID: "", licenseNo: "", emailAddr: self.emailTF.text!, AddrHome: "", userActStatus: "", headers: [:]) { (success, response) in
    //                                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
    //                                        print ("Success: \(success)")
    //
    //                                        if (success)
    //                                        {
    //                                            let userDefaults = UserDefaults.standard
    //                                            userDefaults.set(self.emailTF.text, forKey: "username")
    //                                            userDefaults.set(self.nameTF.text, forKey: "fullname")
    //                                            userDefaults.synchronize()
    //
    //                                            UserDefaults.standard.set(self.emailTF.text!, forKey: "temp_username")
    //                                            UserDefaults.standard.set(self.passwordTF.text!, forKey: "temp_password")
    //
    //                                            self.performSegue(withIdentifier: "signupNext", sender: self)
    //                                        }
    //                                        else
    //                                        {
    //                                            SetDefaultWrappers().showAlert(info:"Signup Unsuccessful!".localized(), viewController: self)
    //                                        }
    //                                    }
    //
    //
    //                                }
    //                                else
    //                                {
    //                                    SetDefaultWrappers().showAlert(info:"Signup Unsuccessful!".localized(), viewController: self)
    //                                }
    //            }


                }

        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let dest = segue.destination as? OTPClass
        dest?.v = 0
    }

    func validatePass() -> Bool{


        print("Text: \(self.passwordTF.text!)")
            if (self.passwordTF.text!.count < 8) {
                SetDefaultWrappers().showAlert(info: validatePasswordMsg.localized(), viewController: self)
                    return false
            } else if (!self.passwordTF.text!.containsSmallLetter()) {
                SetDefaultWrappers().showAlert(info: validatePasswordMsg.localized(), viewController: self)
                    return false
            } else if (!self.passwordTF.text!.containsCapitalLetter()) {
                SetDefaultWrappers().showAlert(info:validatePasswordMsg.localized(), viewController: self)
                    return false
            }else if(!self.passwordTF.text!.containsNumber()){
                SetDefaultWrappers().showAlert(info:validatePasswordMsg.localized(), viewController: self)
                    return false
            }else if(!self.passwordTF.text!.containsSpecialCharacter()){
                SetDefaultWrappers().showAlert(info:validatePasswordMsg.localized(), viewController: self)
                    return false
            }

        return true
    }


}


extension SignupVC: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print ("Str: \(string)")
        return true
    }

     
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == self.passwordTF
//        {
//            if (textField.text!.count < 8) {
//                SetDefaultWrappers().showAlert(info: "Password should have 8 characters or more".localized(), viewController: self)
////                return false
//            } else if (!textField.text!.containsSmallLetter()) {
//                SetDefaultWrappers().showAlert(info: "Password should have at least one lower case letter".localized(), viewController: self)
////                return false
//            } else if (!textField.text!.containsCapitalLetter()) {
//                SetDefaultWrappers().showAlert(info:"Password should have at least one upper case letter".localized(), viewController: self)
////                return false
//            }else if(!textField.text!.containsNumber()){
//                SetDefaultWrappers().showAlert(info:"Password should contain at least one digit".localized(), viewController: self)
////                return false
//            }else if(!textField.text!.containsSpecialCharacter()){
//                SetDefaultWrappers().showAlert(info:"Password should contain at least one special character".localized(), viewController: self)
////                return false
//            }
//        }
    }

}
