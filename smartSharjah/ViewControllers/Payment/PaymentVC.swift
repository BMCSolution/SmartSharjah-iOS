//
//  PaymentVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 04/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var tableView: UITableView!
    
    var titlesArr = ["Payments Due","Transaction History"]
    var titlesArr_Ar = ["الدفعات المستحقة","سجل المعاملات"]
   
    var subTitlesArr = ["No payments Due","Check all transactions"]
    var subTitlesArr_Ar = ["لا يوجد دفعات مستحقة","تحقق من جميع المعاملات"]
var imgArr:[UIImage] = [ UIImage(named: "pendingPayment")!, UIImage(named: "transactionHistory")! ]
    
    var searchMode:Bool!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
             Utility.setView()
          }
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            if Utility.isArabicSelected()
            {
                 self.navBar.title.text = "المدفوعات"
            }
            else
            {
                self.navBar.title.text = "Payments"
            }
           
            self.navBar.menuSettings(navController: self.navigationController, menuShown: true)
        }
          NotificationCenter.default.addObserver(self, selector: #selector(self.searchPressed), name: NSNotification.Name(rawValue: "searchPressed"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func searchPressed()
    {
        //        print("searchPressed...")
        self.searchMode = true
        self.performSegue(withIdentifier: "allServices", sender: self)
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
        if segue.identifier == "allServices"
        {
            let destNav = segue.destination as! UINavigationController
            let dest = destNav.viewControllers[0] as! ServicesListVC
            dest.searchMode = self.searchMode
        }
    }
}

extension PaymentVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titlesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "paymentCell") as! PaymentCell
        
        if Utility.isArabicSelected()
        {
            cell.titleLabel.text = self.subTitlesArr_Ar[indexPath.row]//
            cell.descriptionLbl.text = self.titlesArr_Ar[indexPath.row]
        }
        else
        {
            cell.titleLabel.text = self.subTitlesArr[indexPath.row] //
            cell.descriptionLbl.text = self.titlesArr[indexPath.row]
        }
        
        cell.icon.image = self.imgArr[indexPath.row]
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
}
