//
//  PersonalInfoVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 03/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
//import iOSDropDown

class PersonalInfoVC: UIViewController {
// hello this is test
    var faulty: Bool!
    
    @IBOutlet weak var heading1: UILabel!
    @IBOutlet weak var heading_Lbl: UILabel!
    @IBOutlet weak var heading3: UILabel!
    @IBOutlet weak var heading4: UILabel!
    
    @IBOutlet weak var nationality: TextField!
    
//    @IBOutlet weak var dob: iOSDropDown!
    @IBOutlet weak var dob: TextField!
    //    @IBOutlet weak var gender: iOSDropDown!
    @IBOutlet weak var gender: TextField!
    //    @IBOutlet weak var licenseNumber: UITextField!
    @IBOutlet weak var licenseNumber: TextField!
    //    @IBOutlet weak var licenseSource: iOSDropDown!
    @IBOutlet weak var licenseSource: TextField!
    //    @IBOutlet weak var color: iOSDropDown!
    @IBOutlet weak var color: TextField!
    //    @IBOutlet weak var source: iOSDropDown!
    @IBOutlet weak var source: TextField!
    //    @IBOutlet weak var plateNumber: UITextField!
   
    @IBOutlet weak var navBar: NavBar!
    
    @IBOutlet weak var plateCode: TextField!
    
    @IBOutlet weak var plateNumber: TextField!
//    @IBOutlet weak var policyNumber: UITextField!
    @IBOutlet weak var policyNumber: TextField!
//    @IBOutlet weak var insuranceNum: UITextField!
    @IBOutlet weak var insuranceNum: TextField!
    //    @IBOutlet weak var insuranceExp: UITextField!
    @IBOutlet weak var insuranceExp: TextField!
    //    @IBOutlet weak var ownersName: UILabel!
    @IBOutlet weak var ownersName: TextField!
    //    @IBOutlet weak var mobileNum: UILabel!
    @IBOutlet weak var mobileNum: TextField!
    //    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var emailAddress: TextField!
    
    var location: CLLocation!
    var type: String!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var saveButton: UIButton!
   
    // for Faulty car details
    var plateCodeString: String!
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
    
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    
    @IBAction func dobPickerPressed(_ sender: UIButton) {
   
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
        
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
//            self.dob. = dateFormatter.string(from: date)
        }
    }
    
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        Utility.setView()
        
        heading_Lbl.textAlignment = Utility.isArabicSelected() ? .right : .left
        heading1.textAlignment = Utility.isArabicSelected() ? .right : .left
         heading3.textAlignment = Utility.isArabicSelected() ? .right : .left
         heading4.textAlignment = Utility.isArabicSelected() ? .right : .left
        print("Current Screen : \(self.type ?? "unknown") - isFaulty: \(self.faulty ?? false)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Utility.isArabicSelected() {
            dob.hint = "تاريخ الميلاد *"
            gender.hint = "الجنس *"
            licenseNumber.hint = "رقم الرخصة *"
            licenseSource.hint = "المصدر *"
            color.hint = "اللون *"
            source.hint = "المصدر *"
            plateNumber.hint = "رقم لوحة المركبة *"
            policyNumber.hint = "رقم بوليصة التأمين *"
            insuranceNum.hint = "شركة التأمين *"
            insuranceExp.hint = "تاريخ انتهاء التأمين *"
            ownersName.hint = "اسم المالك *"
            mobileNum.hint = "الهاتف المتحرك *"
            emailAddress.hint = "البريد الإلكتروني *"
            plateCode.hint = "رمز لوحة المركبة *"
            nationality.hint = "الجنسية"
            
            nationality.options = nationalityList_Arabic
            gender.options = "ذكر,انثى"
            color.options =  "أبيض,أسود,فضة"
            source.options = "أبو ظبي,دبي,الشارقة,عجمان,أم القيوين, رأس الخيمة ,الفجيرة,شرطة أبو ظبي, الجيش, الوزارة الداخلية,M.O.F.A"
            
            licenseSource.options = source.options
        } else {
            
            dob.hint = "Date of Birth *"
            gender.hint = "Gender *"
            licenseNumber.hint = "License Number *"
            licenseSource.hint = "Source *"
            color.hint = "Color *"
            source.hint = "Source *"
            plateNumber.hint = "Plate Number *"
            policyNumber.hint = "Insurance Policy Number *"
            insuranceNum.hint = "Insurance Company *"
            insuranceExp.hint = "Insurance Expiry Date *"
            ownersName.hint = "Owner's Name *"
            mobileNum.hint = "Mobile Number *"
            emailAddress.hint = "Email *"
            plateCode.hint = "Plate Code *"
            nationality.hint = "Nationality *"
        }
        
        self.mobileNum.textField.keyboardType = .numberPad
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.internalView.frame.height)
//        source.optionArray = ["ABU DHABI","DUBAI","SHARJAH","AJMAN","UMM AL QUWAIN","RAS AL KHAIMAH","FUJAIRAH","ABU DHABI POLICE","ARMY","MINISTRY OF INTERIOR","M.O.F.A" ]
        
//        color.optionArray = ["White", "Black", "Silver", "Silver"]
        
//        licenseSource.optionArray = ["ABU DHABI","DUBAI","SHARJAH","AJMAN","UMM AL QUWAIN","RAS AL KHAIMAH","FUJAIRAH","ABU DHABI POLICE","ARMY","MINISTRY OF INTERIOR","M.O.F.A"]
        
//        gender.optionArray = ["Male", "Female"]
        
        
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "المعلومات الشخصية"
            } else {
                self.navBar.title.text = "Personal Information"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if (!faulty)
        {
            if (validated())
            {
                self.performSegue(withIdentifier: "nexttononfaulty", sender: self)
            }
        }
        else
        {
            if (validated())
            {
                self.performSegue(withIdentifier: "next", sender: self)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//
//        if (segue.identifier == "next")
//        {
//
//            var dest = segue.destination as? PicturesVC
//            dest?.location = self.location
//            dest?.type = self.type
//
//            dest?.plateNumberString = self.plateNumber.textField.text!
//            dest?.sourceString = self.source.textField.text!
//            dest?.colorString = self.color.textField.text!
//            dest?.licenseSourceString = self.licenseSource.textField.text!
//            dest?.LicenseNumberString = self.licenseNumber.textField.text!
//            dest?.genderString = self.gender.textField.text!
//            dest?.dobString = self.dob.textField.text!
//            dest?.policyNumString = self.policyNumber.textField.text!
//            dest?.insuranceCompanyString = self.insuranceNum.textField.text!
//            dest?.insuranceExpiryString = self.insuranceExp.textField.text!
//            dest?.ownerNameString = self.ownersName.textField.text!
//            dest?.mobileNumString = self.mobileNum.textField.text!
//            dest?.EmailAddressString = self.emailAddress.textField.text!
//
//        }
        
        if (segue.identifier == "next")
        {
            var dest = segue.destination as! PicturesVC
            dest.location = self.location
            dest.type = self.type
            
            dest.plateNumberString = self.plateNumber.textField.text!
            dest.sourceString = self.source.textField.text!
            dest.colorString = self.color.textField.text!
            dest.licenseSourceString = self.licenseSource.textField.text!
            dest.LicenseNumberString = self.licenseNumber.textField.text!
            dest.genderString = self.gender.textField.text!
            dest.dobString = self.dob.textField.text!
            dest.policyNumString = self.policyNumber.textField.text!
            dest.insuranceCompanyString = self.insuranceNum.textField.text!
            dest.insuranceExpiryString = self.insuranceExp.textField.text!
            dest.EmailAddressString = self.emailAddress.textField.text!
            dest.NationalityString = self.nationality.textField.text!
            dest.ownerNameString = self.ownersName.textField.text!
            dest.mobileNumString = self.mobileNum.textField.text!
            
            dest.fn_plateNumberString = self.fn_plateNumberString
            dest.fn_sourceString = self.fn_sourceString
            dest.fn_colorString = self.fn_colorString
            dest.fn_licenseSourceString = self.fn_licenseSourceString
            dest.fn_LicenseNumberString = self.fn_LicenseNumberString
            dest.fn_genderString = self.fn_genderString
            dest.fn_dobString = self.fn_dobString
            dest.fn_policyNumString = self.fn_policyNumString
            dest.fn_insuranceCompanyString = self.fn_insuranceCompanyString
            dest.fn_insuranceExpiryString = self.fn_insuranceExpiryString
            dest.fn_ownerNameString = self.fn_ownerNameString
            dest.fn_mobileNumString = self.fn_mobileNumString
            dest.fn_EmailAddressString = self.fn_EmailAddressString
            dest.fn_NationalityString = self.fn_NationalityString
            
        }
        else{
            
            var dest = segue.destination as! PersonalInfoVC
            dest.location = self.location
            dest.type = self.type
            dest.faulty = true
            
            dest.fn_plateNumberString = self.plateNumber.textField.text!
            dest.fn_sourceString = self.source.textField.text!
            dest.fn_colorString = self.color.textField.text!
            dest.fn_licenseSourceString = self.licenseSource.textField.text!
            dest.fn_LicenseNumberString = self.licenseNumber.textField.text!
            dest.fn_genderString = self.gender.textField.text!
            dest.fn_dobString = self.dob.textField.text!
            dest.fn_policyNumString = self.policyNumber.textField.text!
            dest.fn_insuranceCompanyString = self.insuranceNum.textField.text!
            dest.fn_insuranceExpiryString = self.insuranceExp.textField.text!
            dest.fn_ownerNameString = self.ownersName.textField.text!
            dest.fn_mobileNumString = self.mobileNum.textField.text!
            dest.fn_EmailAddressString = self.emailAddress.textField.text!
            dest.fn_NationalityString = self.nationality.textField.text!
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
