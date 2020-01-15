//
//  HomeCareVC2.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class HomeCareVC2: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var qualificationTF: TextField!
    @IBOutlet weak var dateOfIssueTF: TextField!
    @IBOutlet weak var qualificationIssuedByTF: TextField!
    @IBOutlet weak var employmentStatusTF: TextField!
    @IBOutlet weak var monthlyIncomeTF: TextField!
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
    
    var phoneNumber:String!
    var issuedBy:String!
    var city:String!
    var fullAddress:String!

    var qualification:String!
    var dateOfIssue:String!
    var qualificationIssuedBy:String!
    var employmentStatus:String!
    var monthlyIncome:String!
    
    
    var isIncomeFieldEditable = false
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
       }
    
    @objc func donePressed()
    {
        print("Done pressed")
        
        if employmentStatusTF.textField.text == "Unemployed" || employmentStatusTF.textField.text == "عاطلين عن العمل"
        {
            self.monthlyIncomeTF.textField.text = "0"
            self.isIncomeFieldEditable = false
           
        }
        else
        {
            self.monthlyIncomeTF.textField.text = ""
            self.isIncomeFieldEditable = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.donePressed), name: NSNotification.Name(rawValue: "donePressed"), object: nil)
        self.monthlyIncomeTF.textField.delegate = self

        
        if Utility.isArabicSelected() {
            qualificationTF.hint = "المؤهلات العلمية"
            dateOfIssueTF.hint = "تاريخ الإصدار"
            qualificationIssuedByTF.hint = "جهة الإصدار"
            employmentStatusTF.hint = "الحالة الوظيفية"
            monthlyIncomeTF.hint = "الدخل الشهري بالدرهم الإماراتي"
            monthlyIncomeTF.keyboardType = UIKeyboardType.numberPad
            
            employmentStatusTF.options = "العاملين ,عاطلين عن العمل"
        } else {
            qualificationTF.hint = "Qualification *"
            dateOfIssueTF.hint = "Date of Issue *"
            qualificationIssuedByTF.hint = "Issued By *"
            employmentStatusTF.hint = "Employment Status *"
            monthlyIncomeTF.hint = "Monthly income in AED *"
            monthlyIncomeTF.keyboardType = UIKeyboardType.numberPad
        }
        
        if (self.navBar != nil)
        {
            if let title = UserDefaults.standard.value(forKey: "service") as? String{
                self.navBar.title.text = title
            }
            else{
                self.navBar.title.text = "Home Care"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        // Do any additional setup after loading the view.
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 700)
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        var dest = segue.destination as! HomeCareVC3
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
        
        dest.phoneNumber = phoneNumber
        dest.issuedBy = issuedBy
        dest.city = city
        dest.fullAddress = fullAddress
        
        dest.qualification = qualification
        dest.dateOfIssue = dateOfIssue
        dest.qualificationIssuedBy = qualificationIssuedBy
        dest.employmentStatus = employmentStatus
        dest.monthlyIncome = monthlyIncome
        
     }
 
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        
//        self.performSegue(withIdentifier: "next", sender: self)
        
        if ( self.qualificationTF.textField.text != "" )
        {
            self.qualification = self.qualificationTF.textField.text
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(qualificationTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }
        
        if ( self.dateOfIssueTF.textField.text != "" )
        {
            self.dateOfIssue = self.dateOfIssueTF.textField.text
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(dateOfIssueTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }
        
        if ( self.qualificationIssuedByTF.textField.text != "" )
        {
            self.qualificationIssuedBy = self.qualificationIssuedByTF.textField.text
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(qualificationIssuedByTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }
        
        
        if ( self.employmentStatusTF.textField.text != "" )
        {
            self.employmentStatus = self.employmentStatusTF.textField.text
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(employmentStatusTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }
        
        
        
        if ( self.monthlyIncomeTF.textField.text != "" )
        {
            self.monthlyIncome = self.monthlyIncomeTF.textField.text
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(monthlyIncomeTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }
        
        
        if (self.validated())
        {self.performSegue(withIdentifier: "next", sender: self)}
        
        
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
    
    func getData(){
        
        APILayer().getDataFromAPI(name: "GetContactType", method:.get, path: "api/ContactTypeController/GetListContactType", params: [:], headers: [:]) { (successGetContactType, GetContactType) in
            
            if (successGetContactType)
            {
                
                APILayer().getDataFromAPI(name: "GetGender", method:.get, path: "api/GenderController/GetListGender", params: [:], headers: [:]) { (successGetGender, GetGetGender) in
                    
                    if (successGetGender)
                    {
                        APILayer().getDataFromAPI(name: "GetHcCategory", method:.get, path: "api/HcCategoryController/GetListHcCategory", params: [:], headers: [:]) { (successGetHcCategory, GetGetHcCategory) in
                            
                            if (successGetHcCategory)
                            {
                                APILayer().getDataFromAPI(name: "GetMaritalStatus", method:.get, path: "api/MaritalStatusController/GetMaritalStatus", params: [:], headers: [:]) { (successGetMaritalStatus, GetGetMaritalStatus) in
                                    
                                    if (successGetMaritalStatus)
                                    {
                                        
                                        
                                        
                                        APILayer().getDataFromAPI(name: "GetVolPeriod", method:.get, path: "api/VolController/VolPeriod", params: [:], headers: [:]) { (successGetVolPeriod, GetGetVolPeriod) in
                                            
                                            if (successGetMaritalStatus)
                                            {
                                                APILayer().getDataFromAPI(name: "GetVolCategoryType", method:.get, path: "api/VolController/VolCategoryType", params: [:], headers: [:]) { (successGetVolCategoryType, GetGetVolCategoryType) in
                                                    
                                                    if (successGetVolCategoryType)
                                                    {
                                                        APILayer().getDataFromAPI(name: "GetConsultationType", method:.get, path: "api/ConsultationController/GetListConsultationType", params: [:], headers: [:]) { (successGetConsultationType, GetConsultationType) in
                                                            
                                                            if (successGetConsultationType)
                                                            {
                                                                APILayer().getDataFromAPI(name: "GetConsultationCategory", method:.get, path: "api/ConsultationController/GetListConsultationCategory", params: [:], headers: [:]) { (successGetConsultationCategory, GetConsultationCategory) in
                                                                    
                                                                    if (successGetConsultationCategory)
                                                                    {
                                                                        
                                                                    }
                                                                    else
                                                                    {
                                                                        print("*Error")
                                                                    }
                                                                }
                                                            }
                                                            else
                                                            {
                                                                print("*Error")
                                                            }
                                                        }
                                                    }
                                                    else
                                                    {
                                                        print("*Error")
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                print("*Error")
                                            }
                                        }
                                    }
                                    else
                                    {
                                        print("*Error")
                                    }
                                }
                            }
                            else
                            {
                                print("*Error")
                            }
                        }
                    }
                    else
                    {
                        print("*Error")
                    }
                }
                
            }
            else
            {
                print ("*Error")
            }
        }
    }
}

extension HomeCareVC2: UITextFieldDelegate{

func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    if textField == self.monthlyIncomeTF.textField
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
