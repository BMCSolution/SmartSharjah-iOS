//
//  EmergencyVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON


class EmergencyVC: UIViewController
{
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var EmergencyTableOutlet: UITableView!
    fileprivate var SelectedIndex = -1
    fileprivate var IsCollapse = false
    
    
    fileprivate var LocationEnArr          :   [String]    = ["Sharjah City", "Khorfakkan City", "Kalba City"]
    fileprivate var LocationArArr          :   [String]    = []
    fileprivate var TypeArr                :   [String]    = ["Electricity", "Water", "Gas"]
    fileprivate var ElecNoArr              :   [String]    = ["991", "092385555", "092777349"]
    fileprivate var WaterNoArr             :   [String]    = ["991", "095670555", "092776955"]
    fileprivate var GasNoArr               :   [String]    = ["8006333", "092776955", "092777106"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navBar.title.text = "Emergency Contacts"
        //Arabic translation changes as per Client
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "أرقام الطوارئ"
            }else{
                self.navBar.title.text = "SEWA Emergency Contacts"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        EmergencyTableOutlet.estimatedRowHeight = 147
        EmergencyTableOutlet.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       //self.callEmergencyAPI()
    }
    func clearEmerLocalValues()
    {
        self.LocationEnArr      = []
        self.LocationArArr      = []
        self.ElecNoArr          = []
        self.WaterNoArr         = []
        self.GasNoArr           = []
    }
    
    func callEmergencyAPI()
    {
        self.clearEmerLocalValues()
        Alamofire.request("https://eservices.sewa.gov.ae/SEWAWebApiTest/Common/ContactUsEmergency", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                if let emergencyListApiObj = json.arrayValue as [JSON]?
                {
                            if(emergencyListApiObj.count > 0)
                            {
                                print(emergencyListApiObj.count)
                                
                                for indexItem in 0...emergencyListApiObj.count-1
                                {
                                    self.LocationEnArr.append(emergencyListApiObj[indexItem]["LocationEn"].stringValue)
                                    //self.LocationEnArr.append(emergencyListApiObj[indexItem]["LocationAr"].stringValue)
                                    self.ElecNoArr.append(emergencyListApiObj[indexItem]["ElecNo"].stringValue)
                                    self.WaterNoArr.append(emergencyListApiObj[indexItem]["WaterNo"].stringValue)
                                    self.GasNoArr.append(emergencyListApiObj[indexItem]["GasNo"].stringValue)
                                    self.EmergencyTableOutlet.reloadData()
                                }
                            }
                            else
                            {
                                self.EmergencyTableOutlet.reloadData()
                    
                            }
                }
                
                
                
            case .failure(let error):
                print(error)
            }
        }

    }
   

}

extension EmergencyVC: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 4
        return self.ElecNoArr.count
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyCellID", for: indexPath) as! EmergencyVCTableViewCell
        
        cell.EmerTabLabelOutlet1.text = self.TypeArr[indexPath.row]
        if Utility.isArabicSelected() {
            let _textForArab = self.TypeArr[indexPath.row] as String
            cell.EmerTabLabelOutlet1.textAlignment = NSTextAlignment.right;
            cell.EmerTabLabelOutlet3.textAlignment = NSTextAlignment.right;
            cell.EmerTabLabelOutlet4.textAlignment = NSTextAlignment.right;
            cell.EmerTabLabelOutlet5.textAlignment = NSTextAlignment.right;
            if _textForArab.lowercased().contains("electri"){
                cell.EmerTabLabelOutlet1.text = "الكهرباء"
            }else if _textForArab.lowercased().contains("water"){
                cell.EmerTabLabelOutlet1.text = "المياه"
            }else if _textForArab.lowercased().contains("gas"){
                cell.EmerTabLabelOutlet1.text = "الغاز"
            }
        }
//        cell.EmerTabLabelOutlet1.text = "Location Name : "+self.LocationEnArr[indexPath.row]
//        cell.EmerTabLabelOutlet3.text = "Electricty No : "+self.ElecNoArr[indexPath.row]
//        cell.EmerTabLabelOutlet4.text = "Water No : "+self.WaterNoArr[indexPath.row]
//        cell.EmerTabLabelOutlet5.text = "Gas No : "+self.GasNoArr[indexPath.row]
        
        if (indexPath.row == 0)
        {
            cell.img.image = UIImage(named: "elec")
            if Utility.isArabicSelected() {
                cell.EmerTabLabelOutlet3.text = "مدينة الشارقة: "+self.ElecNoArr[0]
                cell.EmerTabLabelOutlet4.text = "مدينة خورفكان: "+self.ElecNoArr[1]
                cell.EmerTabLabelOutlet5.text = "مدينة كلباء: "+self.ElecNoArr[2]
            } else {
                cell.EmerTabLabelOutlet3.text = "Sharjah City: "+self.ElecNoArr[0]
                cell.EmerTabLabelOutlet4.text = "Khorfakkan City: "+self.ElecNoArr[1]
                cell.EmerTabLabelOutlet5.text = "Kalba City: "+self.ElecNoArr[2]
            }
        } else if (indexPath.row == 1)
        {
            cell.img.image = UIImage(named: "water")
            if Utility.isArabicSelected() {
                cell.EmerTabLabelOutlet3.text = "مدينة الشارقة: "+self.WaterNoArr[0]
                cell.EmerTabLabelOutlet4.text = "مدينة خورفكان: "+self.WaterNoArr[1]
                cell.EmerTabLabelOutlet5.text = "مدينة كلباء: "+self.WaterNoArr[2]
            } else {
                cell.EmerTabLabelOutlet3.text = "Sharjah City: "+self.WaterNoArr[0]
                cell.EmerTabLabelOutlet4.text = "Khorfakkan City: "+self.WaterNoArr[1]
                cell.EmerTabLabelOutlet5.text = "Kalba City: "+self.WaterNoArr[2]
            }
            
        } else if (indexPath.row == 2)
        {
            cell.img.image = UIImage(named: "gas-1")
            if Utility.isArabicSelected() {
                cell.EmerTabLabelOutlet3.text = "مدينة الشارقة: "+self.GasNoArr[0]
                cell.EmerTabLabelOutlet4.text = "مدينة خورفكان: "+self.GasNoArr[1]
                cell.EmerTabLabelOutlet5.text = "مدينة كلباء: "+self.GasNoArr[2]
            } else {
                cell.EmerTabLabelOutlet3.text = "Sharjah City: "+self.GasNoArr[0]
                cell.EmerTabLabelOutlet4.text = "Khorfakkan City: "+self.GasNoArr[1]
                cell.EmerTabLabelOutlet5.text = "Kalba City: "+self.GasNoArr[2]
            }
        }
        self.addButton(label: cell.EmerTabLabelOutlet3, cell: cell,tag: 0)
        self.addButton(label: cell.EmerTabLabelOutlet4, cell: cell,tag: 1)
        self.addButton(label: cell.EmerTabLabelOutlet5, cell: cell,tag: 2)
        return cell
     }
    
    func addButton(label: UILabel, cell: EmergencyVCTableViewCell, tag: Int)
    {
        let btn = UIButton()
        btn.frame = label.frame
        btn.tag = tag
        btn.titleLabel!.text = label.text!
        btn.titleLabel!.isHidden = true
        btn.addTarget(self, action: #selector(labelPressed), for: .touchUpInside)
        btn.bringSubviewToFront(cell.contentView)
        cell.addSubview(btn)
    }
    
    
    @objc func labelPressed(sender: UIButton)
    {
        
        if sender.tag == 0
        {
            if sender.titleLabel!.text!.contains("Sharjah City") || sender.titleLabel!.text!.contains("مدينة الشارقة: ")
            {
                self.makeCall(number: self.ElecNoArr[0])
            }
            else if sender.titleLabel!.text!.contains("Khorfakkan City") || sender.titleLabel!.text!.contains("مدينة خورفكان: ")
            {
                self.makeCall(number: self.ElecNoArr[1])
            }
            else
            {
                self.makeCall(number: self.ElecNoArr[2])
            }
            
        }
        else if sender.tag == 1
        {
            print("1 Label Pressed...")
            if sender.titleLabel!.text!.contains("Sharjah City") || sender.titleLabel!.text!.contains("مدينة الشارقة: ")
            {
                self.makeCall(number: self.WaterNoArr[0])
            }
            else if sender.titleLabel!.text!.contains("Khorfakkan City") || sender.titleLabel!.text!.contains("مدينة خورفكان: ")
            {
                self.makeCall(number: self.WaterNoArr[1])
            }
            else
            {
                self.makeCall(number: self.WaterNoArr[2])
            }
        }
        else
        {
            print("2 Label Pressed...")
            if sender.titleLabel!.text!.contains("Sharjah City") || sender.titleLabel!.text!.contains("مدينة الشارقة: ")
            {
                self.makeCall(number: self.GasNoArr[0])
            }
            else if sender.titleLabel!.text!.contains("Khorfakkan City") || sender.titleLabel!.text!.contains("مدينة خورفكان: ")
            {
                self.makeCall(number: self.GasNoArr[1])
            }
            else
            {
                self.makeCall(number: self.GasNoArr[2])
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SelectedIndex == indexPath.row {
            
            if self.IsCollapse == false {
                self.IsCollapse = true
            } else {
                print("Test...")
                self.IsCollapse = false
            }
        } else {
            self.IsCollapse = true
        }
        self.SelectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.SelectedIndex == indexPath.row && IsCollapse == true {
            return 220
        } else {
            return 70
        }
    }
    
    func makeCall(number: String)
    {
        print("Number: \(number)")
        guard let url = URL(string: "tel://" + number) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}


