//
//  TextField.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MobileCoreServices

class TextField: UIView {


    var docUrls:[URL] = [];
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var hintLbl: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var date_picker = UIDatePicker()
    var doc_picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
    var imgPicker = UIImagePickerController()
    var items:[String] = []
    var img:UIImage?
    var textType = "String"

    var maritalStatus_Ar = "متزوج,اعزب,مطلقة,أرملة"
    var gender_Ar = "ذكر,انثى"
    var sourceTypes_Ar = "أبو ظبي,دبي,الشارقة,عجمان,أم أل قون,راس أل خيمة,الفجيرة,شرطة أبو ظبي,جيش,وزارة الداخلية,M.O.F.A"
    var colors_Ar = "أبيض,أسود,فضة"
    var employmentStatus_Ar = "العاملين ,عاطلين عن العمل"
    var taxi_type_Ar = "تاكسي عادي,سيدات تاكسي,الاحتياجات الخاصة"
    
    func getLookupsFromPrefs(forKey: String) -> String
    {
        let userDefs = UserDefaults.standard
        if let val = userDefs.value(forKey: forKey) as? String
        {
            return val
        }
        return ""
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        IQKeyboardManager.shared.enable = true
        initSubviews()
        

    }
    func configureLabel() {
        self.textField.font = UIFont.systemFont(ofSize: self.hintLbl.font.pointSize)
        self.hintLbl.font = UIFont.systemFont(ofSize: self.hintLbl.font.pointSize)
        self.hintLbl.text = self.hintLbl.text!.firstUppercased
        //name: "GE_SS_Two_Medium", size: self.hintLbl.font.pointSize
    }

    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }


    func validate() -> Bool{


        var vc:UIViewController!

        if var topController = UIApplication.shared.keyWindow?.rootViewController {

            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                vc = topController
            }

            // topController should now be your topmost view controller
        }


        if ( self.textField.text! == "" && !self.hint.contains("Driver Notes") )
        {
            var t = "cannot be empty"
            if Utility.isArabicSelected()
            {
                t = "لايمكن ان يكون فارغا"
            }

            SetDefaultWrappers().showAlert(info:"\(self.hintLbl.text!.replacingOccurrences(of: "*", with: "")) " + t, viewController: vc)
            return false
        }
        
        if (self.hintLbl.text!.lowercased().contains("plate number"))
        {
            var n = "Invalid Number in"
            if Utility.isArabicSelected()
            {
                n = "رقم غير صالح في"
            }
            
            if (!self.textField.text!.isValidNumber() )
            {
                SetDefaultWrappers().showAlert(info: n + " \(self.hintLbl.text!.replacingOccurrences(of: "*", with: ""))", viewController: vc)
                return self.textField.text!.phoneNumberValidation()
            }
        }
        

        if (textType == "Email" || self.hintLbl.text!.contains("mail")) || self.hintLbl.text!.contains(" البريد الإلكتروني")
        {
            var e = "Invalid email in"
            if Utility.isArabicSelected()
            {
                e = "بريد إلكتروني غير صالح في"
            }
            
            if (!self.textField.text!.isValidEmail())
            {
                SetDefaultWrappers().showAlert(info: e + " \(self.hintLbl.text!.replacingOccurrences(of: "*", with: ""))", viewController: vc)
                return self.textField.text!.isValidEmail()
            }


        }

        if (textType == "Number")
        {
            var n = "Invalid Number in"
           if Utility.isArabicSelected()
           {
               n = "رقم غير صالح في"
           }
            if (!self.textField.text!.isValidNumber())
            {
                SetDefaultWrappers().showAlert(info: n + " \(self.hintLbl.text!.replacingOccurrences(of: "*", with: ""))", viewController: vc)
                return self.textField.text!.isValidNumber()
            }

        }
        if (textType == "Mobile Number")
        {
            var n = "Invalid Phone number (e.g: 971XXXXXXXXX)" //"Invalid Phone Number in"
            if Utility.isArabicSelected()
            {
                n = "رقم الهاتف غير صالح (على سبيل المثال: 971xxxxxxxxx)"//"رقم هاتف غير صالح في"
            }
            if (!self.textField.text!.phoneNumberValidation() )
            {
                SetDefaultWrappers().showAlert(info: n, viewController: vc)
                return self.textField.text!.phoneNumberValidation()
            }

        }
        if (self.hintLbl.text!.lowercased().contains("mobile")) || self.hintLbl.text!.contains("رقم الجوال")
        {
            var n = "Invalid Phone number (e.g: 971XXXXXXXXX)" //"Invalid Phone Number in"
            if Utility.isArabicSelected()
            {
                n = "رقم الهاتف غير صالح (على سبيل المثال: 971xxxxxxxxx)"//"رقم هاتف غير صالح في"
            }
            if (!self.textField.text!.phoneNumberValidation() )
            {
                SetDefaultWrappers().showAlert(info: n, viewController: vc)
                return self.textField.text!.phoneNumberValidation()
            }
        }
        if (self.type.lowercased().contains("halftest"))
        {
            var n = "Invalid Phone Number in"
            if Utility.isArabicSelected()
            {
                n = "رقم هاتف غير صالح في"
            }
            if (!self.textField.text!.halfPhoneNumberValidation() )
            {
                SetDefaultWrappers().showAlert(info: n + " \(self.hintLbl.text!.replacingOccurrences(of: "*", with: ""))", viewController: vc)
                return self.textField.text!.halfPhoneNumberValidation()
            }
        }
        if (textType == "String")
        {
            //            self.backgroundColor = .red
            return true
        }
        
        
        
        


        return true
    }



    var labelHint: String? {
        get { return hintLbl?.text }
        set {
            
            hintLbl.text = newValue!.lowercased().firstCapitalized
        }
    }

    var textFieldHint: String? {
        get { return textField?.text }
        set { textField.placeholder = newValue }
    }


    @IBInspectable var hint: String = "" {
        didSet {
            if (hint.contains("*"))
            {
//                self.hint = hint
            }
            else
            {
                self.hint = "\(hint)*"
            }
            
            if (hint.lowercased().contains("plate number"))
            {
                self.textField.keyboardType = .numberPad
            }
            
            self.labelHint = hint.firstUppercased
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var isPassword: Bool = false {
        didSet {
            self.textField.textContentType = .password
            self.textField.isSecureTextEntry = true
            self.setNeedsDisplay()
        }
    }


    @IBInspectable var inputType: String = "String" {
        didSet {
            self.textType = inputType
            if (textType == "Mobile Number"){
                self.textField.keyboardType = .phonePad
                self.textField.placeholder = "97XXXXXXXXXX"
            }
            if (self.type.lowercased().contains("halftest")){
                           self.textField.keyboardType = .phonePad
                           self.textField.placeholder = "97XXXXXXXXXX"
                       }
            else if (textType == "Number"){
                self.textField.keyboardType = .numberPad
            }
        }
    }


    @IBInspectable var keyboardType: UIKeyboardType{
        get{return UIKeyboardType(rawValue: 0)!}
        set{self.textField.keyboardType = newValue}

        //        didSet{
        //            self.textField.keyboardType = keyboardType
        //        }
    }

    @IBInspectable var type: String = "text" {
        didSet {

            if (type == "dropdown"){

                self.textField.isEnabled = false
                self.textField.isHidden = false
                self.button.isHidden = true
                self.textField.delegate = self
                self.textField.resignFirstResponder()
                 self.endEditing(true)

                
                if ((labelHint?.contains("Gender"))!)
                {
                    print("*#0300")
                    self.options = self.getLookupsFromPrefs(forKey: "genderLookups")
                    
                    
                }
                else if ((labelHint?.contains("Marital Status"))!)
                {
                    print("*#0301")
                   self.options = self.getLookupsFromPrefs(forKey: "maritalStatusLookUps")
                    
                }
                else if ((labelHint?.contains("Consultation Type"))!)
                {
                    print("*#0302")
                    self.options = self.getLookupsFromPrefs(forKey: "consultationTypeLookups")
                }
                else if ((labelHint?.contains("Consultation Category"))!)
                {
                    print("*#0303")
                    self.options = self.getLookupsFromPrefs(forKey: "consultationCategoryLookups")
                }
                else if ((labelHint?.contains("Contact Type"))!)
                {
                    print("*#0304")
                    self.options = self.getLookupsFromPrefs(forKey: "contactTypeLookups")
                }
                else if ((labelHint?.contains("HcCategory"))!)
                {
                    print("*#0305")
                    self.options = self.getLookupsFromPrefs(forKey: "hcCategoryLookUps")
                }
                else if ((labelHint?.contains("GetVolPeriod"))!)
                {
                    print("*#0306")
                    self.options = self.getLookupsFromPrefs(forKey: "volPeriodLookups")
                }
                else if ((labelHint?.contains("GetVolCategoryType"))!)
                {
                    print("*#0307")
                    self.options = self.getLookupsFromPrefs(forKey: "volCategoryTypeLookups")
                }
                
                else if ((labelHint?.contains("اللون"))!)
                {
                       self.options = self.colors_Ar
                }
                else if ((labelHint?.contains("الحالة الوظيفية"))!)
                {
                    self.options = self.employmentStatus_Ar
                  
                }
                else if ((labelHint?.contains("نوع سيارة الأجرة"))!)
                {
                    self.options = self.taxi_type_Ar
                }
                else if ((labelHint?.contains("الجنس"))!)
                {
                    self.options = self.maritalStatus_Ar
                }
                else if ((labelHint?.contains("المصدر"))!)
                {
                    self.options = self.sourceTypes_Ar
                }

//                self.textField.addTarget(self, action: #selector(sayAction(_:)), for: .touchDown)
                //.addTarget(self, action: #selector(self.openPicker(textField:)), for: .touchDown)
            }
            else if (type == "date"){

                self.textField.placeholder = ""
                self.textField.isEnabled = false
                self.textField.endEditing(true)
                self.textField.isHidden = false
//                self.newTF.isHidden = true
                self.button.isHidden = true
                self.textField.delegate = self
            }
            else if (type == "datetime"){

                self.textField.isEnabled = false
                self.textField.endEditing(true)
                self.textField.isHidden = false
                self.textField.placeholder = ""
                //                self.newTF.isHidden = true
                self.button.isHidden = true
                self.textField.delegate = self
            }
            else if (type == "picture"){

                self.textField.placeholder = ""
                self.textField.isEnabled = false
                self.textField.endEditing(true)
                self.textField.isHidden = false
//                self.newTF.isHidden = true
                self.button.isHidden = true
                self.textField.delegate = self
            }
            else if (type == "doc"){

                            self.textField.placeholder = ""
                            self.textField.isEnabled = false
                            self.textField.endEditing(true)
                            self.textField.isHidden = false
            //                self.newTF.isHidden = true
                            self.button.isHidden = true
                            self.textField.delegate = self
                        }
            else{

                self.textField.isHidden = false
//                self.newTF.isHidden = true
                self.button.isHidden = true
            }

//            self.labelHint = hint
            self.setNeedsDisplay()
        }
    }

    @objc func openDatePicker(textField: UITextField) {


        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        date_picker.removeFromSuperview()

        
        if Utility.isArabicSelected()
        {
            let loc = Locale(identifier: "ar")
            date_picker.locale = loc
        }
        else
        {
           let loc = Locale(identifier: "uk")
            date_picker.locale = loc
        }
        date_picker = UIDatePicker.init()
        date_picker.backgroundColor = UIColor.white
        date_picker.setValue(UIColor.black, forKey: "textColor")
        date_picker.autoresizingMask = .flexibleWidth

        if (self.type == "date")
        {

            if (self.hintLbl.text!.lowercased().contains("issu"))
            {
                let calendar = Calendar(identifier: .gregorian)

                let currentDate = Date()
                var components = DateComponents()
                components.calendar = calendar

                components.day = 1
                components.year = 0
                components.month = 0
                let maxDate = calendar.date(byAdding: components, to: currentDate)!

                components.year = -150
                _ = calendar.date(byAdding: components, to: currentDate)!


                date_picker.maximumDate = maxDate
            }

            if (self.hintLbl.text!.lowercased().contains("expi"))
            {
                let calendar = Calendar(identifier: .gregorian)

                let currentDate = Date()
                var components = DateComponents()
                components.calendar = calendar

                components.day = 1
                components.year = 0
                components.month = 0
                let maxDate = calendar.date(byAdding: components, to: currentDate)!

                components.year = -150
                let minDate = calendar.date(byAdding: components, to: currentDate)!


                date_picker.minimumDate = Date()
            }

            if (self.hintLbl.text!.lowercased().contains("birth") || self.hintLbl.text!.lowercased().contains("dob") || self.hintLbl.text!.contains("تاريخ الميلاد"))
            {
                let calendar = Calendar(identifier: .gregorian)

                let currentDate = Date()
                var components = DateComponents()
                components.calendar = calendar

                components.year = -16
                components.month = 12
                let maxDate = calendar.date(byAdding: components, to: currentDate)!

                components.year = -150
                let minDate = calendar.date(byAdding: components, to: currentDate)!


                date_picker.maximumDate = maxDate
            }
            date_picker.datePickerMode = .date
        }
        else
        {
            date_picker.datePickerMode = .dateAndTime
        }

        date_picker.contentMode = .center
        date_picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)

        date_picker.tag = 1000

        textField.parentViewController!.view.addSubview(date_picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.tag = 1000
        toolBar.barStyle = .blackTranslucent
        var t = "Done"
        if Utility.isArabicSelected()
        {
            t = "تمّ"
        }
        toolBar.items = [UIBarButtonItem.init(title: t, style: .done, target: self, action: #selector(onDoneDateButtonTapped))]
        textField.parentViewController!.view.addSubview(toolBar)
    }

    @objc func openPicker(textField: UITextField) {
        print("myTargetFunction...")


        self.items = options.components(separatedBy: ",") as! [String]
//        print ("*Count: \(self.items.count)")

        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)

        picker.tag = 1000
        self.picker.reloadAllComponents()

        textField.parentViewController!.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        toolBar.tag = 1000
        textField.parentViewController!.view.addSubview(toolBar)
    }

    @objc func onDoneDateButtonTapped() {


        if (self.options == "future")
        {
            if (date_picker.date > Date() )
            {
                self.contentView.endEditing(true)
                let dateformatter = DateFormatter()
                if (self.type == "date")
                {dateformatter.dateFormat  = "dd/MM/yyyy"}
                else
                {dateformatter.dateFormat  = "HH:mm dd/MM/yyyy"}

                self.textField.text = dateformatter.string(from: self.date_picker.date)
                toolBar.removeFromSuperview()
                date_picker.removeFromSuperview()
            }
            else{

                var m = "Please select a Future Date"
                if Utility.isArabicSelected()
                {
                    m = "الرجاء تحديد تاريخ المستقبل"
                }
                if ( self.topMostController() as? ViewController != nil)
                {
                    SetDefaultWrappers().showAlert(info: m, viewController: self.topMostController() as! UIViewController )
                }
                else {
                    SetDefaultWrappers().showAlert(info: m, viewController: self.topMostController() as! UINavigationController )
                }


            }
        }
        else{
            self.contentView.endEditing(true)
            let dateformatter = DateFormatter()
            if (self.type == "date")
            {dateformatter.dateFormat  = "dd/MM/yyyy"}
            else
            {dateformatter.dateFormat  = "HH:mm dd/MM/yyyy"}

            self.textField.text = dateformatter.string(from: self.date_picker.date)
            toolBar.removeFromSuperview()
            date_picker.removeFromSuperview()
        }


    }

    func removeAllViewsWith(id: Int)
    {
        for x in 0...3
        {
            if let viewWithTag = self.viewWithTag(id) {
                print ("Removed")
                viewWithTag.removeFromSuperview()
            }
        }

    }

    @objc func onDoneButtonTapped() {

        self.contentView.endEditing(true)
        self.textField.text = (self.options.components(separatedBy: ",") as! [String])[self.picker.selectedRow(inComponent: 0)]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "donePressed"), object: nil)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }

    @objc private func sayAction(_ sender: UIButton?) {
            print ("Pressed!")

        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

//        self.newTF.show()
    }

    @objc func pressed(sender: UIButton!) {

        self.removeAllViewsWith(id: 1000)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        date_picker.removeFromSuperview()


        var alertView = UIAlertView()
        alertView.addButton(withTitle: "Ok")
        alertView.title = "title"
        alertView.message = "message"
        alertView.show()
    }

    @IBInspectable var options: String = "" {
        didSet {
//            if (!self.newTF.isHidden)
//            {
//                print("Setting DD")
//
////                self.newTF.frame = CGRect(x: self.textField.frame.minX, y: self.textField.frame.minY, width: self.textField.frame.width, height: self.textField.frame.height)
////                self.newTF.dataSource = options.components(separatedBy: ",") as! [String]
//
//                button.setTitleColor(.black, for: .normal)
//                button.setTitle("Select", for: .normal)
//                button.addTarget(self, action: #selector(sayAction(_:)), for: .touchUpInside)
//
//                self.setNeedsDisplay()
//            }

        }
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initSubviews()
    }

    
    func showAlertToOpenPhotos() {
        
        self.textField.isEnabled = false
        let alert = UIAlertController(title: "Choose a Type", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        self.parentViewController?.present(alert, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            imgPicker.sourceType = sourceType
            self.parentViewController?.present(imgPicker, animated: true, completion: nil)
        }
    }

    @objc func someAction(_ sender:UITapGestureRecognizer){
        print ("Action")
//        self.contentView.endEditing(true)

        self.removeAllViewsWith(id: 1000)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        date_picker.removeFromSuperview()

        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

        if (self.type == "dropdown")
        {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

            //            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            self.openPicker(textField: textField)
            //            }

        }
        else if (self.type == "picture")
        {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

//            self.imgPicker = UIImagePickerController()
//            self.imgPicker.sourceType = .photoLibrary
            self.imgPicker.delegate = self
            self.showAlertToOpenPhotos()
            
            

//            textField.parentViewController!.present(self.imgPicker, animated: true, completion: nil)
        }
        else if (self.type == "doc")
                {
                    UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

        //            self.imgPicker = UIImagePickerController()
        //            self.imgPicker.sourceType = .photoLibrary
                    self.doc_picker.delegate = self
                    
//                    self.showAlertToOpenPhotos()
                    self.parentViewController!.present(doc_picker, animated: true)
                    
                    

        //            textField.parentViewController!.present(self.imgPicker, animated: true, completion: nil)
                }
        else if (type == "date"){
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            self.openDatePicker(textField: textField)

        }
        else if (type == "datetime")
        {
             UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
             self.openDatePicker(textField: textField)
        }
        else
        {
            self.endEditing(true)

            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

        }

    }

    func initSubviews(){

        let nib = UINib(nibName: "TextField", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)

        self.configureLabel()
        let gesture = UITapGestureRecognizer(target: self, action: "someAction:")
        self.addGestureRecognizer(gesture)
        
        self.textField.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.textField.autocorrectionType = .no
//        self.newTF.didSelect{(selectedText , index ,id) in
//            self.textField.text = selectedText
//        }

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension TextField: UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        print ("Count: \(self.items.count)")
        return self.items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.items[row]
    }

    
}

extension TextField: UITextFieldDelegate{


    func textFieldDidBeginEditing(_ textField: UITextField) {

//        self.contentView.endEditing(true)


        self.removeAllViewsWith(id: 1000)

        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        date_picker.removeFromSuperview()


        if (self.type == "dropdown")
        {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);


            self.removeAllViewsWith(id: 1000)
            toolBar.removeFromSuperview()
            picker.removeFromSuperview()
            date_picker.removeFromSuperview()
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.openPicker(textField: textField)
//            }

        }
        else if (self.type == "picture")
        {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

            self.removeAllViewsWith(id: 1000)
            toolBar.removeFromSuperview()
            picker.removeFromSuperview()
            date_picker.removeFromSuperview()

            self.imgPicker = UIImagePickerController()
            self.imgPicker.sourceType = .photoLibrary
            self.imgPicker.delegate = self

            textField.parentViewController!.present(self.imgPicker, animated: true, completion: nil)
        }
        else if (type == "date"){

            self.removeAllViewsWith(id: 1000)
            toolBar.removeFromSuperview()
            picker.removeFromSuperview()
            date_picker.removeFromSuperview()
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            self.openDatePicker(textField: textField)

        }
        else if (type == "datetime")
        {

            self.removeAllViewsWith(id: 1000)
            toolBar.removeFromSuperview()
            picker.removeFromSuperview()
            date_picker.removeFromSuperview()
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            self.openDatePicker(textField: textField)
        }
        else
        {

//            toolBar.removeFromSuperview()
//            picker.removeFromSuperview()
//            date_picker.removeFromSuperview()


            self.endEditing(true)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);


        }
    }

}


extension TextField: UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let img = info[.originalImage] as? UIImage {

            print ("ImageInfo: \(img.size.height) \(img.size.width)")
            self.img = img
            
            var t = "Image Selected"
            if Utility.isArabicSelected()
            {
                t = "الصورة المحددة"
            }
            self.textField.text = "1 " + t
            self.imgPicker.dismiss(animated: true, completion: nil)
        }

    }

}

extension TextField: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        print(urls)
        
        print ("ImageInfo: \(urls)")
        self.docUrls = urls
        var t = "1 Document Selected"
                   if Utility.isArabicSelected()
                   {
                       t = ""
                   }
        self.textField.text = t
        self.imgPicker.dismiss(animated: true, completion: nil)
        
    }
    
}
