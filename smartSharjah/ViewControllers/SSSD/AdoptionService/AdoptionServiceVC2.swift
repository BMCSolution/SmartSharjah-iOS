//
//  AdoptionServiceVC2.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class AdoptionServiceVC2: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var qualificationTF: TextField!
    //@IBOutlet weak var dobTF: TextField!
    
    @IBOutlet weak var dobTF: TextField!
        
    @IBOutlet weak var placeOfBirthTF: TextField!
    @IBOutlet weak var employeementStatusTF: TextField!
    @IBOutlet weak var incomeTF: TextField!
    @IBOutlet weak var fileTF: TextField!
    
    var picture: UIImage!
    
    var fullName:String!
    var emiratiID:String!
    var mobileNo:String!
    var emailAddress:String!
    var nationality:String!
    var familyRegistration:String!
    var dob:String!
    var placeOfBirth:String!
    var gender:String!
    var maritalStatus:String!
    var numOfChildren:String!
    
    var qualification: String!
    var dob2: String!
    var placeOfBirth2: String!
    var employeementStatus: String!
    var income: String!
    var file: UIImage!
    
   var isIncomeFieldEditable = false
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
       }
    
    @objc func donePressed()
    {
        print("Done pressed")
        
        if employeementStatusTF.textField.text == "Unemployed" || employeementStatusTF.textField.text == "عاطلين عن العمل"
        {
            self.incomeTF.textField.text = "0"
            self.isIncomeFieldEditable = false
           
        }
        else
        {
            self.incomeTF.textField.text = ""
            self.isIncomeFieldEditable = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.donePressed), name: NSNotification.Name(rawValue: "donePressed"), object: nil)
        self.incomeTF.textField.delegate = self

        
        if Utility.isArabicSelected() {
            qualificationTF.hint = "المؤهلات العلمية"
            dobTF.hint = "تاريخ الميلاد"
            placeOfBirthTF.hint = "محل الميلاد"
            employeementStatusTF.hint = "الحالة الوظيفية"
            incomeTF.hint = "الدخل الشهري بالدرهم الإماراتي"
            incomeTF.keyboardType = UIKeyboardType.numberPad
            fileTF.hint = "اختر"
            
             employeementStatusTF.options = "العاملين ,عاطلين عن العمل"
            
        } else {
            qualificationTF.hint = "qualification *"
            dobTF.hint = "Date of Birth *"
            placeOfBirthTF.hint = "Place of Birth *"
            employeementStatusTF.hint = "Employment Status *"
            incomeTF.hint = "Monthly income *"
            incomeTF.keyboardType = UIKeyboardType.numberPad
            fileTF.hint = "Choose *"
        }

        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "خدمة الاحتضان "
            } else {
                self.navBar.title.text = "Adoption Service"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        // Do any additional setup after loading the view.
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 700)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var dest = segue.destination as! AdoptionServiceVC3
        
        dest.picture = picture
        dest.fullName = fullName
        dest.emiratiID = emiratiID
        dest.mobileNo = mobileNo
        dest.emailAddress = emailAddress
        dest.nationality = nationality
        dest.familyRegistration = familyRegistration
        dest.dob = dob
        dest.placeOfBirth = placeOfBirth
        dest.gender = gender
        dest.maritalStatus = maritalStatus
        dest.numOfChildren = numOfChildren
        
        dest.qualification = qualification
        dest.dob2 = dob2
        dest.placeOfBirth2 = placeOfBirth2
        dest.employeementStatus = employeementStatus
        dest.income = income
        dest.file = file
        
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
//        if ( self.qualificationTF.textField.text != "" )
//        {
//            self.qualification = self.qualificationTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(qualificationTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.dobTF.textField.text != "" )
//        {
//            self.dob2 = self.dobTF.textField.text        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(dobTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//
//
//        if ( self.placeOfBirthTF.textField.text != "" )
//        {
//            self.placeOfBirth2 = self.placeOfBirthTF.textField.text        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(placeOfBirthTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//
//
//        if ( self.employeementStatusTF.textField.text != "" )
//        {
//            self.employeementStatus = self.employeementStatusTF.textField.text        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(employeementStatusTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//
//
//        if ( self.fileTF.img != nil )
//        {
//            self.file = self.fileTF.img    }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(fileTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
        
        
        if (self.validated())
        { self.performSegue(withIdentifier: "next", sender: self)}
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

extension AdoptionServiceVC2: UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.incomeTF.textField
        {
            if !isIncomeFieldEditable
            {
                textField.endEditing(true)
                return false
            }
        }
        
        return true
    }
    
}
