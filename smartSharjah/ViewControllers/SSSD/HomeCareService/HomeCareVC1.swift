//
//  HomeCareVC1.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire
//import DropDown

class HomeCareVC1: UIViewController {

    
    @IBOutlet weak var textLabelUnderPicture: UILabel!
    
    @IBOutlet weak var imagebtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBar: NavBar!
    var titleString: String = ""
    
    @IBOutlet weak var fullNameTF: TextField!
    @IBOutlet weak var emiratiIDTF: TextField!
    @IBOutlet weak var mobileNoTF: TextField!
    @IBOutlet weak var emailAddressTF: TextField!
    @IBOutlet weak var nationalityTF: TextField!
    @IBOutlet weak var familyRegistrationTF: TextField!
    @IBOutlet weak var dobTF: TextField!
    @IBOutlet weak var placeOfBirthTF: TextField!
    @IBOutlet weak var genderTF: TextField!
    @IBOutlet weak var maritalStatusTF: TextField!
    @IBOutlet weak var numOfChildrenTF: TextField!
    
    @IBOutlet weak var testImgView: UIImageView!
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
    
    
    var isChildFieldEditable = false
    
    
//    TO DO
//     https://stg-smtshjapp.shj.ae/api/GetContactType
//     https://stg-smtshjapp.shj.ae/api/GetGender
//     https://stg-smtshjapp.shj.ae/api/GetHcCategory
//     https://stg-smtshjapp.shj.ae/api/GetMaritalStatus
//     https://stg-smtshjapp.shj.ae/api/GetVolPeriod
//     https://stg-smtshjapp.shj.ae/api/GetVolCategoryType
//     https://stg-smtshjapp.shj.ae/api/GetConsultationType
//     https://stg-smtshjapp.shj.ae/api/GetConsultationCategory
    
    
    func fillData()
    {
        let user = User().getUser()
        
         if let name  = user.value(forKey: User().name_Key) as? String
         {
            self.fullNameTF.textField.text = name
        }
        if let id  = user.value(forKey: User().emirateID_Key) as? String
        {
            self.emiratiIDTF.textField.text = id
        }
        if let mail  = user.value(forKey: User().email_Key) as? String
        {
            self.emailAddressTF.textField.text = mail
        }
        if let num  = user.value(forKey: User().mobileNumber_key) as? String
        {
            self.mobileNoTF.textField.text = num
        }
    }
    
    func setView()
    {
        if Utility.isArabicSelected()
        {
             UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fillData()
        self.setView()
    }
    
    func getData(){
        
        APILayer().getDataFromAPI(name: "GetContactType", method:.get, path: "api/ContactTypeController/GetListContactType", params: [:], headers: [:]) { (successGetContactType, GetContactType) in
            
            if (successGetContactType)
            {
                
                APILayer().getDataFromAPI(name: "GetGender", method:.get, path: "api/GenderController/GetListGender", params: [:], headers: [:]) { (successGetGender, GetGetGender) in
                    
                    if (successGetGender)
                    {
                        
                        let arr = APILayer().resolveData(input: GetGetGender!, language: "EN")
                        let css = arr.joined(separator: ",")
                        self.genderTF.options = css
                        
                        APILayer().getDataFromAPI(name: "GetHcCategory", method:.get, path: "api/HcCategoryController/GetListHcCategory", params: [:], headers: [:]) { (successGetHcCategory, GetGetHcCategory) in
                            
                            if (successGetHcCategory)
                            {
                                
                                APILayer().getDataFromAPI(name: "GetMaritalStatus", method:.get, path: "api/MaritalStatusController/GetMaritalStatus", params: [:], headers: [:]) { (successGetMaritalStatus, GetGetMaritalStatus) in
                                    
                                    if (successGetMaritalStatus)
                                    {
                                        
                                        let arr = APILayer().resolveData(input: GetGetMaritalStatus!, language: "EN")
                                        let css = arr.joined(separator: ",")
                                        self.maritalStatusTF.options = css
                                        
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
    
    override func viewDidAppear(_ animated: Bool) {
     
        if Reachability.isConnectedToNetwork()
        {
            if(Utility.checkSesion())
            {
                self.getData()
            }
            else
            {
                Utility.getFreshToken {
                    (success, response) in
                    self.getData()
                }
            }
        }
        
        
        if Utility.isArabicSelected() {
            fullNameTF.hint = "الاسم بالكامل"
            emiratiIDTF.hint = "رقم الهوية الإماراتية"
            emiratiIDTF.keyboardType = UIKeyboardType.numberPad
            mobileNoTF.hint = "رقم الجوال"
            emailAddressTF.hint = " البريد الإلكتروني"
            nationalityTF.hint = "الجنسية"
            familyRegistrationTF.hint = "بطاقة الملكية"
            dobTF.hint = "تاريخ الميلاد"
            placeOfBirthTF.hint = "محل الميلاد"
            genderTF.hint = "الجنس"
            maritalStatusTF.hint = "الحالة الاجتماعية"
            numOfChildrenTF.hint = "عدد الأطفال"
            numOfChildrenTF.keyboardType = UIKeyboardType.numberPad
            
            genderTF.options = "ذكر,انثى"
            maritalStatusTF.options = "متزوج,اعزب,مطلقة,أرملة"
            nationalityTF.options = nationalityList_Arabic
            
        } else {
            fullNameTF.hint = "Full Name *"
            emiratiIDTF.hint = "Emirates ID No *"
            emiratiIDTF.keyboardType = UIKeyboardType.numberPad
            //self.testKaede.keyboardType = UIKeyboardType.numberPad
            mobileNoTF.hint = "Mobile Number *"
            mobileNoTF.keyboardType = UIKeyboardType.numberPad
            emailAddressTF.hint = "Email Address *"
            nationalityTF.hint = "Nationality *"
            familyRegistrationTF.hint = "Family Registration Card *"
            dobTF.hint = "Date of Birth *"
            placeOfBirthTF.hint = "Place of Birth *"
            genderTF.hint = "Gender *"
            maritalStatusTF.hint = "Marital Status *"
            numOfChildrenTF.hint = "Number of Children *"
            numOfChildrenTF.keyboardType = UIKeyboardType.numberPad
        }
    }
    
    
    @objc func donePressed()
    {
        print("Done pressed")
        
        if maritalStatusTF.textField.text == "Unmarried" || maritalStatusTF.textField.text == "اعزب"
        {
            self.numOfChildrenTF.textField.text = "0"
            self.isChildFieldEditable = false
           
        }
        else
        {
            self.numOfChildrenTF.textField.text = ""
            self.isChildFieldEditable = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.donePressed), name: NSNotification.Name(rawValue: "donePressed"), object: nil)
        
        self.emiratiIDTF.textField.delegate = self
        self.mobileNoTF.textField.delegate = self
        self.emiratiIDTF.textField.keyboardType = .numberPad
        
        if (self.navBar != nil)
        {
//            self.navBar.title.text = titleString
        
            
                        
            if Utility.isArabicSelected(){
            
                if titleString.contains("متطوعون بدائرة الخدمات الاجتماعية بالشارقة")
                {
                    self.titleString = "وظائف الخدمات الاجتماعية"
                    self.navBar.title.text = self.titleString
                }
                else
                {
                    self.navBar.title.text = self.titleString
                }
                if(self.titleString != ""){
                    if(self.titleString.lowercased().contains("job seeker")){
                        self.navBar.title.text = "الباحث عن عمل"
                    }
                }
                textLabelUnderPicture.text = "تحديث البيانات الشخصية الخاصة بك"
            }
            else
            {
                self.navBar.title.text = self.titleString
            }
            
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        // Do any additional setup after loading the view.
        
        self.numOfChildrenTF.textField.delegate = self
        self.maritalStatusTF.picker.delegate = self
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 1250)
    }
    
    
    @IBAction func choosePickerPressed(_ sender: UIButton) {
        
        let pickerController = UIImagePickerController()
//        pickerController.allowsEditing = true
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
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
        
//        self.performSegue(withIdentifier: "next", sender: self)
        
//        if ( self.fullNameTF.textField.text != "" )
//        {
//            self.fullName = self.fullNameTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(fullNameTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.emiratiIDTF.textField.text != "" )
//        {
//            self.emiratiID = self.emiratiIDTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(emiratiIDTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.mobileNoTF.textField.text != "" )
//        {
//            self.mobileNo = self.mobileNoTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(mobileNoTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.emailAddressTF.textField.text == "" || self.emailAddressTF.textField.text == nil )
//        {
//            SetDefaultWrappers().showAlert(info: "\(emailAddressTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//
//        }
//        else if(APILayer().validateEmailAddress(enteredEmail: self.emailAddressTF.textField.text!) == false){
//            SetDefaultWrappers().showAlert(info: "\(emailAddressTF.hintLbl.text!) enter valid email.", viewController: self)
//            return
//        }
//        else
//        {
//            self.emailAddress = self.emailAddressTF.textField.text
//        }
//
//        if ( self.nationalityTF.textField.text != "" )
//        {
//            self.nationality = self.nationalityTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(nationalityTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.familyRegistrationTF.textField.text != "" )
//        {
//            self.familyRegistration = self.familyRegistrationTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(familyRegistrationTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.dobTF.textField.text != "" )
//        {
//            self.dob = self.dobTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(dobTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//        if ( self.placeOfBirthTF.textField.text != "" )
//        {
//            self.placeOfBirth = self.placeOfBirthTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(placeOfBirthTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.genderTF.textField.text != "" )
//        {
//            self.gender = self.genderTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(genderTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//
//        if ( self.maritalStatusTF.textField.text != "" )
//        {
//            self.maritalStatus = self.maritalStatusTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(maritalStatusTF.hintLbl.text!) \("cannot be empty".localized())", viewController: self)
//            return
//        }
//        if ( self.numOfChildrenTF.textField.text != "" && self.numOfChildrenTF.validate())
//        {
//            self.numOfChildren = self.numOfChildrenTF.textField.text
//        }
//        else
//        {
//            SetDefaultWrappers().showAlert(info: "\(numOfChildrenTF.hintLbl.text!) is invalid", viewController: self)
//            return
//        }
        
        if (self.validated())
        {
            self.performSegue(withIdentifier: "next", sender: self)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let img = info[.originalImage] as? UIImage {
            
            print ("ImageInfo: \(img.size.height) \(img.size.width)")
            self.testImgView.image = img
            self.imagebtn.setBackgroundImage(self.testImgView.image!, for: .normal)
            self.picture = img
        }
        
        
        picker.dismiss(animated: true, completion: nil)
        //        self.pickerController(picker, didSelect: image)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let dest = segue.destination as! HomeCareVC1a
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
        dest.picture = picture
    }
}

extension HomeCareVC1: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension HomeCareVC1: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.numOfChildrenTF.textField
        {
            if !isChildFieldEditable
            {
                textField.endEditing(true)
                return false
            }
        }
        
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("testing...")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
    
    
}

extension HomeCareVC1: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Test....")
    }
    

}
