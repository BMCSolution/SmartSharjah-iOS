//
//  HomeCareVC4.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class HomeCareVC4: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fullName2TF: TextField!
    @IBOutlet weak var emiratesID2TF: TextField!
    @IBOutlet weak var gender2TF: TextField!
    @IBOutlet weak var nationality2TF: TextField!
    @IBOutlet weak var dob2TF: TextField!
    @IBOutlet weak var category2TF: TextField!
    @IBOutlet weak var branch2TF: TextField!
    @IBOutlet weak var idFront: TextField!
    @IBOutlet weak var idBack: TextField!
    @IBOutlet weak var passportPic: TextField!
    @IBOutlet weak var medicalPic: TextField!
    var picture: UIImage!
    var emiratesIDFront2: UIImage?  
    var emiratesIDBack2: UIImage?
    var passportImg2: UIImage?
    var medicalReport2: UIImage?
    
    var emiratesIDFront: UIImage?
    var emiratesIDBack: UIImage?
    var passportImg: UIImage?
    var residenceCard: UIImage?
    
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
    
    var passportNum: String!
    var passportIssuePlace: String!
    var passportDateIssue: String!
    var passportExpiry: String!

    var fullName2:String!
    var emiratesID2:String!
    var gender2:String!
    var nationality2:String!
    var dob2:String!
    var category2:String!
    var branch2:String!
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Utility.isArabicSelected() {
            fullName2TF.hint = "الاسم بالكامل"
            emiratesID2TF.hint = "رقم الهوية الإماراتية"
            emiratesID2TF.keyboardType = UIKeyboardType.numberPad
            gender2TF.hint = "الجنس"
            nationality2TF.hint = "الجنسية"
            dob2TF.hint = "تاريخ الميلاد"
            category2TF.hint = "الفئة"
            branch2TF.hint = "الفرع"
            idFront.hint = "صورة الهوية الإماراتية (الصفحة الأمامية)*"
            idBack.hint = "صورة الهوية الإماراتية (الصفحة الخلفية)*"
            passportPic.hint = "صورة من جواز السفر*"
            medicalPic.hint = "صورة من التقرير الطبي*"
            
            gender2TF.options = "ذكر,انثى"
            
        } else {
            fullName2TF.hint = "Full Name *"
            emiratesID2TF.hint = "Emirates ID No *"
            emiratesID2TF.keyboardType = UIKeyboardType.numberPad
            gender2TF.hint = "Gender *"
            nationality2TF.hint = "Nationality *"
            dob2TF.hint = "Date of Birth *"
            category2TF.hint = "Category *"
            branch2TF.hint = "Branch *"
            idFront.hint = "Copy of Emirati ID (front page) *"
            idBack.hint = "Copy of Emirati ID (back page) *"
            passportPic.hint = "Copy of Passport *"
            medicalPic.hint = "Copy of Medical Report *"
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
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 1300)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        if (self.navBar.title.text! == "Home Care" || self.navBar.title.text! == "Nursing" ) {
            
            if ( self.fullName2TF.textField.text != "" )
            {
                self.fullName2 = self.fullName2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(fullName2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.emiratesID2TF.textField.text != "" )
            {
                self.emiratesID2 = self.emiratesID2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(emiratesID2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.gender2TF.textField.text != "" )
            {
                self.gender2 = self.gender2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(gender2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.nationality2TF.textField.text != "" )
            {
                self.nationality2 = self.nationality2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(nationality2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.dob2TF.textField.text != "" )
            {
                self.dob2 = self.dob2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(dob2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.category2TF.textField.text != "" )
            {
                self.category2 = self.category2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(category2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.branch2TF.textField.text != "" )
            {
                self.branch2 = self.branch2TF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(branch2TF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.idFront.img != nil )
            {
                self.emiratesIDFront = self.idFront.img!
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(idFront.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.idBack.img != nil )
            {
                self.emiratesIDBack = self.idBack.img!
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(idBack.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.passportPic.img != nil )
            {
                self.passportImg = self.passportPic.img!
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(passportPic.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.medicalPic.img != nil )
            {
                self.medicalReport2 = self.medicalPic.img!
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(medicalPic.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
        }
        else  if (self.navBar.title.text! == "Volunteer at SSSD") {
            
        }
        
        else  if (self.navBar.title.text! == "Volunteer at SSSD") {
            
        }
        
        if (self.validated())
        
        {APILayer().postDataToAPI(name: "HomeCare", method: .post, path: "/", params: [:], headers: [:]) { (success, responseDict) in
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
                self.navigationController?.dismiss(animated: true, completion: nil)
            
        }}
        
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
        
    }
}
