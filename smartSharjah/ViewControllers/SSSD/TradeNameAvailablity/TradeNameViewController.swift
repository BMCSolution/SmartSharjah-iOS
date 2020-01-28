//
//  TradeNameViewController.swift
//  smartSharjah
//
//  Created by OzzY on 8/26/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TradeNameViewController: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var txtTradeName: UITextField!
    @IBOutlet weak var tradeDetailsListTableOutlet: UITableView!
    @IBOutlet weak var btnSearchTradeName: UIButton!
    
    fileprivate var tradeNum    : [String] = []
    fileprivate var tradeNameEn : [String] = []
    fileprivate var tradeNameAr : [String] = []
    
    let tradeNameList: [String] = []
    var isAlreadyBusy = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtTradeName.textAlignment = Utility.isArabicSelected() ? .right : .left
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "الإستفسار عن توافر اسم تجاري"
                self.navBar.title.font = UIFont(name: AppFontArabic.regular, size: self.navBar.title.font.pointSize - 4)
            } else {
                self.navBar.title.text = "Trade Name Availability Enquiry"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        self.tradeDetailsListTableOutlet.delegate = self
        self.tradeDetailsListTableOutlet.dataSource = self
        self.tradeDetailsListTableOutlet.tableFooterView = UIView()
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnTradeNamePress(_ sender: Any) {
        self.view.endEditing(true)
        if(!isAlreadyBusy)
        {
            if (self.txtTradeName.text == "") {
                var t = "Trade Name cannot be empty"
                if Utility.isArabicSelected()
                {
                    t = "الاسم التجاري لا يمكن أن يكون فارغًا"
                }
                SetDefaultWrappers().showAlert(info: t, viewController: self)
            } else {
                if Reachability.isConnectedToNetwork()
                {
                    if(Utility.checkSesion())
                    {
                        callTradeDetailsAPI(srchTrade: self.txtTradeName.text!)
                    }
                    else
                    {
                        isAlreadyBusy = true
                        Utility.getFreshToken {
                            (success, response) in
                            self.callTradeDetailsAPI(srchTrade: self.txtTradeName.text!)
                        }
                    }
                }
                else
                {
                    Utility.showInternetErrorAlert()
                }
                
                //SetDefaultWrappers().showAlert(info:"No trade name matches the name provided", viewController: self)
            }
        }
    }
    
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func fromJSON(string: String) throws -> [[String: Any]] {
        let data = string.data(using: .utf8)!
        guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else {
            throw NSError(domain: NSCocoaErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON"])
        }
        return jsonObject.map { $0 as! [String: Any] }
    }
    
    func callTradeDetailsAPI(srchTrade : String)
    {
        //self.clearADVAlues()
        //https://stg-smtshjapp.shj.ae/api/
         SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        
        var originalString = "https://stg-smtshjapp.shj.ae/api/GetTradeName/SearchTradeNames?tradeName="
        
        let escapedString = "\(originalString)\(srchTrade.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        
        print ("Original: \(originalString)")
        
        print ("Encoded: \(escapedString)")
        
//        let webURL = URL(string: escapedString)!
        
        
//        var webUrl = URL(string: "https://stg-smtshjapp.shj.ae/api/GetTradeName?tradeName=\(srchTrade)")
//        let webURL = URL(string: "https://stg-smtshjapp.shj.ae/api/GetTradeName?tradeName=\(srchTrade)")!
        
        
        let ulr =  URL(string: "https://stg-smtshjapp.shj.ae/api/TradeNameController/SearchTradeNames")!
        var request = URLRequest(url: ulr as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userDefaults = UserDefaults.standard
           
                  let accesstoken = userDefaults.object(forKey: "access_token") as! String
                  let authData = accesstoken
        request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
        let data = try! JSONSerialization.data(withJSONObject: ["tradeName":srchTrade], options: JSONSerialization.WritingOptions.prettyPrinted)

                   let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                   if let json = json {
                       print(json)
                   }
                   request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        
        Alamofire.request(request as! URLRequestConvertible)
        //Alamofire.request(escapedString, method: .post).validate()
            .responseJSON { response in
                self.isAlreadyBusy = false
                if (response.error != nil)
                {
                    print ("\(response.error)")
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
                            self.callTradeDetailsAPI(srchTrade: self.txtTradeName.text!)
                        }
                    }
                    else
                    {
                            if let json = response.result.value as? NSDictionary{
                                if let str = json.value(forKey: "data") as? String{
                                    do {
                                        if let dict = try self.fromJSON(string: str) as? [NSDictionary]
                                        {
                                            print("-----Dictionary: \(dict.count)")
                                            if dict.count > 0
                                            {
                                                if dict.count == 1 && dict.first! == [:]
                                                {
                                                    var m = "Trade Name not found"
                                                    if Utility.isArabicSelected()
                                                    {
                                                        m = "الاسم التجاري غير موجود"
                                                    }
                                                    SetDefaultWrappers().showAlert(info: m, viewController: self)
                                                }
                                                 else
                                                {
                                                    for item in dict
                                                    {
                                                        if let trNum = item.value(forKey: "tradeNumber") as? String
                                                        {
                                                            self.tradeNum.append(trNum)
                                                        }
                                                        if let trName = item.value(forKey: "tradeNameAr") as? String
                                                        {
                                                            self.tradeNameAr.append(trName)
                                                        }
                                                        
                                                        if let trNameE = item.value(forKey: "tradeNameEn") as? String
                                                        {
                                                            self.tradeNameEn.append(trNameE)
                                                        }
                                                    }
                                                    self.tradeDetailsListTableOutlet.reloadData()
                                                }
                                                
                                                
                                            }
                                            else
                                            {
                                                 SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                                var m = "Trade Name not found"
                                                if Utility.isArabicSelected()
                                                {
                                                    m = "الاسم التجاري غير موجود"
                                                }
                                                
                                                SetDefaultWrappers().showAlert(info: m, viewController: self)
                                                self.txtTradeName.text = ""
                                                //                        self.tradeDetailsListTableOutlet.reloadData()
                                            }
                                        }
                                        else
                                        {
                                            print("String to dictionary failed")
                                        }
                                    } catch {
                                        print("ERROR")
                                    }
                                    
                                    
                                }
                                else
                                {
                                    print("!!!!")
                                }
                                
                            }
                    }
                }
            /*switch response.result {
            case .success(let value):
                
                
                if let json = value as? NSDictionary{
                    
                    if let str = json.value(forKey: "data") as? String{
                        do {
                            if let dict = try self.fromJSON(string: str) as? [NSDictionary]
                            {
                                print("-----Dictionary: \(dict.count)")
                                if dict.count > 0
                                {
                                    if dict.count == 1 && dict.first! == [:]
                                    {

                                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                        var m = "Trade Name not found"
                                        if Utility.isArabicSelected()
                                        {
                                            m = "الاسم التجاري غير موجود"
                                        }
                                        
                                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                        SetDefaultWrappers().showAlert(info: m, viewController: self)
                                    }
                                     else
                                    {
                                        for item in dict
                                        {
                                            if let trNum = item.value(forKey: "tradeNumber") as? String
                                            {
                                                self.tradeNum.append(trNum)
                                            }
                                            if let trName = item.value(forKey: "tradeNameAr") as? String
                                            {
                                                self.tradeNameAr.append(trName)
                                            }
                                            
                                            if let trNameE = item.value(forKey: "tradeNameEn") as? String
                                            {
                                                self.tradeNameEn.append(trNameE)
                                            }
                                        }
                                        self.tradeDetailsListTableOutlet.reloadData()
                                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                    }
                                    
                                    
                                }
                                else
                                {
                                     SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                    var m = "Trade Name not found"
                                    if Utility.isArabicSelected()
                                    {
                                        m = "الاسم التجاري غير موجود"
                                    }
                                    
                                    SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                    SetDefaultWrappers().showAlert(info: m, viewController: self)
                                    self.txtTradeName.text = ""
                                    //                        self.tradeDetailsListTableOutlet.reloadData()
                                }
                            }
                            else
                            {
                                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                                print("String to dictionary failed")
                            }
                        } catch {
                            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                            print("ERROR")
                        }
                        
                        
                    }
                    else
                    {
                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        print("!!!!")
                    }
                    
                }
                
                

//                let json = JSON(value)
//                if let paymentListApiObj = json.array
//                {
//                    print("Trade names count:\(paymentListApiObj.count)")
//                    if(paymentListApiObj.count > 0)
//                    {
//
//                        for indexPayItem in 0...paymentListApiObj.count-1
//                        {
////                            self.tradeNum.append(paymentListApiObj[indexPayItem]["tradeNumber"].stringValue)
////                            self.tradeNameEn.append(paymentListApiObj[indexPayItem]["tradeNameEn"].stringValue)
////                            self.tradeNameAr.append(paymentListApiObj[indexPayItem]["tradeNameAr"].stringValue)
//                        }
//                    }
//                }
//                else
//                {
//                    SmartSharjahShareClass.hideActivityIndicator(view: self.view)
//                    SetDefaultWrappers().showAlert(info:"Trade Name details not found.", viewController: self)
//                    self.txtTradeName.text = ""
//                    //                        self.tradeDetailsListTableOutlet.reloadData()
//                }
            
            case .failure(let error):
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                
                 SetDefaultWrappers().showAlert(info:"\(error.localizedDescription)", viewController: self)
                print("Trade name Failue: \(error)")
                
            }*/
            
            
        }
    }
    }
}
extension TradeNameViewController: UITableViewDelegate{
    
}
extension TradeNameViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tradeNum.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailsTBCell", for: indexPath) as! AccountDetailsTBCell
        
        if (!Utility.isArabicSelected())
        {
            cell.amountHeading.text = "Trade Number:"
            cell.dateHeading.text = "Trade Name English:"
            cell.descriptionHeading.text = "Trade Name Arabic:"
        }
        else{
            cell.amountHeading.text = "رقم التجارة:"
            cell.dateHeading.text = "الاسم التجاري:"
            cell.descriptionHeading.text = "الاسم التجاري العربي:"
            
            cell.amountHeading.textAlignment = .right
            cell.dateHeading.textAlignment = .right
            cell.descriptionHeading.textAlignment = .right
            
        }
        
        

       cell.ADPaymentIDLblOutlet.text =  self.tradeNum[indexPath.row]
       cell.ADPaymentDateLabelOutlet.text = self.tradeNameEn[indexPath.row]
        cell.ADPAymentDescLabelOutlet.text = self.tradeNameAr[indexPath.row]
        
        cell.descriptionHeading.isHidden = false
        cell.ADPAymentDescLabelOutlet.isHidden = false
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

