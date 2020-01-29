//
//  InfoVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 03/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class InfoVC: UIViewController {
    
    var location: CLLocation!
    var type: String!
    var plateNumberString: String!
    var sourceString: String!
    var colorString: String!
    var licenseSourceString: String!
    var LicenseNumberString: String!
    var genderString: String!
    var dobString: String!
    var policyNumString: String!
    var insuranceCompanyString: String!
    var insuranceExpiryString: String!
    var ownerNameString: String!
    var mobileNumString: String!
    var EmailAddressString: String!
    var NationalityString: String!
    var images:[UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]

    
    // for Non-Faulty car details
    var fn_plateCodeString: String!
    var fn_plateNumberString: String!
    var fn_sourceString: String!
    var fn_colorString: String!
    var fn_licenseSourceString: String!
    var fn_LicenseNumberString: String!
    var fn_genderString: String!
    var fn_dobString: String!
    var fn_policyNumString: String!
    var fn_insuranceCompanyString: String!
    var fn_insuranceExpiryString: String!
    var fn_ownerNameString: String!
    var fn_mobileNumString: String!
    var fn_EmailAddressString: String!
    var fn_NationalityString: String!
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var tableView: UITableView!
    

    var arrEn = ["Plate Number","Source","Color","Licence Source","License Num","Gender","Date of Birth","Nationality","Policy Number","Insurance Company","Insurance Expiry","Owners Name","Mobile Number","Email Address"]
    
    var arrAr = [
        "رقم اللوحة"
        , "المصدر"
        , "اللون"
        , "مصدر الترخيص"
        , "رقم الترخيص"
        , "الجنس"
        , "تاريخ الميلاد"
,"الجنسية"
        , "رقم البوليصة"
        , "شركة التأمين"
        , "انتهاء التأمين"
        , " اسم المالكين "
        ," رقم الجوال "
        ," عنوان البريد الإلكتروني "
    ]
    
    
    var isAlreadyBusy = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "ملخص الحادث"
            } else {
                navBar.title.text = "Accident Summary"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
    }
    
    @IBAction func submitReport(_ sender: UIButton) {
        if(!isAlreadyBusy)
        {
            //self.submitData()
            if Reachability.isConnectedToNetwork()
            {
                if(Utility.checkSesion())
                {
                    apicallHttps()
                }
                else
                {
                    isAlreadyBusy = true
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
    
    
    func apicallHttps(){
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
    
        var arrayOfImageStr = [String]()
        for imageObject in self.images {
            if(imageObject != nil)
            {
                if(imageObject != UIImage())
                {
                    var ImageStr = "";
                    do {
                        try imageObject.compressImage(7, completion: { (image, compressRatio) in
                            print(image.size)
                            let imageData = image.jpegData(compressionQuality: compressRatio)
                            ImageStr = imageData!.base64EncodedString(options: []) ?? ""
                        })
                    } catch {
                        print("Error")
                    }
                    arrayOfImageStr.append(ImageStr)
                }
            }
        }
        
        
        
        /*var params:[String: Any] = [
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
            "gender_id":(self.gender2 as! String),
            "marital_status_id":"1",
            "hc_category_id":(self.category2 as! String),
            "date_of_birth":(self.dob2 as! String),
            "emirates_id":(self.emiratesID2 as! String),
            "branch_id":(self.branch2 as! String),
            "medical_file":medicalReportImgStr,
            "emirates_id_front_file":emiratesIDFrontStr,
            "emirates_id_back_file":emiratesIDBackStr,
            "passport_file":passportImgStr
        ]*/

        var params:[String: Any] = [
          "username": "sHjEg0vT",
          "password": "$&FsX==vVl3u9>c",
          "appApi": "ndc04i4uhYtWmUGHFw4GLwJn68QW5GWWXtVB9b5bGSpYMuW76lMjPpsViVXWr8qV",
          "sessionId": "vOBmst4N1L07oxXnhIzgu6D5efW8Zd5e27ec8bcbe323.43285927",
          "vehicleDetails": [
            [
              "trfPlateCombinationIdName": ("PRIVATE - " + (self.colorString as! String)),
              "isLiable": "true",
              "licenseSourceName": (self.licenseSourceString as! String),
              "sourceCodeName": (self.sourceString as! String),
              "gender": (self.genderString as! String),
              "licenseSourceCode": 1,
              "nationalityId": 205,
              "plateSourceCode": 60,
              "licenseNumber": (self.LicenseNumberString as! String),
              "dob": (self.dobString as! String),
              "InsuranceExpiryDate": (self.insuranceExpiryString as! String),
              "OwnerTcfEnglishName": (self.ownerNameString as! String),
              "mobileNumber": (self.mobileNumString as! String),
              "OwnerTcfArabicName": (self.ownerNameString as! String),
              "email": (self.EmailAddressString as! String),
              "plateNumber": (self.plateNumberString as! String),
              "plateSourceCodeDetails": 60,
              "InsurancePolicyNo": (self.policyNumString as! String),
              "InsuranceKindEnglishDesc": "1",
              "InsuranceCompanyName": (self.insuranceCompanyString as! String),
              "nationalityName": (self.NationalityString as! String)
            ],
            [
              "trfPlateCombinationIdName": ("PRIVATE - " + (self.fn_colorString as! String)),
              "isLiable": "false",
              "licenseSourceName": (self.fn_licenseSourceString as! String),
              "sourceCodeName": (self.fn_sourceString as! String),
              "gender": (self.fn_genderString as! String),
              "licenseSourceCode": 1,
              "nationalityId": 260,
              "plateSourceCode": 60,
              "licenseNumber": (self.fn_LicenseNumberString as! String),
              "dob": (self.fn_dobString as! String),
              "InsuranceExpiryDate": (self.fn_insuranceExpiryString as! String),
              "OwnerTcfEnglishName": (self.fn_ownerNameString as! String),
              "mobileNumber": (self.fn_mobileNumString as! String),
              "OwnerTcfArabicName": (self.fn_ownerNameString as! String),
              "email": (self.fn_EmailAddressString as! String),
              "plateNumber": (self.fn_plateNumberString as! String),
              "plateSourceCodeDetails": 60,
              "InsurancePolicyNo": (self.fn_policyNumString as! String),
              "InsuranceKindEnglishDesc": "2",
              "InsuranceCompanyName": (self.fn_insuranceCompanyString as! String),
              "nationalityName": (self.fn_NationalityString as! String)
            ]
          ],
          "reportDetails": [
            "invlovedVehicle": 2,
            "agreed": true,
            "longitude": (self.location == nil) ? 0.0 : self.location.coordinate.longitude,
            "latitude": (self.location == nil) ? 0.0 : self.location.coordinate.latitude,
            "address": "",
            "accCauseId": 1,
            "accidentCause": self.type,
            "injuryType": 0
          ],
          "isPayNow": 0,
          //"images": [ImageStr]
          "images": arrayOfImageStr
        ]
        
        var urlPart = "api/MinorAccidentReporting/SubmitAccidentReport";
        let ulr =  URL(string: APILayer().baseURL +  urlPart)!
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
                                let status = respJson.value(forKey: "status") as! String
                                if(status == "success")
                                {
                                    if let paymentUrl = respJson.value(forKey: "paymentUrl") as? String{
                                        
                                        if let accidentNo = respJson.value(forKey: "accidentNo") as? String{
                                            
                                            let otherAlert = UIAlertController(title: self.navBar.title.text, message: "Accident I'd : ".localized() + accidentNo, preferredStyle: UIAlertController.Style.alert)
                                            let dismiss = UIAlertAction(title: "PAY".localized(), style: .default) { (action:UIAlertAction) in
                                                if let url = URL(string: paymentUrl), UIApplication.shared.canOpenURL(url) {
                                                            if #available(iOS 10.0, *) {
                                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)}
                                                            else {
                                                                UIApplication.shared.openURL(url)
                                                                }
                                                }
                                                self.navigationController?.dismiss(animated: true, completion: nil)
                                            }
                                            otherAlert.addAction(dismiss)
                                            self.present(otherAlert, animated: true, completion: nil)
                                            
                                        }
                                        
                                    }
                                }
                                else
                                {
                                    if let message = respJson.value(forKey: "errorMessage") as? String{
                                        let otherAlert = UIAlertController(title: self.navBar.title.text, message: message, preferredStyle: UIAlertController.Style.alert)
                                                        let dismiss = UIAlertAction(title: "OK".localized(), style: .default) { (action:UIAlertAction) in
                                                            //self.navigationController?.dismiss(animated: true, completion: nil)
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
    
    /*func submitData(){
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
        self.navigationController?.dismiss(animated: true, completion: nil)
        
//        SetDefaultWrappers().showAlert(info:"Application has been Submitted", viewController: self)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InfoVC: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 14
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            var t = "Faulty car details"
            if Utility.isArabicSelected()
            {
                t = "تفاصيل سيارة المتسبب"
            }
            return t
        }
        else
        {
            var t = "Non-Faulty car details"
            if Utility.isArabicSelected()
            {
                t = "تفاصيل سيارة المتضرر"
            }
            return t
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "basicCell") as! UITableViewCell
        
        if indexPath.section == 0
        {
            if Utility.isArabicSelected()
                {
                    switch indexPath.row{
                    case 0:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.plateNumberString
                     case 1:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.sourceString
                     case 2:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.colorString
                     case 3:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.licenseSourceString
                     case 4:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.LicenseNumberString
                     case 5:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.genderString
                     case 6:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.dobString
                     case 7:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.NationalityString
                     case 8:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.policyNumString
                     case 9:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceCompanyString
                     case 10:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceExpiryString
                     case 11:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.ownerNameString
                     case 12:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.mobileNumString
                     case 13:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.EmailAddressString
                    
                    default:
                        cell.textLabel?.text = ""
                        cell.detailTextLabel?.text = ""
                    }
                }
                else
                {
                    switch indexPath.row{
                    case 0:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.plateNumberString
                     case 1:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.sourceString
                     case 2:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.colorString
                     case 3:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.licenseSourceString
                     case 4:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.LicenseNumberString
                     case 5:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.genderString
                     case 6:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.dobString
                     case 7:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.NationalityString
                     case 8:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.policyNumString
                     case 9:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceCompanyString
                     case 10:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceExpiryString
                     case 11:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.ownerNameString
                     case 12:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.mobileNumString
                     case 13:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.EmailAddressString
                    
                    default:
                        cell.textLabel?.text = ""
                        cell.detailTextLabel?.text = ""
                    }
                }
                
                return cell
        
        }
        else
        {
            
            cell =  self.fillCellData(cell: cell, indexPath: indexPath)
            return cell
            
        }
        
}

    
    func fillCellData(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell
    {
        if Utility.isArabicSelected()
        {
            switch indexPath.row{
            case 0:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_plateNumberString
             case 1:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_sourceString
             case 2:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_colorString
             case 3:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_licenseSourceString
             case 4:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_LicenseNumberString
             case 5:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_genderString
             case 6:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_dobString
             case 7:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_NationalityString
             case 8:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_policyNumString
             case 9:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceCompanyString
             case 10:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceExpiryString
             case 11:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_ownerNameString
             case 12:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_mobileNumString
             case 13:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_EmailAddressString
            
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        }
        else
        {
            switch indexPath.row{
            case 0:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_plateNumberString
             case 1:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_sourceString
             case 2:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_colorString
             case 3:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_licenseSourceString
             case 4:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_LicenseNumberString
             case 5:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_genderString
             case 6:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_dobString
             case 7:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_NationalityString
             case 8:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_policyNumString
             case 9:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceCompanyString
             case 10:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceExpiryString
             case 11:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_ownerNameString
             case 12:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_mobileNumString
             case 13:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_EmailAddressString
            
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        }
        return cell
    }

}
