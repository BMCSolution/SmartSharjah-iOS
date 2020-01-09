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

        if ( self.desiredGenderTF.textField.text != "" )
        {
            self.desiredGender = self.childAdoptionTF.textField.text
        }
        else
        {
            SetDefaultWrappers().showAlert(info: "\(childAdoptionTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
            return
        }

        if ( self.desiredGenderTF.textField.text != "" )
        {
            self.desiredGender = self.desiredGenderTF.textField.text
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
        
//        SetDefaultWrappers().showAlert(info:"Application has been Submitted", viewController: self)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    func apicallHttps(){
            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        
            /*var params:[String: Any] = [
            "countryCode" : txtCode.textField.text!,
            "mobile" : txtPhoneNum.textField.text!,
            "name" : txtFullName.textField.text!,
            "jobType" : "ADVANCE",
            "pickupAddrText" : self.txtPickupLocation.textField.text!,
            "pickupAddrLat" : currentLat,
            "pickupAddrLon" : currentLong,
            "dropoffAddrText" : txtDropoffLocation.textField.text!,
            "dropoffAddrLat" : dropOffLat,
            "dropoffAddrLon" : dropOfflong,
            "vehicleTypeId" : 30,
            "driverNotes" : driverNotes_txtView.text!,
            "notificationToken" : 123,
            "paymentMode" : 2 ,
            "recurrenceId": "-1",
            "accessToken": "",
            "pickupTime" : self.txtPickerDateTime.textField.text!
            ]*/
        
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
        
        var params:[String: Any] = ["uuid":"54654545646546222222254654546","userType":"SOP3","mobile":"971508041141","email":self.emailAddress,"idn":"784111111111111","dob":self.dob,"photo":"xxx","placeOfBirthAR":self.placeOfBirth,"firstnameAR":"xxx","fullnameAR":"xxx","idCardNumber":"xxx","idCardIssueDate":"xxx","idCardExpiryDate":"xxx","fullnameEN":"xxx","firstnameEN":"xxx","lastnameEN":"xxx","lastnameAR":"xxx","gender":"xxx","nationalityAR":"xxx","nationalityEN":"xxx","residencyNumber":"xxx","maritalStatus":"xxx","passportNumber":"xxx","upassportCountryDescriptionAR":"xxx","passportCountryDescriptionEN":"xxx","passportIssueDate":"xxx","passportExpiryDate":"xxx","idType":"xxx","cardSerialNumber":"xxx","occupationCode":"xxx","titleAR":"xxx","titleEN":"xxx","motherFirstNameAR":"xxx","motherFirstNa meEN":"xxx","familyNumber":"xxx","husbandIDN":"xxx","residencyType":"xxx","residencyExpiryDate":"xxx","placeOfBirthEN":"xxx","occupationTypeAR":"xxx","occupationTypeEN":"xxx","motherFullNameAR":"xxx","motherFullNameEN":"xxx","companyNameAR":"xxx","companyNameEN":"xxx","passportTypeCode":"xxx","qualificationLevelCode":"xxx","qualificationLevelDescriptionAR":"xxx","qualificationLevelDescriptionEN":"xxx","degreeDescriptionAR":"xxx","degreeDescriptionEN":"xxx","fieldOfStudyCode":"xxx","fieldOfStudyAR":"xxx","fieldOfStudyEN":"xxx","placeOfStudyAR":"xxx","placeOfStudyEN":"xxx","dateOfGraduation":"xxx","homeAddressTypeCode":"xxx","homeLocationCode":"xxx","homeAddressEmirateCode":"xxx","homeAddressEmirateDescriptionAR":"xxx","homeAddressEmirateDescriptionEN":"xxx","homeAddressCityCode":"xxx","homeAddressCityDescriptionAR":"xxx","homeAddressCityDescriptionEN":"xxx","homeAddressStreetAR":"xxx","homeAddressStreetEN":"xxx","homeAddressPOBox":"xxx","homeAddressA reaCode":"xxx","homeAddressA reaDescriptionAR":"xxx","homeAddressA reaDescriptionEN":"xxx","homeAddressBuildingNameAR":"xxx","homeAddressBuildingNameEN":"xxx","homeAddressFlatNo":"xxx","homeAddressResidentPhoneNumber":"xxx","cardHolderSignatureImage":"xxx","adoption_before":self.adoptedBefore,"adoption_from":"test","child_gender_id":self.desiredGender,"child_age":self.desiredAge,"adoption_reason":self.adoptionReason,"child_from_nursery":"yes","approve_feeding":"no","emirates_id_front_file":"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==","emirates_id_back_file":"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==","passport_file":"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg=="]
            
            let ulr =  URL(string: APILayer().baseURL +  "api/SaveSSDInfoController/SaveAdoptInfo")!
            var request = URLRequest(url: ulr as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let userDefaults = UserDefaults.standard
               
                      let accesstoken = userDefaults.object(forKey: "access_token") as! String
                      let authData = accesstoken
            request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
            let data = try! JSONSerialization.data(withJSONObject: [], options: JSONSerialization.WritingOptions.prettyPrinted)

                       let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                       if let json = json {
                           print(json)
                       }
                       request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            
            Alamofire.request(request as! URLRequestConvertible)
                .responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("\(response.error)")
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
