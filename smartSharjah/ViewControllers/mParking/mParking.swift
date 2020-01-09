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

class mParking: UIViewController , MFMessageComposeViewControllerDelegate{
    //updatedFiles
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var NavBar: NavBar!
    @IBOutlet weak var plateSource: TextField!
    @IBOutlet weak var plateNumber: TextField!
    @IBOutlet weak var durationHrs: TextField!
    @IBAction func sendSmsButtonPressed(_ sender: Any) {

        if(self.plateSource.textField.text == nil || self.plateSource.textField.text == ""){
            var t = "Plate Source Missing"
            if Utility.isArabicSelected()
            {
                t = "مصدر لوحة مفقود"
            }
            
            SetDefaultWrappers().showAlert(info: t, viewController: self)
        }else if(self.plateNumber.textField.text == nil || self.plateNumber.textField.text == ""){
            var t = "Plate Number Missing "
           if Utility.isArabicSelected()
           {
               t = "رقم اللوحة مفقود"
           }
            SetDefaultWrappers().showAlert(info: t, viewController: self)
        }else if(self.durationHrs.textField.text == nil || self.durationHrs.textField.text == ""){
            var t = "Parking Hours Missing "
          if Utility.isArabicSelected()
          {
              t = "ساعات وقوف السيارات في عداد المفقودين"
          }
            SetDefaultWrappers().showAlert(info: t, viewController: self)
        }else{
            
            //print (" \(String(describing: plateSource.textField.text)) -  \(String(describing: plateNumber.textField.text)) \(String(describing: durationHrs.textField.text))")
            
            //print()
            
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body = "\(self.plateSource.textField.text!) \(self.plateNumber.textField.text!) \(self.durationHrs.textField.text!)"
                controller.recipients = ["5566"]
                controller.messageComposeDelegate = self
                
                self.present(controller, animated: true, completion: nil)
            }else{
                var t = "SMS sending Service Unavailable"
                if Utility.isArabicSelected()
                {
                    t = "خدمة إرسال الرسائل القصيرة غير متوفرة"
                }
                
                
                SetDefaultWrappers().showAlert(info: t, viewController: self)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            case .cancelled:
                dismiss(animated: true, completion: nil)
            case .failed:
                dismiss(animated: true, completion: nil)
            case .sent:
                dismiss(animated: true, completion: nil)
            default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        Utility.setView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plateNumber.keyboardType = UIKeyboardType.numberPad
        
        if (self.NavBar != nil)
        {
            if Utility.isArabicSelected() {
                NavBar.title.text = "سداد رسوم المواقف"
            } else {
                NavBar.title.text = "Parking Payment"
            }
            self.NavBar.menuSettings(navController: self.navigationController, menuShown: false)
            
            if Utility.isArabicSelected() {
                plateSource.hint = "مصدر لوحة المركبة *"
                plateNumber.hint = "رقم لوحة المركبة *"
                durationHrs.hint = " الوقت بالساعات *"
            } else {
                plateSource.hint = "Plate Source *"
                plateNumber.hint = "Plate Number *"
                durationHrs.hint = "Duration in Hours *"
            }
        }
    }
    
    func getAllTextFields(fromView view: UIView)-> [TextField] {
        return view.subviews.flatMap { (view) -> [TextField]? in
            if view is TextField {
                return [(view as! TextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    
    func validated() -> Bool{
        
        
        
        for x in getAllTextFields(fromView: self.view){
            
            if (!x.validate())
            {
                return false
            }
        }
        
        return true
    }
}
