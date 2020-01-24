//
//  AccidentTypeVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 03/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

import MapKit
import CoreLocation

class AccidentTypeVC: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    var location:CLLocation!
    var selectedType = ""
    
    @IBOutlet weak var tableView: UITableView!
    var allTypes:[String] = ["Vehicle lane discipline","Failure to leave safe distance","Not giving way to to vehicles coming from left where required","Prohibited entry","Entering a road without ensuring that it is clear","Reversing without attention","Due to tyre burst"]
    
    
    var allTypes_Ar = ["الالتزام بمسار المركبة", "عدم ترك مسافة آمنة", "عدم إفساح المجال للمركبات القادمة من الجهة اليسرى", "الدخول الممنوع", "دخول الطريق دون التأكد من خلوه", "الرجوع إلى الخلف بصورة خطرة", "بسبب انفجار الإطارات"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "نوع الحادث"
            } else {
                self.navBar.title.text = "Accident Type"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }

        
        /*
        // Do any additional setup after loading the view.
        manager.session.configuration.timeoutIntervalForResource = 10
        manager.session.configuration.timeoutIntervalForRequest = 10
        if User().isLoggedin()
        {
            DispatchQueue.main.async {
                if Reachability.isConnectedToNetwork()
                {
                    if(Utility.checkSesion())
                    {
                        self.callAccidentTypesAPI()
                    }
                    else
                    {
                        Utility.getFreshToken {
                            (success, response) in
                            self.callAccidentTypesAPI()
                        }
                    }
                }
            }
        }*/
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "next")
        {
            var dest = segue.destination as? PersonalInfoVC
            dest?.location = self.location
            dest?.type = self.selectedType
            dest?.faulty = false
        }
    }

    
    func callAccidentTypesAPI()
    {
        /*let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForResource = 10
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        let webURL = "https://10.25.49.11/api/GetAccidentCause"
        
        print ("URL: \(webURL)")
        
        
        manager.request(webURL,
                        method: .get,
                        parameters: nil).validate().responseJSON { response in
                            switch response.result
                            {
                            case .success(let value):
                                let json = JSON(value)
                                print("JSON: \(json)")
                                
                                
                                for (key, value) in json["data"] {
                                    self.allTypes.append(value as! String)
                                }
                                
                            self.tableView.reloadData()
                            case .failure(let error):
                                print(error)
                                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                //SetDefaultWrappers().showAlert(info:"Unexpected Error while getting List. \(error.localizedDescription)", viewController: self)
                            }
        }*/
        
        APILayer().getDataFromAPI(name: "GetConsultationCategory", method:.get, path: "api/ConsultationController/GetListConsultationCategory", params: [:], headers: [:]) { (successGetConsultationCategory, GetConsultationCategory) in
            
            if (successGetConsultationCategory)
            {
                //let arr = APILayer().resolveData(input: GetConsultationCategory!, language: "EN")
                //let css = arr.joined(separator: ",")
                //self.saveLookupsData(key: "consultationCategoryLookups", value: css)
            }
            else
            {
                print("*Error")
            }
        }
        
    }
    
}



extension AccidentTypeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "basicCell") as! UITableViewCell
        if Utility.isArabicSelected()
        {
             cell.textLabel?.text  = self.allTypes_Ar[indexPath.row]
        }
        else
        {
             cell.textLabel?.text  = self.allTypes[indexPath.row]
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Utility.isArabicSelected()
       {
            self.selectedType  = self.allTypes_Ar[indexPath.row]
       }
        else
       {
            self.selectedType   = self.allTypes[indexPath.row]
       }
        
        self.performSegue(withIdentifier: "next", sender: nil)
    }
}

