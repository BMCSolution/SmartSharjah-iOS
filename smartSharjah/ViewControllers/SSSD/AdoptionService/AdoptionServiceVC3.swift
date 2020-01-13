//
//  AdoptionServiceVC3.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class AdoptionServiceVC3: UIViewController {

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
    
    var emiratesIDFront: UIImage?
    var emiratesIDBack: UIImage?
    var passportImg: UIImage?
    var residenceCard: UIImage?
    
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
            passportNumTF.hint = "Passport No. *"
            passportIssuePlaceTF.hint = "Place of Issue *"
            passportDateIssueTF.hint = "Date of Issue *"
            passportExpiryTF.hint = "Date of Expiry *"
            idFront.hint = "Copy of Emirates ID (front page) *"
            idBack.hint = "Copy of Emirates ID (back page) *"
            passportPic.hint = "Copy of Passport *"
            residencePic.hint = "Copy of Residency Card *"
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
        
         self.scrollVoew.contentSize = CGSize(width: self.scrollVoew.frame.width*0.9, height: 1000)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var dest = segue.destination as! AdoptionServiceVC4
        dest.emiratesIDFront = emiratesIDFront
        dest.emiratesIDBack = emiratesIDBack
        dest.passportImg = passportImg
        dest.residenceCard = residenceCard
        
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
        
        dest.passportNum = passportNum
        dest.passportIssuePlace = passportIssuePlace
        dest.passportDateIssue = passportDateIssue
        dest.passportExpiry = passportExpiry
        
    }
    
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
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
        {
            if ( self.idFront.img != nil )
            {
                self.emiratesIDFront = self.idFront.img
            }
            if ( self.idBack.img != nil )
            {
                self.emiratesIDBack = self.idBack.img
            }
            if ( self.passportPic.img != nil )
            {
                self.passportImg = self.passportPic.img
            }
            if ( self.residencePic.img != nil )
            {
                self.residenceCard = self.residencePic.img
            }
            self.performSegue(withIdentifier: "next", sender: self)
            
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
