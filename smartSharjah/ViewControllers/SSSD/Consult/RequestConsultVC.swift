//
//  RequestConsultVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class RequestConsultVC: UIViewController {

    
    @IBOutlet weak var navBar: NavBar!
    
    @IBOutlet weak var consultFNameTxtOutlet: UITextField!
    
    @IBOutlet weak var consultMobNotxtOutlet: UITextField!
    
    @IBOutlet weak var consultCatTxtOutlet: UITextField!
    
    @IBOutlet weak var consultCat2TxtOutlet: UITextField!
    
    @IBOutlet weak var consultDetailsTxtOutlet: UITextField!
    
    @IBOutlet weak var picker1Outlet: UIPickerView!
    
    @IBOutlet weak var picker2Outlet: UIPickerView!
    
    @IBOutlet weak var SubmitConsultBtn: UIButton!
    
    // new Design outlets
    
    @IBOutlet weak var fullName: TextField!
    @IBOutlet weak var mobileNumber: TextField!
    @IBOutlet weak var conCategory: TextField!
    @IBOutlet weak var conType: TextField!
    @IBOutlet weak var conDetails: TextField!
    
    
    
    
    var consultCategory = ["MEDICAL","SOCIAL","LEGAL","PSYCHOLOGICAL"]
    
    var consultType = ["FAMILY","ELDERLY PEOPLE","YOUTH","CHILDREN"]

    
    
    
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
    
    func fillData()
    {
        let user = User().getUser()
        
        if let name  = user.value(forKey: User().name_Key) as? String
        {
            self.fullName.textField.text = name
        }
        if let num  = user.value(forKey: User().mobileNumber_key) as? String
        {
            self.mobileNumber.textField.text = num
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        consultFNameTxtOutlet.delegate = self
        consultMobNotxtOutlet.delegate = self
        //self.fullName.textField.isEnabled = false
        //self.mobileNumber.textField.isEnabled = false
        self.fillData()
        consultCatTxtOutlet.delegate = self
        consultCat2TxtOutlet.delegate = self
        consultDetailsTxtOutlet.delegate = self
        
        
        self.picker1Outlet.isHidden = true
        self.picker2Outlet.isHidden = true
        
        self.SubmitConsultBtn.layer.cornerRadius = 15
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                fullName.hint = "الاسم بالكامل *"
                mobileNumber.hint = "رقم الهاتف المحمول *"
                conCategory.hint = "فئة التشاور *"
                conType.hint = "نوع التشاور *"
                conDetails.hint = "تفاصيل التشاور *"
                self.navBar.title.text = "خدمات استشارية"
                
                conCategory.options = "الطبية ,الاجتماعية,القانونية ,النفسية"
                conType.options = "العائلة , كبار السن , الشباب , الأطفال"
            } else {
                
                conCategory.options = "MEDICAL,SOCIAL,LEGAL,PSYCHOLOGICAL"
                conType.options = "FAMILY,ELDERLY PEOPLE,YOUTH,CHILDREN"
                self.navBar.title.text = "Consultation Services"
            }
            mobileNumber.textField.keyboardType = .numberPad
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
//        self.navBar.title.text = "Request a Consultation"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        Utility.setView()
        self.picker1Outlet.isHidden = true
        self.picker2Outlet.isHidden = true
    }
    
    @IBAction func SubmitBtnPress(_ sender: Any) {
        
        if self.validated()
        {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
             self.navigationController?.popToRootViewController(animated: true)
        }
       
    }
    
    func addPickerInitial()
    {
        let picker1 = UIPickerView()
        picker1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker1)
        
        picker1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

extension RequestConsultVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == consultCatTxtOutlet)
        {
            //self.dismissKeyboard()
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            NSLog("COnsult 1")
            //self.picker1Outlet.showsSelectionIndicator = true
            self.picker1Outlet.isHidden = false
            self.picker2Outlet.isHidden = true
        }
        else if (textField == consultCat2TxtOutlet)
        {
            self.resignFirstResponder()
            self.hideKeyboardWhenTappedAround()
            NSLog("COnsult 2")
            self.picker1Outlet.isHidden = true
            self.picker2Outlet.isHidden = false
        }
        else
        {
            self.picker1Outlet.isHidden = true
            self.picker2Outlet.isHidden = true
            
            NSLog("Consult Others")
        }
    }
}
extension RequestConsultVC : UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == picker1Outlet
        {
            return consultCategory.count
        }
        else
        {
            return consultType.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1Outlet
        {
             return consultCategory[row]
        }
        else
        {
            return consultType[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == picker1Outlet
        {
            self.consultCatTxtOutlet.text = consultCategory[row]
            self.picker1Outlet.isHidden = true
            self.picker2Outlet.isHidden = true
            self.resignFirstResponder()
        }
        else
        {
            self.consultCat2TxtOutlet.text = consultType[row]
            self.picker1Outlet.isHidden = true
            self.picker2Outlet.isHidden = true
            self.resignFirstResponder()
        }
    }
}
