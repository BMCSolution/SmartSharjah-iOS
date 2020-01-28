//
//  AdoptionServiceVC4.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class AdoptionServiceVC4: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var childAdoptionTF: TextField!
    @IBOutlet weak var desiredGenderTF: TextField!
    @IBOutlet weak var desiredAgeTF: TextField!
    @IBOutlet weak var adoptedBeforeTF: TextField!
    @IBOutlet weak var lactactionTF: TextField!
    @IBOutlet weak var qualificationTF: TextField!
    @IBOutlet weak var adoptionReasonTF: TextField!
    
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
    
    var childAdoption: String!
    var desiredGender: String!
    var desiredAge: String!
    var adoptedBefore: String!
    var lactaction: String!
    var qualification2: String!
    var adoptionReason: String!
    
    var isAlreadyBusy = false
    
    override func viewDidAppear(_ animated: Bool) {
             Utility.setView()
          }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "خدمة الاحتضان"
            } else {
                self.navBar.title.text = "Adoption Service"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        // Do any additional setup after loading the view.
        if Utility.isArabicSelected()
        {
            childAdoptionTF.hint = "نعم / لا"
            desiredGenderTF.hint = "أختر"
            desiredAgeTF.hint = "عمر الطفل الذي تريد تبنيه"
            adoptedBeforeTF.hint = "نعم / لا"
            lactactionTF.hint = "نعم / لا"
            qualificationTF.hint = "المؤهل"
            adoptionReasonTF.hint = "أسباب التبني"
            
            childAdoptionTF.options = "نعم , لا"
            desiredGenderTF.options = "ذكر,انثى"
            adoptedBeforeTF.options = "نعم , لا"
            lactactionTF.options = "نعم , لا"
        }
        else
        {
            childAdoptionTF.hint = "Yes / No"
            desiredGenderTF.hint = "Choose"
            desiredAgeTF.hint = "Age of the child you want to adopt"
            adoptedBeforeTF.hint = "Yes / No"
            lactactionTF.hint = "Yes / No"
            qualificationTF.hint = "Qualification"
            adoptionReasonTF.hint = "Adoption Reasons"
            
            
        }
        
        desiredAgeTF.textField.keyboardType = .numberPad
        
        
         self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 1000)
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
        //self.performSegue(withIdentifier: "next", sender: self)
        
        if(!isAlreadyBusy)
        {
            if ( self.childAdoptionTF.textField.text != "" )
            {
                self.childAdoption = self.childAdoptionTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(childAdoptionTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }

            if ( self.desiredGenderTF.textField.text != "" )
            {
                self.desiredGender = "\(self.desiredGenderTF.picker.selectedRow(inComponent: 0)+1)"
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(desiredGenderTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }



            if ( self.desiredAgeTF.textField.text != "" )
            {
                self.desiredAge = self.desiredAgeTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(desiredAgeTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }





            if ( self.adoptedBeforeTF.textField.text != "" )
            {
                self.adoptedBefore = self.adoptedBeforeTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(adoptedBeforeTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }


            if ( self.lactactionTF.textField.text != "" )
            {
                self.lactaction = self.lactactionTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(lactactionTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }



            if ( self.qualificationTF.textField.text != "" )
            {
                self.qualification = self.qualificationTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(qualificationTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }


            if ( self.adoptionReasonTF.textField.text != "" )
            {
                self.adoptionReason = self.adoptionReasonTF.textField.text
            }
            else
            {
                SetDefaultWrappers().showAlert(info: "\(adoptionReasonTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
                return
            }



            
            
            if (self.validated())
            {
                /*APILayer().postDataToAPI(name: "AdoptionService", method: .post, path: "/", params: [:], headers: [:]) { (success, responseDict) in
                
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
        
        
//        SetDefaultWrappers().showAlert(info:"Application has been Submitted", viewController: self)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
        
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
        
        //let imageDataemiratesIDFront: Data? = emiratesIDFront!.jpegData(compressionQuality: 0.0002)
        //let imageDataemiratesIDBack: Data? = emiratesIDBack!.jpegData(compressionQuality: 0.0002)
        //let imageDatapassportImg: Data? = passportImg!.jpegData(compressionQuality: 0.0002)
        //let emiratesIDFrontStr = imageDataemiratesIDFront?.base64EncodedString(options: .lineLength64Characters) ?? ""
        //let emiratesIDBackStr = imageDataemiratesIDBack?.base64EncodedString(options: .lineLength64Characters) ?? ""
        //let passportImgStr = imageDatapassportImg?.base64EncodedString(options: .lineLength64Characters) ?? ""
         
        var params:[String: Any] = ["uuid":"54654545646546222222254654546","userType":"SOP3","mobile":(self.mobileNo as! String),"email":(self.emailAddress as! String),"idn":"784111111111111","dob":(self.dob as! String),"photo":"xxx","placeOfBirthAR":(self.placeOfBirth as! String),"firstnameAR":"xxx","fullnameEN":(self.fullName as! String),"idCardNumber":(self.emiratiID as! String),"idCardIssueDate":"xxx","idCardExpiryDate":"xxx","lastnameEN":"xxx","lastnameAR":"xxx","gender":"xxx","nationalityAR":"xxx","nationalityEN":"xxx","residencyNumber":"xxx","maritalStatus":"xxx","passportNumber":"xxx","upassportCountryDescriptionAR":"xxx","passportCountryDescriptionEN":"xxx","passportIssueDate":"xxx","passportExpiryDate":"xxx","idType":"xxx","cardSerialNumber":"xxx","occupationCode":"xxx","titleAR":"xxx","titleEN":"xxx","motherFirstNameAR":"xxx","motherFirstNameEN":"xxx","familyNumber":"xxx","husbandIDN":"xxx","residencyType":"xxx","residencyExpiryDate":"xxx","placeOfBirthEN":"xxx","occupationTypeAR":"xxx","occupationTypeEN":"xxx","motherFullNameAR":"xxx","motherFullNameEN":"xxx","companyNameAR":"xxx","companyNameEN":"xxx","passportTypeCode":"xxx","qualificationLevelCode":"xxx","qualificationLevelDescriptionAR":"xxx","qualificationLevelDescriptionEN":"xxx","degreeDescriptionAR":"xxx","degreeDescriptionEN":"xxx","fieldOfStudyCode":"xxx","fieldOfStudyAR":"xxx","fieldOfStudyEN":"xxx","placeOfStudyAR":"xxx","placeOfStudyEN":"xxx","dateOfGraduation":"xxx","homeAddressTypeCode":"xxx","homeLocationCode":"xxx","homeAddressEmirateCode":"xxx","homeAddressEmirateDescriptionAR":"xxx","homeAddressEmirateDescriptionEN":"xxx","homeAddressCityCode":"xxx","homeAddressCityDescriptionAR":"xxx","homeAddressCityDescriptionEN":"xxx","homeAddressStreetAR":"xxx","homeAddressStreetEN":"xxx","homeAddressPOBox":"xxx","homeAddressAreaCode":"xxx","homeAddressAreaDescriptionAR":"xxx","homeAddressAreaDescriptionEN":"xxx","homeAddressBuildingNameAR":"xxx","homeAddressBuildingNameEN":"xxx","homeAddressFlatNo":"xxx","homeAddressResidentPhoneNumber":"xxx","cardHolderSignatureImage":"xxx","adoption_before":(self.adoptedBefore as! String),"adoption_from":"xxx","child_gender_id":(self.desiredGender as! String),"child_age":(self.desiredAge as! String),"adoption_reason":(self.adoptionReason as! String),"child_from_nursery":"yes","approve_feeding":(self.lactaction as! String),"emirates_id_front_file":emiratesIDFrontStr,"emirates_id_back_file":emiratesIDBackStr,"passport_file":passportImgStr]
            
            let ulr =  URL(string: APILayer().baseURL +  "api/SaveSSDInfoController/SaveAdoptInfo")!
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
                            self.isAlreadyBusy = false
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
