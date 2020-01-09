//
//  HomeCareVC1a.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class HomeCareVC1a: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneNumberTF: TextField!
    @IBOutlet weak var issuedByTF: TextField!
    @IBOutlet weak var cityTF: TextField!
    @IBOutlet weak var fullAddressTF: TextField!
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
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
       Utility.setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Utility.isArabicSelected() {
            phoneNumberTF.hint = "رقم الهاتف"
            phoneNumberTF.keyboardType = UIKeyboardType.numberPad
            issuedByTF.hint = "جهة الإصدار"
            cityTF.hint = "المدينة"
            fullAddressTF.hint = "العنوان بالكامل"
        } else {
            phoneNumberTF.hint = "Telephone Number *"
            phoneNumberTF.keyboardType = UIKeyboardType.numberPad
            issuedByTF.hint = "Issued By *"
            cityTF.hint = "City *"
            fullAddressTF.hint = "Full Address *"
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
//         self.performSegue(withIdentifier: "next", sender: self)
        
        
//        if ( self.phoneNumberTF.textField.text != "" )
//        {
//            self.phoneNumber = self.phoneNumberTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(issuedByTF.hintLbl.text!) \("cannot be empty".localized())" , viewController: self)
//            return
//        }
//        
//        if ( self.issuedByTF.textField.text != "" )
//        {
//            self.issuedBy = self.issuedByTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(issuedByTF.hintLbl.text!) \("cannot be empty".localized())" , viewController: self)
//            return
//        }
//        
//        
//        if ( self.cityTF.textField.text != "" )
//        {
//            self.city = self.cityTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(cityTF.hintLbl.text!) \("cannot be empty".localized())" , viewController: self)
//            return
//        }
//        
//        
//        if ( self.fullAddressTF.textField.text != "" )
//        {
//            self.fullAddress = self.fullAddressTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(fullAddressTF.hintLbl.text!) \("cannot be empty".localized())" , viewController: self)
//            return
//        }

        if (self.validated())
        {
            self.performSegue(withIdentifier: "next", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var dest = segue.destination as! HomeCareVC2
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
        
    }
}

