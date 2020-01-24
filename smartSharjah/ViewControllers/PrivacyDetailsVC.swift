//
//  PrivacyDetailsVC.swift
//  smartSharjah
//
//  Created by Usman on 01/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire
class PrivacyDetailsVC: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var details_TxtView: UITextView!
    
    
    var navTitle_Localization = ""
    var navTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.details_TxtView.textAlignment =  Utility.isArabicSelected() ? .right : .left
        
        if (self.navBar != nil)
        {
            /*if Utility.isArabicSelected()
            {
                if self.navTitle == "Privacy Policy"
                {
                    self.navTitle_Ar = "سياسة خاصة"
                }
                else
                {
                    self.navTitle_Ar = "البنود و الظروف"
                }
                navBar.title.text = navTitle_Ar
            }
            else{
                navBar.title.text = navTitle
            }*/
            navBar.title.text = navTitle_Localization
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        if Reachability.isConnectedToNetwork()
        {
            if(Utility.checkSesion())
            {
                self.getDetails(title: self.navTitle)
            }
            else
            {
                Utility.getFreshToken {
                    (success, response) in
                    self.getDetails(title: self.navTitle)
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func getDetails(title: String)
    {
        var path = ""
        if title == "Privacy Policy"
        {
            path = "https://stg-smtshjapp.shj.ae/api/useragreements/privacyandpolicy"
        }
        else
        {
            path = "https://stg-smtshjapp.shj.ae/api/useragreements/termsandconditions"
        }
        
        if path != ""
        {
            
            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
            let ulr =  URL(string: path)!
            var request = URLRequest(url: ulr as URL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let userDefaults = UserDefaults.standard
            let accesstoken = userDefaults.object(forKey: "access_token") as! String
            let authData = accesstoken
            request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
                       
            
            Alamofire.request(request as! URLRequestConvertible)
            //Alamofire.request(URL(string: path)!, method: .get, parameters: [:], headers: [:])
                .responseJSON { (response) in
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    
                }
                else
                {
                    if let code = response.response?.statusCode as? Int{
                        if code == 401
                        {
                            Utility.getFreshToken {
                                (success, response) in
                                self.getDetails(title: self.navTitle)
                            }
                        }
                        else
                        {
                                if let value = response.result.value as? NSDictionary{
                                    print("Response: \(value)")
                                    if let details = value.value(forKey: "data") as? String
                                    {
                                        self.details_TxtView.text = details
                                    }
                                }
                        }
                    }
                }
                
            }
            
        }
       
        
    }
    
    func getTermsCond()
    {
    
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
