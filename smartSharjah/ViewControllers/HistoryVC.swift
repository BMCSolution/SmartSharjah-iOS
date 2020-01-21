//
//  HistoryVC.swift
//  smartSharjah
//
//  Created by Bmc Solution on 1/20/20.
//  Copyright © 2020 DEG. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HistoryVC: UIViewController {

    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var tableView: UITableView!
    
    var historyDataDict: [NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected()
            {
                navBar.title.text = "التاريخ"
            }
            else
            {
                navBar.title.text = "History"
            }
           
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if Reachability.isConnectedToNetwork()
        {
            if(Utility.checkSesion())
            {
                self.getDetails()
            }
            else
            {
                Utility.getFreshToken {
                    (success, response) in
                    self.getDetails()
                }
            }
        }
    }
    

    func getDetails()
    {
        var params:[String: Any] = [
            "userName":(User().getUserData(field: User().username_key) as! String),
            "phoneNo":(User().getUserData(field: User().mobileNumber_key) as! String)
        ]
        var path = "https://stg-smtshjapp.shj.ae/api/UserHistory/UserHistory"
        
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        let ulr =  URL(string: path)!
        var request = URLRequest(url: ulr as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userDefaults = UserDefaults.standard
        let accesstoken = userDefaults.object(forKey: "access_token") as! String
        let authData = accesstoken
        request.setValue(authData as! String, forHTTPHeaderField: "Authorization")
        let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
                print(json)
        }
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                   
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
                            self.getDetails()
                        }
                    }
                    else
                    {
                            if let value = response.result.value as? [NSDictionary]{
                                self.historyDataDict = value
                                self.tableView.reloadData()
                                //print("Response: \(value)")
                                //if let details = value.value(forKey: "data") as? String
                                //{
                                    //self.details_TxtView.text = details
                                //}
                            }
                    }
                }
            }
            
        }
       
        
    }
    

}


extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        
        cell.bg.layer.cornerRadius = 10
        cell.serviceLabel.text = self.historyDataDict[indexPath.row].value(forKey: "serviceName") as? String
        cell.datetimeLabel.text = self.historyDataDict[indexPath.row].value(forKey: "createdOn") as? String
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }
    
}
