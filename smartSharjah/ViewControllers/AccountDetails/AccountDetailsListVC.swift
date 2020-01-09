//
//  AccountDetailsListVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AccountDetailsListVC: UIViewController {
    
    @IBOutlet weak var AccountListPlaceholderViewOutlet: UIView!
    @IBOutlet weak var AccountDetailsSearchFieldOutlet: UITextField!
    @IBOutlet weak var AccountDetailsSearchBtnOutlet: UIButton!
    @IBOutlet weak var AccountDetailsListTableOutlet: UITableView!
    
    @IBOutlet weak var navBar: NavBar!
    
    /*
     @IBOutlet weak var ADPaymentIDLblOutlet: UILabel!
     
     @IBOutlet weak var ADPaymentDateLabelOutlet: UILabel!
     
     @IBOutlet weak var ADPaymentAmountLabelOutlet: UILabel!
     
     @IBOutlet weak var ADPAymentDescLabelOutlet: UILabel!
     */

    fileprivate var ADPaymentIDArr      :   [String]    = []
    fileprivate var ADPaymentDateArr    :   [String]    = []
    fileprivate var ADPaymentAmountArr  :   [String]    = []
    fileprivate var ADPAymentDesc       :   [String]    = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.AccountDetailsSearchFieldOutlet.text = ""
        Utility.setView()
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountDetailsSearchFieldOutlet.textAlignment = Utility.isArabicSelected() ? .right : .left
        if (self.navBar != nil)
        {
            if (self.navBar != nil)
            {
               if Utility.isArabicSelected() {
                    self.navBar.title.text = "سجل المدفوعات"
                let size = self.navBar.title.font.pointSize - 7
                self.navBar.title.font = UIFont(name: AppFontArabic.bold, size: size)
                } else {
                    self.navBar.title.text = "SEWA Payment History"
                }
                
                
                self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
         self.AccountDetailsSearchFieldOutlet.text = ""
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
   
    
    
    
    func clearADVAlues()
    {
        self.ADPaymentIDArr          = []
        self.ADPaymentDateArr        = []
        self.ADPaymentAmountArr      = []
        self.ADPAymentDesc           = []
        
    }

    @IBAction func AccountDetailsSearchBtnAction(_ sender: UIButton) {
        NSLog(self.AccountDetailsSearchFieldOutlet.text!)
        
        if(self.AccountDetailsSearchFieldOutlet.text == "")
        {
            
            SetDefaultWrappers().showAlert(info:"Account number cannot be empty".localized(), viewController: self)
        }
        else
        {
            self.callPaymentDetailsAPI(srchText: self.AccountDetailsSearchFieldOutlet.text!)
        }
    }
    
    func callPaymentDetailsAPI(srchText : String)
    {
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        self.clearADVAlues()
        let webURL = "https://eservices.sewa.gov.ae/SEWAAppWebApis/Account/GetPaymentHistory?AccountId="+srchText; Alamofire.request(webURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                if let paymentListApiObj = json["AccountPaymentHistoryDetails"].arrayValue as [JSON]?
                {
                    if(paymentListApiObj.count > 0)
                    {
                        print(paymentListApiObj.count)
                        
                        for indexPayItem in 0...paymentListApiObj.count-1
                        {
                            self.ADPaymentIDArr.append(paymentListApiObj[indexPayItem]["paymentIDField"].stringValue)
                            self.ADPaymentDateArr.append(paymentListApiObj[indexPayItem]["paymentDateField"].stringValue)
                            self.ADPaymentAmountArr.append(paymentListApiObj[indexPayItem]["paymentAmountField"].stringValue)
                            self.ADPAymentDesc.append(paymentListApiObj[indexPayItem]["descriptionField"].stringValue)
                            
                                self.AccountDetailsListTableOutlet.reloadData()
                            
                             SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        }
                    }
                    else
                    {
                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        SetDefaultWrappers().showAlert(info:"Account details not found".localized(), viewController: self)
                        self.AccountDetailsSearchFieldOutlet.text = ""
//                        self.AccountDetailsListTableOutlet.reloadData()
                        
                    }
                }
                
            case .failure(let error):
                   SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                 SetDefaultWrappers().showAlert(info:"Something went wrong", viewController: self)
                print(error)
            }
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

extension AccountDetailsListVC: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 4
        return self.ADPaymentIDArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailsTBCell", for: indexPath) as! AccountDetailsTBCell
        
        
        cell.ADPaymentIDLblOutlet.text =  self.ADPaymentAmountArr[indexPath.row]
            
            //"Payment ID : " + self.ADPaymentIDArr[indexPath.row]
        cell.ADPaymentDateLabelOutlet.text = self.ADPaymentDateArr[indexPath.row]
        //cell.ADPaymentAmountLabelOutlet.text = "Amount : " + self.ADPaymentAmountArr[indexPath.row]
        cell.ADPAymentDescLabelOutlet.text =  self.ADPAymentDesc[indexPath.row]
        
        return cell
    }
    
}
