//
//  NewUserRegistrationVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/27/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class NewUserRegistrationVC: UIViewController {

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtVerifyPassword: UITextField!
    @IBOutlet weak var txtMobileNum: UITextField!
    @IBOutlet weak var txtEmiratesID: UITextField!
    @IBOutlet weak var switchTermsConditions: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        txtFullName.delegate = self
        txtEmailAddress.delegate = self
        txtPassword.delegate = self
        txtVerifyPassword.delegate = self
        txtMobileNum.delegate = self
        txtEmiratesID.delegate = self
        // Delegates for hiding the keyboard when tapped outside.
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name, object: nil)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name, object: nil)
        
        // Delegates for adjusting keyboard if textfield is behind it.
    }
    
    @IBAction func createNewAccountPress(_ sender: Any) {
        if ( self.switchTermsConditions.isOn) {
            // OK
            SetDefaultWrappers().showAlert(info:"Account Successfully Created", viewController: self)
            
        } else {
            SetDefaultWrappers().showAlert(info:"You must agree to Smart Sharjah Terms & Conditions", viewController: self)
        }
    }
    
    
    @objc func keyboardWillShow(notification: Notification){
        view.frame.origin.y = -300
    }
    
    @objc func keyboardWillHide(notification: Notification){
        view.frame.origin.y = -300
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

extension NewUserRegistrationVC : UITextFieldDelegate{
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == txtFullName) {
            //self.dismissKeyboard()
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            //NSLog("COnsult 1")
            //self.picker1Outlet.showsSelectionIndicator = true
            //self.picker1Outlet.isHidden = false
            //self.picker2Outlet.isHidden = true
        } else if (textField == txtEmailAddress) {
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            //NSLog("COnsult 1")
            
        } else if (textField == txtPassword) {
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            //NSLog("COnsult 1")
            
        } else if (textField == txtVerifyPassword) {
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            //NSLog("COnsult 1")
            
        } else if (textField == txtMobileNum) {
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            //NSLog("COnsult 1")
            
        } else if (textField == txtEmiratesID) {
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            //NSLog("COnsult 1")
            
        }
    }
}
