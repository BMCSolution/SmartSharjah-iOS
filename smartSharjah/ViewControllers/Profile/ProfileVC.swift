//
//  ProfileVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 04/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {
    
    @IBOutlet weak var editLine: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    var name = "Abdullah"
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var updateProfilePicBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    var imgBaseURL = "http://sharjah24.ae"
    
    var selectedImage : UIImage!
    var imagePath: String?
    
    var userDictionary: NSDictionary = [:]
    
    let imagePicker = UIImagePickerController()
    var selectedIndes: Int!
    var editable = false
    var user_id = "1"
    var username = ""
    var searchMode: Bool!
    var titleArr:[String] = ["User Name","Full Name", "Emirates ID","License Number", "Email", "Address","Mobile Number"]
    
//    var titles_Ar:[String] = ["الهاتف المتحرك","الهاتف المتحرك"
//        ,"العنوان"
//        ,"البريد الإلكتروني"
//        ,"الهاتف المتحرك"
//        ,"الهوية الإماراتية"
//        ,"الاسم الكامل"]
//   //اسم المستخدم
    var titles_Ar:[String] = ["لعنوان","الهاتف المتحرك"
           ,"لبريد الإلكتروني"
           ,"رقم الرخصة"
           ,"لهوية الإماراتية"
           ,"الاسم الكامل"
           ,"اسم المستخدم"]
    
    var imageStr = ""
    var valueArr:[String] = ["", "", "", "", "","",""]
    var x:String?
    var imageUrl = ""
    
    @IBAction func editPressed(_ sender: UIButton) {
        
        self.editable = true
        //        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        self.editLine.isHidden = false
        self.tableView.reloadData()
        //            self.saveBtn.isHidden = false
        
    }
    
    func validateFields() -> Bool
    {
        
        if self.valueArr[0] == ""
        {
            SetDefaultWrappers().showAlert(info:"User name cannot be empty".localized(), viewController: self)
            return false
        }
        
        if self.valueArr[1] == ""
        {
            SetDefaultWrappers().showAlert(info:"Full name cannot be empty".localized(), viewController: self)
            return false
        }
        else if self.valueArr[2] == ""
        {
            SetDefaultWrappers().showAlert(info:"Emirates ID cannot be empty".localized(), viewController: self)
            return false
        }
            else if self.valueArr[3] == ""
            {
                SetDefaultWrappers().showAlert(info:"License No cannot be empty".localized(), viewController: self)
                return false
            }
        else if self.valueArr[4] == ""
        {
            SetDefaultWrappers().showAlert(info:"Email cannot be empty".localized(), viewController: self)
            return false
        }
        else if self.valueArr[5] == ""
        {
            SetDefaultWrappers().showAlert(info:"Address cannot be empty".localized(), viewController: self)
            return false
        }
        else if self.valueArr[6] == ""
        {
            SetDefaultWrappers().showAlert(info:"Mobile Number cannot be empty".localized(), viewController: self)
            return false
        }
        else if !phoneNumberValidation(text: self.valueArr[6])
        {
            var n = "Invalid Phone number (e.g: 971XXXXXXXXX)" //"Invalid Phone Number in"
           if Utility.isArabicSelected()
           {
               n = "رقم الهاتف غير صالح (على سبيل المثال: 971xxxxxxxxx)"//"رقم هاتف غير صالح في"
           }
            SetDefaultWrappers().showAlert(info: n, viewController: self)
               return false
           
        }
        
        return true
    }
    
    @IBAction func saveProfilePressed(_ sender: UIButton) {
        
        
        if let val = self.imagePath {
            imageUrl = val
        }
        print("User Arr: \(self.valueArr)")
        
//Utility.checkSesion()
        if validateFields()
        {
            if Reachability.isConnectedToNetwork()
            {
                if(Utility.checkSesion())
                {
                    updateProfile()
                }
                else
                {
                    Utility.getFreshToken {
                        (success, response) in
                        self.updateProfile()
                    }
                }
            }
            else
            {
                Utility.showInternetErrorAlert()
            }
        }
        else
        {
            print("Validation Failed: \(self.valueArr)")
        }
        
        
    }
    
    func updateProfile()
    {
        let headers = [
                        "Content-Type": "application/json"
                    ]
                        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
                                    APILayer().postDataToAPINewInsertUser(name: "UpdateUserProfile", method: .post, path: "api/WebApi/UpdateUserProfile", params: ["userName":self.valueArr[0], "passWord": ""
                                    ,"fullName": self.valueArr[1]
                                    ,"emirateID": self.valueArr[2]
                                    ,"licenseNo": self.valueArr[3]
                                    ,"emailAddr": self.valueArr[4]
                                    ,"addressHome":self.valueArr[5]
                                        ,"pictureUrl": self.imageUrl
                                    ,"phoneNo": self.valueArr[6]
                                    ,"deviceDetails": Utility.getDeviceDetail(),
                                    "deviceUDID": Utility.getUdid(),
                                    "deviceTYPE": "IOS",
                                    "mobileDatetime": Utility.getMobileDateTime(),
                                    "serviceTYPE": "updateuserprofile"], headers: headers) { (success, response) in
                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        if (success){
                            //var m = "Profile successfully updated!"
                            //if Utility.isArabicSelected()
                            //{
                                //m = "تم تعديل الملف الشخصي بنجاح"
                            //}
                            //SetDefaultWrappers().showAlert(info:m.localized(), viewController: self)
                           
                          
                            let userDefaults = UserDefaults.standard
                              userDefaults.set(self.valueArr[0], forKey: "userName")
                             userDefaults.set(self.valueArr[1], forKey: "fullName")
                           
                              userDefaults.set(self.valueArr[2], forKey: "emirateID")
                              userDefaults.set(self.valueArr[3], forKey: "licenseNo")
                             userDefaults.set(self.valueArr[4], forKey: "emailAddr")
                              userDefaults.set(self.valueArr[5], forKey: "addressHome")
                            userDefaults.set(self.imageUrl, forKey: "pictureUrl")
                            userDefaults.set(self.valueArr[6], forKey: "phoneNo")
                               // userDefaults.synchronize()
                             self.profileUpdated();
                            SetDefaultWrappers().showAlert(info:"Profile successfully updated!".localized(), viewController: self)
                            //self.getProfileInfo(updatePic: true)
                        }
                        else
                        {
                            if let user = response as? NSDictionary{
                                if let code = user.object(forKey: "StatusCode") as? Int
                                {
                                    if(code == 401)
                                    {
                                        Utility.getFreshToken {
                                            (success, response) in
                                            self.updateProfile()
                                        }
                                    }
                                    else{
                                        SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                                    }
                                }else{
                                    SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                                }
                            }else{
                                SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                            }
                                //self.tableView.reloadData()
                        }
                    }
                    self.editable = false
                    //        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
                    self.editLine.isHidden = true
                    //        self.saveBtn.isHidden = true
                    self.tableView.reloadData()
                    
        //            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        //            APILayer().postDataToAPI(name: "UpdateUser", method: .post, path: "updateUserInfo/Post?userName=\(username)",
        //            params: ["fullName":self.valueArr[0],
        //                     "username":username,
        //                     "emiratesID":self.valueArr[1],
        //                     "licenseNo": "",
        //                     "emailAddr": self.valueArr[2],
        //                     "AddrHome": self.valueArr[3],
        //                     "phoneNo": self.valueArr[4] ,
        //                     "userActStatus": 1] as! [String: Any], headers: [:]) { (success, response) in
        //
        //                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
        //                if (success){
        //                    var m = "Profile successfully updated!"
        //                    if Utility.isArabicSelected()
        //                    {
        //                        m = "تم تعديل الملف الشخصي بنجاح"
        //                    }
        //                    SetDefaultWrappers().showAlert(info: m, viewController: self)
        //                    self.getProfileInfo(updatePic: true)
        //                }
        //                else
        //                {
        //                    SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
        //                    //                self.tableView.reloadData()
        //                }
        //            }
        //            self.editable = false
        //            //        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        //            self.editLine.isHidden = true
        //            //        self.saveBtn.isHidden = true
        //            self.tableView.reloadData()
    }
    
    
    
    
    func uploadProfileImage(image: Data) {
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        
//        let imageToUpload = UIImage.init(data: image)!
//
//        let _usern = UserDefaults.standard.value(forKey: "username") as? String
//
//        let _params : NSMutableDictionary = ["userName":_usern ,"profileimage":imageToUpload.toBase64()!]
        
        let imageToUpload = UIImage.init(data: image)!
        let compressimage = imageToUpload.jpegData(compressionQuality: 0.5)
        let compressedImage = UIImage(data: compressimage!)
        
        APILayer().uploadProfileImageNew(endUrl: "api/Registration/UploadUserImage", imageData: compressimage, parameters: [:]){
            (status, result) in
        //APILayer().uploadProfileImageNew(name: "UploadImage", method: .post, path: "api/Registration/UploadUserImage" , params:_params as! [String : Any], headers: [:]) { (status, result) in
            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
            
            if status {
                
                
                self.x = result! //"https://stg-smtshjapp.shj.ae/" + result!
                               print("Img URL: \(self.x)")
                
              
                
            
                SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
                            APILayer().postDataToAPINewInsertUser(name: "UpdateUserProfile", method: .post, path: "api/WebApi/UpdateUserProfile", params: ["userName":self.valueArr[0],
                                                                                                                                                           "pictureUrl": self.x
                            ,"deviceDetails": Utility.getDeviceDetail(),
                            "deviceUDID": Utility.getUdid(),
                            "deviceTYPE": "IOS",
                            "mobileDatetime": Utility.getMobileDateTime(),
                            "serviceTYPE": "updateuserimage"], headers: [:]) { (success, response) in
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if (success){
                    
                    User().saveProfilePicInPrefs(url: self.x!)
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(self.x, forKey: "pictureUrl")
                                userDefaults.synchronize()
                              
                                self.imagePath = self.x
                    self.imageStr = self.x!
                                               self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                                
                    SetDefaultWrappers().showAlert(info:"Successfully Updated Profile Image".localized(), viewController: self)
                    //self.getProfileInfo(updatePic: true)
                }
                else
                {
                    
                    if let user = response as? NSDictionary{
                        if let code = user.object(forKey: "StatusCode") as? Int
                        {
                            if(code == 401)
                            {
                                
                                APILayer().postDataToAPINew(name: "UserLogin", method: .post, path: "AuthenticationTokenService", params: [
                                               "grant_type":"password",
                                               "username":User().getUser(field: User().username_key) as? String,
                                              
                                               "ServiceTYPE": "refreshtoken",
                                               "DeviceDetails": Utility.getDeviceDetail(),
                                               "DeviceUDID": Utility.getUdid(),
                                               "DeviceTYPE": "IOS",
                                               "MobileDateTime": Utility.getMobileDateTime()], headers: [:]) { (success, response) in
                                                          SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                                          print ("Success: \(success)")

                                               if (success)
                                               {
                                             
                                         SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
                                                                    APILayer().postDataToAPINewInsertUser(name: "UpdateUserProfile", method: .post, path: "api/WebApi/UpdateUserProfile", params: ["userName":self.valueArr[0],
                                                                                                                                                                                                   "pictureUrl": self.x
                                                                    ,"deviceDetails": Utility.getDeviceDetail(),
                                                                    "deviceUDID": Utility.getUdid(),
                                                                    "deviceTYPE": "IOS",
                                                                    "mobileDatetime": Utility.getMobileDateTime(),
                                                                    "serviceTYPE": "updateuserimage"], headers: [:]) { (success, response) in
                                                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)


                                        if (success){
                                                            
                                            User().saveProfilePicInPrefs(url: self.x!)
                                                                        
                                                                        let userDefaults = UserDefaults.standard
                                                                        userDefaults.set(self.x, forKey: "pictureUrl")
                                                                        userDefaults.synchronize()
                                                                      
                                                                        self.imagePath = self.x
                                            self.imageStr = self.x!
                                                                                       self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                                                                        
                                                            SetDefaultWrappers().showAlert(info:"Successfully Updated Profile Image".localized(), viewController: self)
                                                            //self.getProfileInfo(updatePic: true)
                                                        }
                                        else{
                                        SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                                        }

                                        }
                                               }
                                               else
                                               {
                                                   SetDefaultWrappers().showAlert(info:"Unable to Authorized".localized(), viewController: self)
                                               }
                                                
                                }
                            }else{
                                SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                            }
                        }else{
                            SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                        }
                    }else{
                    SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
                    }
                                //self.tableView.reloadData()
                }
                }
            } else {
                SetDefaultWrappers().showAlert(info:"Update failed!".localized(), viewController: self)
            }
        }
    }
    
    @IBAction func deleteImageBtnClicked(_ sender: Any) {
        if let val = self.imagePath {
            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
            APILayer().removeImageFromServer(name: "RemoveFile", method: .post, path: "FileManager/RemoveFile?fullpath=" + val, params: [:], headers: [:]) {
                (status, response) in
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if status {
                    SetDefaultWrappers().showAlert(info:"Successfully Removed Image", viewController: self)
                } else {
                    SetDefaultWrappers().showAlert(info:"Failed to Remove Image", viewController: self)
                }
            }
        }
    }
    
    
    func fillData()
    {
          
            if let val = User().getUserData(field: User().username_key) as? String {
                                      self.valueArr[0] = val
                                  }
            if let val = User().getUserData(field: User().name_Key) as? String {
                self.valueArr[1] = val
            }
            
                   
            if let val = User().getUserData(field: User().emirateID_Key) as? String {
                self.valueArr[2] = val
            }
            
            if let val = User().getUserData(field: User().licenseNo_key) as? String {
                self.valueArr[3] = val
            }
            
            if let val = User().getUserData(field: User().email_Key) as? String {
                self.valueArr[4] = val
            }
            
            if let val = User().getUserData(field: User().address_Key) as? String  {
                self.valueArr[5] = val
            }
            
            if let val = User().getUserData(field: User().mobileNumber_key) as? String {
                self.valueArr[6] = val
               
                
            }
           // if let val = self.userDictionary.object(forKey: "pictureUrl") as? String {
             
            if let val = User().getUserData(field: User().profilePicURL_key) as? String {
                        
                self.imageStr = val
            }
            
           // self.imageStr = User().getUser(field: User().profilePicURL_key) as! String
            
            self.tableView.reloadData()
        //}
        
    }
    
    func getProfileInfo(updatePic: Bool){
        
        
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        
        //         https://stg-smtshjapp.shj.ae/api/DataAccess/GetUserProfileDetails?userName='farasat@gmail.com'
        APILayer().getDataFromAPINew(name: "GetUserInfo", method: .get, path: "/DataAccess/GetUserProfileDetails?userName='\(username)'", params: [:], headers: [:]) { (success, response) in
            
            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
            
            if (success)
            {
                if let resp = response
                {
                    if resp.count > 0
                    {
                        if let user = resp.first{
                            
                            User().setUserJson(d: user, replaceProfilePic: updatePic)
                            
                        }
                    }
                    
                }
            }
            else
            {
                
            }
        }
    }
    
    @objc func profileUpdated()
    {
        self.fillData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //self.getProfileInfo(updatePic: false)
          self.fillData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titles_Ar.reverse()
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchPressed), name: NSNotification.Name(rawValue: "searchPressed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.profileUpdated), name: NSNotification.Name(rawValue: "profileUpdated"), object: nil)
        
        
        imagePicker.delegate = self
        if let usern = UserDefaults.standard.value(forKey: "username") as? String{
            self.username = usern
        }
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected()
            {
                navBar.title.text = "الملف الشخصي"
                
            }
            else
            {
                navBar.title.text = "Profile"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: true)
        }
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        //        self.profilePic.image = UIImage(named: "defalut_user")
        //        self.profilePic?.layer.cornerRadius = 90
        //        self.nameTV.text = name
        //        self.nameTV.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateProfilePicPressed(_ sender: UIButton) {
        
        //        self.showAlertToOpenPhotos()
    }
    
    @objc func searchPressed()
    {
        //        print("searchPressed...")
        self.searchMode = true
        self.performSegue(withIdentifier: "allServices", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "legal")
        {
            let dest = segue.destination as! LegalVC
            dest.titleString = self.valueArr[selectedIndes]
        }
        else if segue.identifier == "allServices"
        {
            let destNav = segue.destination as! UINavigationController
            let dest = destNav.viewControllers[0] as! ServicesListVC
            dest.searchMode = self.searchMode
        }
        
    }
    
}


extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    @objc func editProfileImagePressed(sender: UIButton)
    {
        if self.editable
        {
            self.showAlertToOpenPhotos()
        }
        
        
    }
    
    @objc func saveProfile(sender: UIButton)
    {
        self.saveProfilePressed(sender)
    }
    
    @objc func removeProfileImagePressed(sender: UIButton)
    {
        self.deleteImageBtnClicked(sender)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2
        {
            return 1
        }
        else
        {
            return self.titleArr.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "profileTopCell") as! ProfileTopCell
            
            if self.imageStr != ""
            {
                //                cell.removeBtn.isHidden = false
                let url = URL(string: self.imageStr)!
                cell.userImage.kf.setImage(with: url)
            }
            else
            {
                cell.removeBtn.isHidden = true
            }
            
            cell.removeBtn.isHidden = true
            cell.editProfileBtn.tag = indexPath.row
            cell.editProfileBtn.addTarget(self, action: #selector(editProfileImagePressed(sender:)), for: .touchUpInside)
            cell.removeBtn.tag = indexPath.row
            cell.removeBtn.addTarget(self, action: #selector(removeProfileImagePressed(sender:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileCell
            
            cell.textField.textField.tag = indexPath.row
            cell.textField.textField.text = ""
            cell.textField.textField.isEnabled = true
            self.editLine.isHidden = !self.editable
            cell.textField.textField.textAlignment = Utility.isArabicSelected() ? .right : .left
            
            cell.textField.textField.delegate = self
            if Utility.isArabicSelected()
            {
                cell.textField.hint = self.titles_Ar[indexPath.row]
                
                //if self.titles_Ar[indexPath.row] == "اسم المستخدم"
                if indexPath.row == 0
                {
                    cell.textField.textField.keyboardType = .default
                    
                    if let val = User().getUserData(field: User().username_key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr.insert(val, at: 0)
                    }
                }
                
                //else if self.titles_Ar[indexPath.row] == "الاسم الكامل"
                else if indexPath.row == 1
                {
                    
                    cell.textField.textField.keyboardType = .default
                    if let val = User().getUserData(field: User().name_Key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr.insert(val, at: 0)
                    }
                }
                //else if self.titles_Ar[indexPath.row] == "الهوية الإماراتية"
                else if indexPath.row == 2
                {
                    cell.textField.textField.keyboardType = .default
                    if let val = User().getUserData(field: User().emirateID_Key) as? String {
                        cell.textField.textField.text = val
                    }
                }
                    //else if self.titleArr[indexPath.row] == "رقم الرخصة"
                    else if indexPath.row == 3
                    {
                        cell.textField.textField.keyboardType = .default
                        if let val = User().getUserData(field: User().licenseNo_key) as? String {
                            cell.textField.textField.text = val
                        }
                    }
                //else if self.titles_Ar[indexPath.row] == "البريد الإلكتروني"
                else if indexPath.row == 4
                {
                    cell.textField.textField.isEnabled = false
                    cell.textField.textField.keyboardType = .emailAddress
                    if let val = User().getUserData(field: User().email_Key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr[2] = val
                    }
                }
                //else if self.titles_Ar[indexPath.row] == "العنوان"
                else if indexPath.row == 5
                {
                    cell.textField.textField.keyboardType = .default
                    if let val = User().getUserData(field: User().address_Key) as? String {
                        cell.textField.textField.text = val
                        //                         self.valueArr[3] = val
                    }
                    
                }
                //else if self.titles_Ar[indexPath.row] == "الهاتف المتحرك"
                else if indexPath.row == 6
                {
                    cell.textField.textField.keyboardType = .numberPad
                    if let val = User().getUserData(field: User().mobileNumber_key) as? String {
                        cell.textField.textField.text = val
                        //                         self.valueArr[4] = val
                    }
                    
                }
            }
            else
            {
                //"User Name","Full Name", "Emirates ID","License No", "Email", "Address","Mobile Number"
                cell.textField.hint = self.titleArr[indexPath.row]
                //if self.titleArr[indexPath.row] == "User Name"
                if indexPath.row == 0
                {
                    cell.textField.textField.keyboardType = .default
                    if let val = User().getUserData(field: User().username_key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr[0] = val
                    }
                }
                //else if self.titleArr[indexPath.row] == "Full Name"
                else if indexPath.row == 1
                                   {
                                       cell.textField.textField.keyboardType = .default
                                       if let val = User().getUserData(field: User().name_Key) as? String {
                                           cell.textField.textField.text = val
                                           //                        self.valueArr[0] = val
                                       }
                                   }
                //else if self.titleArr[indexPath.row] == "Emirates ID"
                else if indexPath.row == 2
                {
                    cell.textField.textField.keyboardType = .numberPad
                    if let val = User().getUserData(field: User().emirateID_Key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr[1] = val
                    }
                }
                //else if self.titleArr[indexPath.row] == "License Number"
                else if indexPath.row == 3
                {
                    cell.textField.textField.keyboardType = .default
                    if let val = User().getUserData(field: User().licenseNo_key) as? String {
                        cell.textField.textField.text = val
                    }
                }
                //else if self.titleArr[indexPath.row] == "Email"
                else if indexPath.row == 4
                {
                    cell.textField.textField.isEnabled = false
                    cell.textField.textField.keyboardType = .emailAddress
                    if let val = User().getUserData(field: User().email_Key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr[2] = val
                    }
                }
                //else if self.titleArr[indexPath.row] == "Address"
                else if indexPath.row == 5
                {
                    cell.textField.textField.keyboardType = .default
                    if let val = User().getUserData(field: User().address_Key) as? String {
                        cell.textField.textField.text = val
                        //                        self.valueArr[3] = val
                        
                    }
                    
                }
                //else if self.titleArr[indexPath.row] == "Mobile Number"
                else if indexPath.row == 6
                {
                    cell.textField.textField.keyboardType = .numberPad
                    if let val = User().getUserData(field: User().mobileNumber_key) as? String {
                        print("Mobile Number: \(val)")
                        cell.textField.textField.text = val
                        //                        self.valueArr[4] = val
                    }
                    
                }
            }
            
            //        cell.textField.textField.text = self.valueArr[indexPath.row]
            
            
            if (editable)
            {
                if (indexPath.row <= 6)
                {
                    cell.textField.textField.isEnabled = true
                }
                else
                {
                    cell.textField.textField.isEnabled = false
                }
                if(indexPath.row == 0)
                {
                    cell.textField.textField.isEnabled = false
                }
            }
            else{
                cell.textField.textField.isEnabled = false
            }
            
            cell.selectionStyle = .none
            return cell
            
        }
        else
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "SaveProfileCell") as! SaveProfileCell
            cell.saveBtn.addTarget(self, action: #selector(saveProfile(sender:)), for: .touchUpInside)
            cell.saveBtn.tag = indexPath.row
            if self.editable
            {
                cell.saveBtn.isHidden = false
            }
            else
            {
                cell.saveBtn.isHidden = true
            }
            
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 220
        }
        else if indexPath.section == 1
        {
            return 70
        }
        else
        {
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0
        {
            
        }
        else if indexPath.section  == 1
        {
            if (indexPath.row == 2)
            {
                
            }
            
            if (indexPath.row > 4)
            {
                self.selectedIndes = indexPath.row
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.performSegue(withIdentifier: "legal", sender: self)
            }
        }
        else
        {
            
        }
        
        
        
    }
}

extension ProfileVC: UITextFieldDelegate{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        /*if textField.tag == 2
       {
           self.view.endEditing(true)
           return false
       }*/
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 1 // EmiratesID
        {
            let maxLength = 18
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            self.valueArr[textField.tag] = textField.text! + string
            return newString.length <= maxLength
        }
        
        self.valueArr[textField.tag] = textField.text! + string
        return true
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            
            
            let imageData = image.fixOrientation()!.jpegData(compressionQuality: 0.5) //{
            //                if let compressedImage = UIImage.init(data: imageData) {
            
            
            
            self.uploadProfileImage(image: imageData!)
            self.selectedImage = image
            //                }
            //                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            
            //}
            
            self.imagePicker.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    
}

extension ProfileVC{
    
    func showAlertToOpenPhotos() {
        
        let alert = UIAlertController(title: "Choose a Type", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}


extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}


extension ProfileVC{
    
    func phoneNumberValidation(text: String) -> Bool {
        do {

            if (!text.starts(with: "971") || !(text.count == 12))
            {
                return false
            }

            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))

            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == text.count
            } else {
                return false
            }
        } catch {
            return false
        }

    }
}
