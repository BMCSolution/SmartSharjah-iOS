//
//  mParking.swift
//  smartSharjah
//
//  Created by OzzY on 10/6/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
class mParking: UIViewController
, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource , MFMessageComposeViewControllerDelegate{
  
    @IBOutlet weak var NavBar: NavBar!
    
    @IBOutlet weak var plateSource: UITextField!
    @IBOutlet weak var plateNumber: UITextField!
    @IBOutlet weak var durationHrs: UITextField!
    var pS = ["SHJ","AUD","DXB","AJM","UAQ","FUJ","RAK"]
    var hD = ["One Hour","Two Hours","Three Hours","Four Hours"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.NavBar != nil)
        {
            if Utility.isArabicSelected() {
                NavBar.title.text = "دفع وقوف السيارات"
            } else {
                NavBar.title.text = "Parking Payment"
            }
            
            self.NavBar.menuSettings(navController: self.navigationController, menuShown: false)
            
            if Utility.isArabicSelected() {
                plateSource.placeholder = "Plate Source"
                plateNumber.placeholder = "Plate Number"
                durationHrs.placeholder = "Duration in Hours"
            } else {
                plateSource.placeholder = "Plate Source"
                plateNumber.placeholder = "Plate Number"
                durationHrs.placeholder = "Duration in Hours"
            }
            
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if(self.plateSource.text == nil || self.plateSource.text == ""){
            SetDefaultWrappers().showAlert(info:"Plate Source Missing !", viewController: self)
        }else if(self.plateNumber.text == nil || self.plateNumber.text == ""){
            SetDefaultWrappers().showAlert(info:"Plate Number Missing !", viewController: self)
        }else if(self.durationHrs.text == nil || self.durationHrs.text == ""){
            SetDefaultWrappers().showAlert(info:"Parking Hours Missing !", viewController: self)
        }else{
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body = " \(String(describing: plateSource.text)) -  \(String(describing: plateNumber.text)) \(String(describing: durationHrs.text))"
                controller.recipients = ["5566"]
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            if(true){
                return pS.count
            }else{
                return hD.count
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            if(true){
                self.view.endEditing(true)
                return pS[row]
            }else{
                self.view.endEditing(true)
                return hD[row]
            }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if(true){
                self.plateSource.text = self.pS[row]
                //self.plateSourcePicker.isHidden = true
            }
    
            if(true){
                self.durationHrs.text = self.hD[row]
                //self.parkingHoursPicker.isHidden = true
            }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == self.plateSource {
                //self.plateSourcePicker.isHidden = false
                textField.endEditing(true)
            }

            if textField == self.durationHrs {
                //self.parkingHoursPicker.isHidden = false
                textField.endEditing(true)
            }
     }
    
}

