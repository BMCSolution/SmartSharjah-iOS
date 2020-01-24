//
//  HomeCareVC4.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

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
    
    func fillData()
    {
        let user = User().getUser()
        
        if let name  = user.value(forKey: User().name_Key) as? String
        {
            self.fullName2TF.textField.text = name
        }
        if let num  = user.value(forKey: User().emirateID_Key) as? String
        {
            self.emiratesID2TF.textField.text = num
        }
    }
    
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
        
        self.fillData()
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
            nationality2TF.options = nationalityList_Arabic
            
        }
        else
        {
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
        
        //if (self.navBar.title.text! == "Home Care" || self.navBar.title.text! == "Nursing" ) {
            
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
                self.gender2 = "\(self.gender2TF.picker.selectedRow(inComponent: 0)+1)"
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
        //}
        //else  if (self.navBar.title.text! == "Volunteer at SSSD") {
            
        //}
        
        //else  if (self.navBar.title.text! == "Volunteer at SSSD") {
            
        //}
        
        if (self.validated())
        {
            /*APILayer().postDataToAPI(name: "HomeCare", method: .post, path: "/", params: [:], headers: [:]) { (success, responseDict) in
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
                self.navigationController?.dismiss(animated: true, completion: nil)
            
             }*/
            if Reachability.isConnectedToNetwork()
            {
                if(Utility.checkSesion())
                {
                    apicallHttps()
                }
                else
                {
                    Utility.getFreshToken {
                        (success, response) in
                        self.apicallHttps()
                    }
                }
            }
            else
            {
                Utility.showInternetErrorAlert()
            }
        }
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func apicallHttps(){
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
    
        var medicalReportImgStr = "";
        var emiratesIDFrontStr = "";
        var emiratesIDBackStr = "";
        var passportImgStr = "";
        
        do {
            try medicalReport2!.compressImage(7, completion: { (image, compressRatio) in
                print(image.size)
                let imageData = image.jpegData(compressionQuality: compressRatio)
                medicalReportImgStr = imageData!.base64EncodedString(options: []) ?? ""
            })
        } catch {
            print("Error")
        }
        
        do {
            try emiratesIDFront!.compressImage(7, completion: { (image, compressRatio) in
                print(image.size)
                let imageData = image.jpegData(compressionQuality: compressRatio)
                emiratesIDFrontStr = imageData!.base64EncodedString(options: []) ?? ""
            })
        } catch {
            print("Error")
        }
        
        do {
            try emiratesIDBack!.compressImage(7, completion: { (image, compressRatio) in
                print(image.size)
                let imageData = image.jpegData(compressionQuality: compressRatio)
                emiratesIDBackStr = imageData!.base64EncodedString(options: []) ?? ""
            })
        } catch {
            print("Error")
        }
        
        do {
            try passportImg!.compressImage(7, completion: { (image, compressRatio) in
                print(image.size)
                let imageData = image.jpegData(compressionQuality: compressRatio)
                passportImgStr = imageData!.base64EncodedString(options: []) ?? ""
            })
        } catch {
            print("Error")
        }
        
    //let imageDatamedicalReport2: Data? = medicalReport2!.jpegData(compressionQuality: 0.0002)
    //let imageDataemiratesIDFront: Data? = emiratesIDFront!.jpegData(compressionQuality: 0.0002)
    //let imageDataemiratesIDBack: Data? = emiratesIDBack!.jpegData(compressionQuality: 0.0002)
    //let imageDatapassportImg: Data? = passportImg!.jpegData(compressionQuality: 0.0002)
    
    //var medicalReportImgStr = imageDatamedicalReport2?.base64EncodedString(options: .lineLength64Characters) ?? ""
    //var emiratesIDFrontStr = imageDataemiratesIDFront?.base64EncodedString(options: .lineLength64Characters) ?? ""
    //var emiratesIDBackStr = imageDataemiratesIDBack?.base64EncodedString(options: .lineLength64Characters) ?? ""
    //var passportImgStr = imageDatapassportImg?.base64EncodedString(options: .lineLength64Characters) ?? ""
    
    /*var params:[String: Any] = ["uuid":"54654545646546222222254654546","userType":"SOP3","mobile":self.mobileNo,"email":self.emailAddress,"idn":"784111111111111","dob":self.dob,"photo":"xxx","placeOfBirthAR":self.placeOfBirth,"firstnameAR":"xxx","fullnameEN":self.fullName,"idCardNumber":self.emiratiID,"idCardIssueDate":"xxx","idCardExpiryDate":"xxx","lastnameEN":"xxx","lastnameAR":"xxx","gender":"xxx","nationalityAR":"xxx","nationalityEN":"xxx","residencyNumber":"xxx","maritalStatus":"xxx","passportNumber":"xxx","upassportCountryDescriptionAR":"xxx","passportCountryDescriptionEN":"xxx","passportIssueDate":"xxx","passportExpiryDate":"xxx","idType":"xxx","cardSerialNumber":"xxx","occupationCode":"xxx","titleAR":"xxx","titleEN":"xxx","motherFirstNameAR":"xxx","motherFirstNameEN":"xxx","familyNumber":"xxx","husbandIDN":"xxx","residencyType":"xxx","residencyExpiryDate":"xxx","placeOfBirthEN":"xxx","occupationTypeAR":"xxx","occupationTypeEN":"xxx","motherFullNameAR":"xxx","motherFullNameEN":"xxx","companyNameAR":"xxx","companyNameEN":"xxx","passportTypeCode":"xxx","qualificationLevelCode":"xxx","qualificationLevelDescriptionAR":"xxx","qualificationLevelDescriptionEN":"xxx","degreeDescriptionAR":"xxx","degreeDescriptionEN":"xxx","fieldOfStudyCode":"xxx","fieldOfStudyAR":"xxx","fieldOfStudyEN":"xxx","placeOfStudyAR":"xxx","placeOfStudyEN":"xxx","dateOfGraduation":"xxx","homeAddressTypeCode":"xxx","homeLocationCode":"xxx","homeAddressEmirateCode":"xxx","homeAddressEmirateDescriptionAR":"xxx","homeAddressEmirateDescriptionEN":"xxx","homeAddressCityCode":"xxx","homeAddressCityDescriptionAR":"xxx","homeAddressCityDescriptionEN":"xxx","homeAddressStreetAR":"xxx","homeAddressStreetEN":"xxx","homeAddressPOBox":"xxx","homeAddressAreaCode":"xxx","homeAddressAreaDescriptionAR":"xxx","homeAddressAreaDescriptionEN":"xxx","homeAddressBuildingNameAR":"xxx","homeAddressBuildingNameEN":"xxx","homeAddressFlatNo":"xxx","homeAddressResidentPhoneNumber":"xxx","cardHolderSignatureImage":"xxx","adoption_before":self.adoptedBefore,"adoption_from":"xxx","child_gender_id":self.desiredGender,"child_age":self.desiredAge,"adoption_reason":self.adoptionReason,"child_from_nursery":"yes","approve_feeding":self.lactaction,"emirates_id_front_file":emiratesIDFrontStr,"emirates_id_back_file":emiratesIDBackStr,"passport_file":passportImgStr]*/
        
        var params:[String: Any] = [
            "uuid":"54654545646546222222254654546",
            "userType":"SOP3",
            "mobile":(self.mobileNo as! String),
            "email":(self.emailAddress as! String),
            "idn":"784111111111111",
            "dob":(self.dob as! String),
            "photo":"xxx",
            "placeOfBirthAR":(self.placeOfBirth as! String),
            "firstnameAR":"xxx",
            "fullnameAR":"xxx",
            "idCardNumber":(self.emiratiID as! String),
            "idCardIssueDate":"xxx",
            "idCardExpiryDate":"xxx",
            "fullnameEN":(self.fullName as! String),
            "firstnameEN":"xxx",
            "lastnameEN":"xxx",
            "lastnameAR":"xxx",
            "gender":"xxx",
            "nationalityAR":"xxx",
            "nationalityEN":"xxx",
            "residencyNumber":"xxx",
            "maritalStatus":"xxx",
            "passportNumber":"xxx",
            "upassportCountryDescriptionAR":"xxx",
            "passportCountryDescriptionEN":"xxx",
            "passportIssueDate":"xxx",
            "passportExpiryDate":"xxx",
            "idType":"xxx",
            "cardSerialNumber":"xxx",
            "occupationCode":"xxx",
            "titleAR":"xxx",
            "titleEN":"xxx",
            "motherFirstNameAR":"xxx",
            "motherFirstNa meEN":"xxx",
            "familyNumber":"xxx",
            "husbandIDN":"xxx",
            "residencyType":"xxx",
            "residencyExpiryDate":"xxx",
            "placeOfBirthEN":"xxx",
            "occupationTypeAR":"xxx",
            "occupationTypeEN":"xxx",
            "motherFullNameAR":"xxx",
            "motherFullNameEN":"xxx",
            "companyNameAR":"xxx",
            "companyNameEN":"xxx",
            "passportTypeCode":"xxx",
            "qualificationLevelCode":"xxx",
            "qualificationLevelDescriptionAR":"xxx",
            "qualificationLevelDescriptionEN":"xxx",
            "degreeDescriptionAR":"xxx",
            "degreeDescriptionEN":"xxx",
            "fieldOfStudyCode":"xxx",
            "fieldOfStudyAR":"xxx",
            "fieldOfStudyEN":"xxx",
            "placeOfStudyAR":"xxx",
            "placeOfStudyEN":"xxx",
            "dateOfGraduation":"xxx",
            "homeAddressTypeCode":"xxx",
            "homeLocationCode":"xxx",
            "homeAddressEmirateCode":"xxx",
            "homeAddressEmirateDescriptionAR":"xxx",
            "homeAddressEmirateDescriptionEN":"xxx",
            "homeAddressCityCode":"xxx",
            "homeAddressCityDescriptionAR":"xxx",
            "homeAddressCityDescriptionEN":"xxx",
            "homeAddressStreetAR":"xxx",
            "homeAddressStreetEN":"xxx",
            "homeAddressPOBox":"xxx",
            "homeAddressA reaCode":"xxx",
            "homeAddressA reaDescriptionAR":"xxx",
            "homeAddressA reaDescriptionEN":"xxx",
            "homeAddressBuildingNameAR":"xxx",
            "homeAddressBuildingNameEN":"xxx",
            "homeAddressFlatNo":"xxx",
            "homeAddressResidentPhoneNumber":"xxx",
            "cardHolderSignatureImage":"xxx",
            "name":(self.fullName2 as! String),
            "gender_id":"1",
            "marital_status_id":"1",
            "hc_category_id":(self.category2 as! String),
            "date_of_birth":(self.dob2 as! String),
            "emirates_id":(self.emiratesID2 as! String),
            "branch_id":(self.branch2 as! String),
            "medical_file":medicalReportImgStr,
            "emirates_id_front_file":emiratesIDFrontStr,
            "emirates_id_back_file":emiratesIDBackStr,
            "passport_file":passportImgStr
        ]

        
        var urlPart = "";
        if(self.navBar.title.text?.contains("Homecare") ?? false)
        {
            urlPart = "api/SaveSSDInfoController/SaveHomeCareInfo";
        }
        else
        {
            urlPart = "api/SaveSSDInfoController/SaveNursingInfo";
        }
        let ulr =  URL(string: APILayer().baseURL +  urlPart)!
        var request = URLRequest(url: ulr as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userDefaults = UserDefaults.standard
        let accesstoken = userDefaults.object(forKey: "access_token") as! String
        let authData = accesstoken
        request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
        let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                   let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                   if let json = json {
                       print(json)
                   }
                   request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        
        Alamofire.request(request as! URLRequestConvertible)
            .responseJSON { (response) in
            
            if (response.error != nil)
            {
                print ("responseJson: \(response.error)")
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
            }
            else
            {
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if let code = response.response?.statusCode as? Int{
                    if code == 401
                    {
                        Utility.getFreshToken {
                            (success, response) in
                            self.apicallHttps()
                        }
                    }
                    else
                    {
                            if let respJson = response.value as? NSDictionary
                            {
                                print ("responseJson: \(respJson)")
                                //if let successFlag = respJson.value(forKey: "success") as? Bool{
                                    
                                //}
                                if let message = respJson.value(forKey: "message") as? String{
                                    let otherAlert = UIAlertController(title: self.navBar.title.text, message: message, preferredStyle: UIAlertController.Style.alert)
                                                    let dismiss = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                                                        self.navigationController?.dismiss(animated: true, completion: nil)
                                                            }
                                    
                                    
                                                    otherAlert.addAction(dismiss)
                                                
                                                self.present(otherAlert, animated: true, completion: nil)
                                }
                            }
                    }
                }
            }
        }
    }
}
