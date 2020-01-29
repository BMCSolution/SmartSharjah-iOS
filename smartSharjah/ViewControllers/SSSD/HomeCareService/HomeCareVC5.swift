//
//  HomeCareVC5.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class HomeCareVC5: UIViewController {

    @IBOutlet weak var imagebtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBar: NavBar!
    
    @IBOutlet weak var mothernameTF: TextField!
    @IBOutlet weak var unifiednoTF: TextField!
    @IBOutlet weak var otherskillsTF: TextField!
    
    
    var picture: UIImage!
    
//    @IBOutlet weak var fullName2TF: TextField!
//    @IBOutlet weak var emiratesID2TF: TextField!
//    @IBOutlet weak var gender2TF: TextField!
//    @IBOutlet weak var nationality2TF: TextField!
//    @IBOutlet weak var dob2TF: TextField!
//    @IBOutlet weak var category2TF: TextField!
//    @IBOutlet weak var branch2TF: TextField!
//    @IBOutlet weak var idFront: TextField!
//    @IBOutlet weak var idBack: TextField!
//    @IBOutlet weak var passportPic: TextField!
//    @IBOutlet weak var medicalPic: TextField!
//
    

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

    var mothername:String!
    var unifiedno:String!
    var otherskills:String!
    
    var isAlreadyBusy = false
    
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navBar != nil)
        {
            if let title = UserDefaults.standard.value(forKey: "service") as? String{
                self.navBar.title.text = title
            }
            else{
                self.navBar.title.text = "Volunteer"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        // Do any additional setup after loading the view.
        if Utility.isArabicSelected() {
            
        }
        else
        {
            mothernameTF.hint = "Mother Name"
            unifiednoTF.hint = "Unified No"
            otherskillsTF.hint = "Other Skills"
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 1250)
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

    
    @IBAction func choosePickerPressed(_ sender: UIButton) {
        
        let pickerController = UIImagePickerController()
        //        pickerController.delegate = self
        pickerController.allowsEditing = true
        //        pickerController.mediaTypes = [.image]
        pickerController.sourceType = .photoLibrary
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func nextPressed(_ sender: UIButton) {
        
        if(!isAlreadyBusy)
        {
            if ( self.mothernameTF.textField.text != "" )
            {
                self.mothername = self.mothernameTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(mothernameTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.unifiednoTF.textField.text != "" )
            {
                self.unifiedno = self.unifiednoTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(unifiednoTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            if ( self.otherskillsTF.textField.text != "" )
            {
                self.otherskills = self.otherskillsTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(otherskillsTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }
            
            
             if (self.validated())
             {
                /*APILayer().postDataToAPI(name: "HomeCare", method: .post, path: "/", params: [:], headers: [:]) { (success, responseDict) in
                
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
                    self.navigationController?.dismiss(animated: true, completion: nil)
                
                }*/
                if Reachability.isConnectedToNetwork()
                {
                    isAlreadyBusy = true
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
        }
        
        
    }
    
    func apicallHttps(){
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
    
        var emiratesIDFrontStr = "";
        var emiratesIDBackStr = "";
        var passportImgStr = "";
        
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
        "arabic_lang_flag":"1",
        "english_lang_flag":"1",
        "vol_period_id":"1",
        "vol_time_id":"1",
    "cv_file":"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",
        "mother_name":(self.mothername as! String),//found
        "other_lang_flag":"1",
    "qualification_file":"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",
        "unified_no":(self.unifiedno as! String),//found
        "other_skills":(self.otherskills as! String),//found
        "religion":"test",
        "vol_category_type_id":["1","2"],
        "emirates_id_front_file":emiratesIDFrontStr,
        "emirates_id_back_file":emiratesIDBackStr,
        "passport_file":passportImgStr
        
        ]

        
       
        let ulr =  URL(string: APILayer().baseURL +  "api/SaveSSDInfoController/SaveVolunteerInfo")!
        var request = URLRequest(url: ulr as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userDefaults = UserDefaults.standard
        var accesstoken = ""
        if(userDefaults.object(forKey: "access_token") != nil)
        {
            accesstoken = userDefaults.object(forKey: "access_token") as! String
        }
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
                self.isAlreadyBusy = false
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
                        self.isAlreadyBusy = true
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let img = info[.editedImage] as? UIImage {
            self.imagebtn.setImage(img, for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
        //        self.pickerController(picker, didSelect: image)
        
    }
    
}

