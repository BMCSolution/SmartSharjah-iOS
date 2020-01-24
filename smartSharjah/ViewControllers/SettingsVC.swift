//
//  SettingsVC.swift
//  smartSharjah
//
//  Created by Usman on 01/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var tcView: UIView!
    
    @IBOutlet weak var privacyPolicy_Btn: UIButton!
    @IBOutlet weak var terms_Btn: UIButton!
    
    @IBOutlet weak var navBar: NavBar!
  
    @IBOutlet weak var version_Lbl: UILabel!
    @IBOutlet weak var privacyPolicy_Lbl: UILabel!
    @IBOutlet weak var tc_Lbl: UILabel!
    
    var localizationData : [NSDictionary] = []
    
    
    var selectedType: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            if Utility.isArabicSelected()
            {
                navBar.title.text = "الإعدادات"
                self.version_Lbl.text = "الإصدار:\(appVersion)"
            }
            else
            {
                self.version_Lbl.text = "Version:\(appVersion)"
                navBar.title.text = "Settings"
            }
           
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        self.loadLocalization();
        
        let radius: CGFloat = 10.0
        
        self.privacyPolicyView.layer.cornerRadius = radius
        self.tcView.layer.cornerRadius = radius
        // Do any additional setup after loading the view.
    }
    
    func loadLocalization()
    {

         SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        APILayer().getLocalizationNew(name: "ListLocalization", method: .get, path: "api/LocalizationController/ListLocalizationByScreenName", params: ["ScreenName":"Settings"], headers: [:]) { (success, response) in
            
            if (success)
            {
                self.localizationData = (response as? [NSDictionary])!
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                print("success: \(success)")
                if response!.count > 0
                {
                    self.loadingLocalizationData();
                }
            }
            else
            {
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if(response != nil)
                {
                    print("Response: \(response)")
                    SetDefaultWrappers().showAlert(info:"Request Failed!", viewController: self)
                }
            }
        }
    }
    func loadingLocalizationData()
    {
          //PrivacyPolicy
          //TermsAndConditions
          //SettingsTitle
          //VersionTitle
        
        if(self.getItemFromKey(labelName: "SettingsTitle") != -1)
        {
            self.navBar.title.text = self.localizationData[self.getItemFromKey(labelName: "SettingsTitle")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as! String
        }
        if(self.getItemFromKey(labelName: "VersionTitle") != -1)
        {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            self.version_Lbl.text = "\(self.localizationData[self.getItemFromKey(labelName: "VersionTitle")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as! String):\(appVersion)"
        }
        
        if(self.getItemFromKey(labelName: "PrivacyPolicy") != -1)
        {
            self.privacyPolicy_Lbl.text = self.localizationData[self.getItemFromKey(labelName: "PrivacyPolicy")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as! String
        }
        if(self.getItemFromKey(labelName: "TermsAndConditions") != -1)
        {
            self.tc_Lbl.text = self.localizationData[self.getItemFromKey(labelName: "TermsAndConditions")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as! String
        }
    }
    func getItemFromKey(labelName: String ) -> Int
    {
        var iterator = 0;
        for obj in self.localizationData {
            if(obj["localizationKey"] as? String == labelName)
            {
                return iterator;
            }
            iterator += 1
        }
        return -1;
    }
    

    @IBAction func privacyBtnPressed(_ sender: UIButton) {
        self.selectedType = "Privacy Policy"
        self.performSegue(withIdentifier: "OpenDetails", sender: self)
    }
    
    
    @IBAction func termsBtnPressed(_ sender: UIButton) {
        self.selectedType = "Terms & Conditions"
        self.performSegue(withIdentifier: "OpenDetails", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenDetails"
        {
            let dest = segue.destination as! PrivacyDetailsVC
            dest.navTitle = self.selectedType
            if self.selectedType == "Privacy Policy"
            {
                dest.navTitle_Localization = self.privacyPolicy_Lbl.text!
            }
            else
            {
                dest.navTitle_Localization = self.tc_Lbl.text!
            }
            
        }
    }

}
