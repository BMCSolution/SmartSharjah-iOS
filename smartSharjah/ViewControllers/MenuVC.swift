//
//  MenuVC.swift
//  smartSharjah
//
//  Created by Usman on 12/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var imagePath: String?
    
    let menuItems = ["Home","Dashboard", "Payments","Profile","History","Settings"]
    var menuItems_Ar = ["الرئيسية","لوحة البيانات","المدفوعات","الملف الشخصي","التاريخ","الإعدادات"]
    let menuIcons = ["NavHome","ic_tab_dash_new","ic_tab_payment_new","ic_tab_profile_new","NavHistory","ic_menu_settings"]
    
    
   var imgBaseURL = "http://sharjah24.ae"
    
    
    @objc func logout(){
        self.nameLbl.text = ""
        self.profilePic.image = nil
        
    }
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logout), name: NSNotification.Name(rawValue: "Logout"), object: nil)
        
        super.viewDidLoad()
        self.deleteBtn.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
//        self.profilePic.image = UIImage(named: "arabic_avatar")
        self.profilePic.layer.cornerRadius = self.profilePic.frame.width / 2.1
        self.menuTable.tableFooterView = UIView()
//        self.menuItems_Ar.reverse()
        // Do any additional setup after loading the view.
//        self.updateInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.updateInfo()
    }
    
    @IBAction func deleteImageBtnClicked(_ sender: Any) {
        if let val = self.imagePath {
            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
            APILayer().removeImageFromServer(name: "RemoveFile", method: .post, path: "FileManager/RemoveFile?fullpath=" + val, params: [:], headers: [:]) {
                (status, response) in
                SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
                if status {
                    SetDefaultWrappers().showAlert(info:"Successfully Removed Image", viewController: self)
                } else {
                    SetDefaultWrappers().showAlert(info:"Failed to Remove Image", viewController: self)
                }
            }
        }
    }
    

    @objc func updateInfo(){
        
        self.fillUserData()
//        if let name = UserDefaults.standard.value(forKey: "fullName") as? String{
//            self.nameLbl.text = name
//        }
//        else{
//            self.nameLbl.text = ""
//        }
//
//        if let imagePath = UserDefaults.standard.object(forKey: "user_image") as? String, imagePath != "" {
//            if let url = URL.init(string: imagePath) {
//                self.profilePic.kf.setImage(with: url)
//            }
//        }
        
    }
    func fillUserData()
    {
        if let name = User().getUserData(field: User().name_Key) as? String{
            self.nameLbl.text = name
        }
        else{
            self.nameLbl.text = ""
        }
        
        if let imgStr = User().getUserData(field: User().profilePicURL_key) as? String
        {
            if imgStr != ""
            {
                self.profilePic.isHidden = false
                print("Image url: \(imgStr)")
                let url = URL(string: imgStr)!
                self.profilePic.kf.setImage(with: url)
            }
            else{
                self.profilePic.image = UIImage(named: "defalut_user")
            }
            
        }else{
            self.profilePic.image = UIImage(named: "defalut_user")
        }
    }

}
extension MenuVC: UITableViewDelegate{
    
}

extension MenuVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableCell
        if cell.itemName.text! == "Settings" || cell.itemName.text! == "الإعدادات"
        {
            print("Settings Pressed...!")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SettingsPressed"), object: nil)
        }
        else if cell.itemName.text! == "History" || cell.itemName.text! == "التاريخ"
        {
            print("History Pressed...!")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HistoryPressed"), object: nil)
        }
        else
        {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "switchTab"), object: nil, userInfo: ["number": indexPath.row])
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateInfo), name: NSNotification.Name(rawValue: "profileUpdated"), object: nil)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SideMenuPressed"), object: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableCell
        
        
        if Utility.isArabicSelected()
        {
            cell.itemName.text = self.menuItems_Ar[indexPath.row]
        }
        else
        {
            cell.itemName.text = self.menuItems[indexPath.row]
        }
        
        cell.itemImage.image = UIImage(named: self.menuIcons[indexPath.row])
        return cell
    }
    
    
}
