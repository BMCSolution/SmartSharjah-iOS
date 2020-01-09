//
//  InfoVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 03/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import CoreLocation

class InfoVC: UIViewController {
    
    var location: CLLocation!
    var type: String!
    var plateNumberString: String!
    var sourceString: String!
    var colorString: String!
    var licenseSourceString: String!
    var LicenseNumberString: String!
    var genderString: String!
    var dobString: String!
    var policyNumString: String!
    var insuranceCompanyString: String!
    var insuranceExpiryString: String!
    var ownerNameString: String!
    var mobileNumString: String!
    var EmailAddressString: String!
    var images:[UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]

    
    // for Non-Faulty car details
       var fn_plateCodeString: String!
       var fn_plateNumberString: String!
       var fn_sourceString: String!
       var fn_colorString: String!
       var fn_licenseSourceString: String!
       var fn_LicenseNumberString: String!
       var fn_genderString: String!
       var fn_dobString: String!
       var fn_policyNumString: String!
       var fn_insuranceCompanyString: String!
       var fn_insuranceExpiryString: String!
       var fn_ownerNameString: String!
       var fn_mobileNumString: String!
       var fn_EmailAddressString: String!
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var tableView: UITableView!
    

    var arrEn = ["Plate Number","Source","Color","Licence Source","License Num","Gender","Date of Birth","Policy Number","Insurance Company","Insurance Expiry","Owners Name","Mobile Number","Email Address"]
    
    var arrAr = ["رقم اللوحة" , "المصدر" , "اللون" , "مصدر الترخيص" , "رقم الترخيص" , "الجنس" , "تاريخ الميلاد", "رقم البوليصة" , "شركة التأمين" , "انتهاء التأمين" , " اسم المالكين "," رقم الجوال "," عنوان البريد الإلكتروني "]
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "ملخص الحادث"
            } else {
                navBar.title.text = "Accident Summary"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
    }
    
    @IBAction func submitReport(_ sender: UIButton) {
        
        self.submitData()
        
    }
    
    func submitData(){
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
        self.navigationController?.dismiss(animated: true, completion: nil)
        
//        SetDefaultWrappers().showAlert(info:"Application has been Submitted", viewController: self)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
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

extension InfoVC: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 13
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            var t = "Faulty car details"
            if Utility.isArabicSelected()
            {
                t = "تفاصيل سيارة المتسبب"
            }
            return t
        }
        else
        {
            var t = "Non-Faulty car details"
            if Utility.isArabicSelected()
            {
                t = "تفاصيل سيارة المتضرر"
            }
            return t
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "basicCell") as! UITableViewCell
        
        if indexPath.section == 0
        {
            if Utility.isArabicSelected()
                {
                    switch indexPath.row{
                    case 0:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.plateNumberString
                     case 1:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.sourceString
                     case 2:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.colorString
                     case 3:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.licenseSourceString
                     case 4:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.LicenseNumberString
                     case 5:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.genderString
                     case 6:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.dobString
                     case 7:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.policyNumString
                     case 8:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceCompanyString
                     case 9:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceExpiryString
                     case 10:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.ownerNameString
                     case 11:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.mobileNumString
                     case 12:
                         cell.textLabel?.text = self.arrAr[indexPath.row]
                         cell.detailTextLabel?.text = self.EmailAddressString
                    
                    default:
                        cell.textLabel?.text = ""
                        cell.detailTextLabel?.text = ""
                    }
                }
                else
                {
                    switch indexPath.row{
                    case 0:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.plateNumberString
                     case 1:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.sourceString
                     case 2:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.colorString
                     case 3:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.licenseSourceString
                     case 4:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.LicenseNumberString
                     case 5:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.genderString
                     case 6:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.dobString
                     case 7:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.policyNumString
                     case 8:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceCompanyString
                     case 9:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.insuranceExpiryString
                     case 10:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.ownerNameString
                     case 11:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.mobileNumString
                     case 12:
                         cell.textLabel?.text = self.arrEn[indexPath.row]
                         cell.detailTextLabel?.text = self.EmailAddressString
                    
                    default:
                        cell.textLabel?.text = ""
                        cell.detailTextLabel?.text = ""
                    }
                }
                
                return cell
        
        }
        else
        {
            
            cell =  self.fillCellData(cell: cell, indexPath: indexPath)
            return cell
            
        }
        
}

    
    func fillCellData(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell
    {
        if Utility.isArabicSelected()
        {
            switch indexPath.row{
            case 0:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_plateNumberString
             case 1:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_sourceString
             case 2:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_colorString
             case 3:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_licenseSourceString
             case 4:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_LicenseNumberString
             case 5:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_genderString
             case 6:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_dobString
             case 7:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_policyNumString
             case 8:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceCompanyString
             case 9:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceExpiryString
             case 10:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_ownerNameString
             case 11:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_mobileNumString
             case 12:
                 cell.textLabel?.text = self.arrAr[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_EmailAddressString
            
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        }
        else
        {
            switch indexPath.row{
            case 0:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_plateNumberString
             case 1:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_sourceString
             case 2:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_colorString
             case 3:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_licenseSourceString
             case 4:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_LicenseNumberString
             case 5:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_genderString
             case 6:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_dobString
             case 7:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_policyNumString
             case 8:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceCompanyString
             case 9:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_insuranceExpiryString
             case 10:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_ownerNameString
             case 11:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_mobileNumString
             case 12:
                 cell.textLabel?.text = self.arrEn[indexPath.row]
                 cell.detailTextLabel?.text = self.fn_EmailAddressString
            
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        }
        return cell
    }

}
