//
//  HomeCareVC3.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class HomeCareVC3: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollVoew: UIScrollView!
    
    @IBOutlet weak var passportNumTF: TextField!
    @IBOutlet weak var passportIssuePlaceTF: TextField!
    @IBOutlet weak var passportDateIssueTF: TextField!
    @IBOutlet weak var passportExpiryTF: TextField!
    @IBOutlet weak var idFront: TextField!
    @IBOutlet weak var idBack: TextField!
    @IBOutlet weak var passportPic: TextField!
    @IBOutlet weak var residencePic: TextField!
    var picture: UIImage!
    
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Utility.isArabicSelected() {
            passportNumTF.hint = "رقم جواز السفر"
            passportIssuePlaceTF.hint = "مكان الإصدار"
            passportDateIssueTF.hint = "تاريخ الإصدار"
            passportExpiryTF.hint = "تاريخ الانتهاء"
            idFront.hint = "صورة الهوية الإماراتية (الصفحة الأمامية)*"
            idBack.hint = "صورة الهوية الإماراتية (الصفحة الخلفية)*"
            passportPic.hint = "صورة من جواز السفر*"
            residencePic.hint = "صورة من بطاقة الإقامة"
        } else {
            passportNumTF.hint = "Passport Number *"
            passportIssuePlaceTF.hint = "Place of issue *"
            passportDateIssueTF.hint = "Date of Issue *"
            passportExpiryTF.hint = "Date of Expiry *"
            idFront.hint = "Copy of Emirates ID (front page) *"
            idBack.hint = "Copy of Emirates ID (back page) *"
            passportPic.hint = "Copy of Passport *"
            residencePic.hint = "Copy of Residency Card *"
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
        
        self.scrollVoew.contentSize = CGSize(width: self.scrollVoew.frame.width*0.9, height: 1000)
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
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextJobSeeker"
        {
            let dest = segue.destination as! HomeCareVC6
            dest.picture = picture
            
            dest.emiratesIDFront = emiratesIDFront
            dest.emiratesIDBack = emiratesIDBack
            dest.passportImg = passportImg
            dest.residenceCard = residenceCard
            
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
            
            dest.passportNum = passportNum
            dest.passportIssuePlace = passportIssuePlace
            dest.passportDateIssue = passportDateIssue
            dest.passportExpiry = passportExpiry
        }
        else if segue.identifier == "nextVolunteer"
        {
            let dest = segue.destination as! HomeCareVC5
            dest.picture = picture
            
            dest.emiratesIDFront = emiratesIDFront
            dest.emiratesIDBack = emiratesIDBack
            dest.passportImg = passportImg
            dest.residenceCard = residenceCard
            
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
            
            dest.passportNum = passportNum
            dest.passportIssuePlace = passportIssuePlace
            dest.passportDateIssue = passportDateIssue
            dest.passportExpiry = passportExpiry
        }
        else
        {
            let dest = segue.destination as! HomeCareVC4
            dest.picture = picture
            
            dest.emiratesIDFront = emiratesIDFront
            dest.emiratesIDBack = emiratesIDBack
            dest.passportImg = passportImg
            dest.residenceCard = residenceCard
            
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
            
            dest.passportNum = passportNum
            dest.passportIssuePlace = passportIssuePlace
            dest.passportDateIssue = passportDateIssue
            dest.passportExpiry = passportExpiry
        }
     }
     
    
    @IBAction func nextPressed(_ sender: UIButton) {
        print(" button pressed here ")
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
        
        if ( self.residencePic.img != nil )
        {
            self.residenceCard = self.residencePic.img!
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(residencePic.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }
        
        if let title = UserDefaults.standard.value(forKey: "service") as? String{
                print(" button pressed here musa raza gillani ")
            if title.contains("Volunteer")
            {
                print(" button pressed here musa raza gillani in volunteer")
                
                if ( self.passportNumTF.textField.text != "" )
                {
                    self.passportNum = self.passportNumTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportNumTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportIssuePlaceTF.textField.text != "" )
                {
                    self.passportIssuePlace = self.passportIssuePlaceTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportIssuePlaceTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportDateIssueTF.textField.text != "" )
                {
                    self.passportDateIssue = self.passportDateIssueTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportDateIssueTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportExpiryTF.textField.text != "" )
                {
                    self.passportExpiry = self.passportExpiryTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportExpiryTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                if (self.validated())
                {self.performSegue(withIdentifier: "nextVolunteer", sender: self)}
            }
            else if title.contains("Job Seeker") || title.contains("Social Services Job Application")
            {
                if ( self.passportNumTF.textField.text != "" )
                {
                    self.passportNum = self.passportNumTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportNumTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportIssuePlaceTF.textField.text != "" )
                {
                    self.passportIssuePlace = self.passportIssuePlaceTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportIssuePlaceTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportDateIssueTF.textField.text != "" )
                {
                    self.passportDateIssue = self.passportDateIssueTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportDateIssueTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportExpiryTF.textField.text != "" )
                {
                    self.passportExpiry = self.passportExpiryTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportExpiryTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                if (self.validated())
                {self.performSegue(withIdentifier: "nextJobSeeker", sender: self)}
                
                
            }
            else{
                if ( self.passportNumTF.textField.text != "" )
                {
                    self.passportNum = self.passportNumTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportNumTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportIssuePlaceTF.textField.text != "" )
                {
                    self.passportIssuePlace = self.passportIssuePlaceTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportIssuePlaceTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportDateIssueTF.textField.text != "" )
                {
                    self.passportDateIssue = self.passportDateIssueTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportDateIssueTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                
                if ( self.passportExpiryTF.textField.text != "" )
                {
                    self.passportExpiry = self.passportExpiryTF.textField.text
                }
                else
                {
                    SetDefaultWrappers().showAlert(info: "\(passportExpiryTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                    return
                }
                self.performSegue(withIdentifier: "next", sender: self)
            }
        }
        else{
            
            
            if ( self.passportNumTF.textField.text != "" )
            {
                self.passportNum = self.passportNumTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(passportNumTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.passportIssuePlaceTF.textField.text != "" )
            {
                self.passportIssuePlace = self.passportIssuePlaceTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(passportIssuePlaceTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.passportDateIssueTF.textField.text != "" )
            {
                self.passportDateIssue = self.passportDateIssueTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(passportDateIssueTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.passportExpiryTF.textField.text != "" )
            {
                self.passportExpiry = self.passportExpiryTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(passportExpiryTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if (self.validated())
            {self.performSegue(withIdentifier: "next", sender: self)}
        }
        
        
    }
    
}
