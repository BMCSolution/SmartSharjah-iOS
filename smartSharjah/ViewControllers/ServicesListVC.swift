//
//  ServicesListVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ServicesListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navbar: NavBar!
    @IBOutlet weak var tableView: UITableView!
    var selection = ""
    var searchMode: Bool?
    var searchDone = false
    
    var filterData: [String] = []
    var filterImg: [String] = []
    var filterSegues: [String] = []
    
    var _rowIndex = 0
    var _tagIndex = 0
    
    var filterDataDict: [NSMutableDictionary] = []
    var tempDataDict: [NSMutableDictionary] = []
    var data0 = [
        ["",""],
        ["",""],
        ["",""]
    ]
    var ar_data0 = [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    
    var data1 = [
                ["Job Seeker", "Social Services Job Application"],
                [ "Book a Taxi", "Flight Information", "Minor Accident Reporting" ],
                [ "Drainage Suction Request", "Interlock Request", "Housing Support Request"],
                [],
                ["SEWA Emergency Contacts", "Aman Fire Report", "Find Suggestions by SEDD"],
                ["Bee'ah Recycling Points"],
                ["Volunteer at SSSD","Adoption at SSSD", "Consultation Services", "Homecare for Elderly", "Nursing"],
                ["Destinations","Activities","Find Postal Code", "Hotels","Restaurants"],
                ["Trade Name Availability Enquiry"],
                ["SEWA Bill Payment", "Parking Payment", "Accident Fine Payment", "Fine Payment" ,"SEWA Payment History"],
                []
    ]
    
    var ar_data1 = [
        ["الباحث عن عمل",
"تطبيق وظائف الخدمات الاجتماعية"
        ],
        
        [ "احجز سيارة أجرة", "معلومات الرحلة", "تقارير الحوادث الصغرى" ],
        [ "طلب شفط الصرف", "طلب الانترلوك", "طلب دعم الإسكان"],
        [],
        ["طوارئ هيئة كهرباء ومياه الشارقة", "تسجيل في خدمة أمان", "احصل على اقتراحات من دائرة التنمية الاقتصادية بالشارقة"],
        ["نقاط إعادة التدوير لبيئة"],
        ["متطوعون بدائرة الخدمات الاجتماعية بالشارقة","الاحتضان  من خلال دائرة الخدمات الاجتماعية بالشارقة", "خدمات استشارية", "الرعاية المنزلية لكبار السن", "تمريض"],
        ["الوجهات السياحية","الأنشطة","احصل على الرمز البريدي", "الفنادق","المطاعم"],
        ["الإستفسار عن توافر اسم تجاري"],
        ["سداد فواتير هيئة كهرباء ومياه الشارقة", "سداد رسوم المواقف", "سداد غرامات الحوادث", "دفع المخالفات" ,"سجل مدفوعات هيئة كهرباء ومياه الشارقة"],
        []
    ]
    
    var data2: [[String]] = [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    var ar_data2: [[String]] = [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    
    var img0 = [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    
    var img1 = [
        ["color_new_ic_job_seeker", "color_new_ic_social_services_jobs"],
        [ "color_new_ic_taxi", "color_new_ic_flight_information", "color_new_ic_accident" ],
        [ "updated_ic_aviation_transpost", "updated_ic_interlock_new", "updated_ic_housing_support"],
        [],
        ["color_new_ic_emergency_contact", "color_new_ic_fireinfo", "color_new_ic_suggestions"],
        ["updated_ic_beeah_new"],
        ["color_new_ic_volunteer","color_new_ic_adoption", "color_new_ic_consultation", "color_new_ic_homecare", "color_new_ic_nursing"],
        ["color_new_ic_destinations","ic_activities","color_new_ic_postal", "color_new_ic_hotels_sharjah","serving-dish"],
        ["color_new_ic_trade_name"],
        ["updated_ic_utilities_bill", "color_new_ic_parkingpayment", "updated_ic_finepayment", "updated_ic_finePayment_new" ,"updated_ic_sewaPayment_new"],
        []
    ]
    
    var img2: [[String]] = [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    var segue0: [[String]]  =  [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    var segues1 = [
    
        ["Job Seeker", "homeCare"],
        [ "bookTaxi", "flightInfo", "accidentReporting" ],
        [ "Drainage Suction Request", "Interlock request", "Housing support request"],
        [],
        ["emergencyServices", "Aman Fire Report", "Find Suggestions by SEDD"],
        ["Bee'ah Recycling Points"],
        ["homeCare","adoptionServices", "consultancy", "homeCare", "homeCare"],
        ["sharjahDestinations","sharjahActivities","PostalCodes", "Hotels","resturant"],
        ["tradeName"],
        ["SEWA Bill Payment", "mParking", "Accident Fine Payment", "Fine Payment" ,"paymentSegue"],
        []
        
    ]
    var segue2: [[String]]  = [
        ["",""],
        ["",""],
        ["",""]
    ]
    
    var itemImg:UIImage!
    var itemTitle:String!
    var tagN: Int!
    var tagIndex: Int!
    
    
    @objc func showSuccess(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            SetDefaultWrappers().showAlert(info:"Your application has been successfully submitted".localized(), viewController: self)
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (self.searchMode as? Bool != nil)
        {
            if (self.searchMode! && self.searchDone)
            {
//                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.isNavigationBarHidden = true
        if ((self.searchMode) != nil)
        {
            self.searchBar.isHidden = !self.searchMode!
            self.combineAllServices()
            self.addAllServicesToDictionary()
            self.tempDataDict = self.filterDataDict
            print("All Dictionaries count: \(self.filterDataDict.count)")
//            self.filterData = self.data0.append(contentsOf: self.data1)
//            self.filterImg = []
//            self.filterSegues = []
            if (self.navbar != nil)
            {
                if Utility.isArabicSelected()
                {
                     self.navbar.title.text = "البحث"
                }
                else
                {
                     self.navbar.title.text = "Search"
                }
               
                self.navbar.menuSettings(navController: self.navigationController, menuShown: false)
            }
        }
        else
        {
            self.searchBar.isHidden = true
            if (self.navbar != nil)
            {
                self.navbar.title.text = itemTitle
                self.navbar.menuSettings(navController: self.navigationController, menuShown: false)
            }
        }
        self.searchBar.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSuccess), name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
        
        
        
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        print ("TagN:", tagN!)
//        print ("TagIndex:", tagIndex!)
        
        
        // Do any additional setup after loading the view.
    }
    
    func combineAllServices()
    {
        var allData = [[[""]]]
        if Utility.isArabicSelected() {
            allData = [ar_data1]
        }else{
            allData = [data1]
        }
            for d in allData
            {
                for x in d
                {
                    for a in x
                    {
                        self.filterData.append(a)
                    }
                }
            }
            print("All services count = \(self.filterData.count)")
            
            let allImgs = [img1]
            for d in allImgs
            {
                for x in d
                {
                    for a in x
                    {
                        self.filterImg.append(a)
                    }
                }
            }
            print("All images count = \(self.filterImg)")
            
            let allsegs = [ segues1]
            for d in allsegs
            {
                for x in d
                {
                    for a in x
                    {
                        self.filterSegues.append(a)
                    }
                }
        }
        print("All segues count = \(self.filterSegues.count)")
    }
    
    func addAllServicesToDictionary()
    {
        for item in self.filterData
        {
            let serDict : NSMutableDictionary = [:]
            let index = self.filterData.index(of: item)!
            serDict["serviceName"] = item
            serDict["image"] = self.filterImg[index]
            serDict["segue"] = self.filterSegues[index]
            
            self.filterDataDict.append(serDict)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.showNavigationBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavigationBar()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (selection == "Social Services Job Application" || selection == "Homecare for Elderly" || selection == "Volunteer at SSSD" || selection == "Nursing")
        {
            if Utility.isArabicSelected() {
                
                if self.ar_data1[_tagIndex][_rowIndex] == "متطوعون بدائرة الخدمات الاجتماعية بالشارقة"
                {
                    self.selection = "وظائف الخدمات الاجتماعية"
                }
                else
                {
                    self.selection = self.ar_data1[_tagIndex][_rowIndex]
                }
                
            }else{
                self.selection = self.data1[_tagIndex][_rowIndex]
            }
                                    
            let userDefaults = UserDefaults.standard
            userDefaults.set(selection, forKey: "service")
            userDefaults.synchronize()
            
            let destination = segue.destination as? UINavigationController
            let destVc = destination?.viewControllers[0] as! HomeCareVC1
            destVc.titleString = selection
            
            print ("Selection Saved: \(selection)")
        }
        else{
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "service")
            userDefaults.synchronize()
            print ("Selection NOT Saved \(selection) ")
        }
    }
}

extension ServicesListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print ("L \(self.data1[tagIndex])")
        if (self.searchMode != nil)
        {
            print("****Items count: \(self.filterDataDict.count)")
             return self.filterDataDict.count
        }
        else
        {
            if Utility.isArabicSelected() {
                
                if (tagN == 0)
                {
                   return 0 //self.ar_data0[tagIndex].count
                }
                else if (tagN == 1){
                    return self.ar_data1[tagIndex].count
                }
                else{
                    return 0//self.ar_data2[tagIndex].count
                }
                
             
            }
            else {
                
                
             if (tagN == 0)
             {
//                print("-----Items count: \(self.data0[tagIndex].count) \(self.data0[tagIndex])")
                return 0//self.data0[tagIndex].count
                }
             else if (tagN == 1){
                return self.data1[tagIndex].count
                }
             else{
                return 0//self.data2[tagIndex].count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ServicesCell") as! ServicesCell
        
        cell.bg.layer.cornerRadius = 10
        cell.servicesImage.image = nil
//        print ("tagN: \(tagN)")
        
        if (self.searchMode != nil)
        {
            if let title = self.filterDataDict[indexPath.row].value(forKey: "serviceName") as? String
            {
                cell.serviceLabel.text = title
            }
            else
            {
                print("Service Name not found")
            }
            
            if let img = self.filterDataDict[indexPath.row].value(forKey: "image") as? String
            {
//                print("image name: \(img)")
                cell.servicesImage.image = UIImage(named: img)//
            }
            else
            {
                print("image not found")
            }
            
           
        }
        else
        {

            if (self.tagN == 1)
            {
                if Utility.isArabicSelected() {
                    cell.serviceLabel.text = self.ar_data1[tagIndex][indexPath.row]
                }
                else {
                    cell.serviceLabel.text = self.data1[tagIndex][indexPath.row]
                }
                cell.servicesImage.image = UIImage(named: self.img1[tagIndex][indexPath.row])//self.itemImg
            }
            else{
                cell.servicesImage.image = self.itemImg
            }
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.searchDone = true
        
        var isLoggedIn = false
        
        if User().isLoggedin()
        {
            isLoggedIn = true
        }
        else if let loggedIn = UserDefaults.standard.value(forKey: "username") as? String{
            isLoggedIn = true
        }
        
        if (self.searchMode != nil)
        {
            let cell = self.tableView .cellForRow(at: indexPath) as! ServicesCell
            
//            cell.serviceLabel.text as NSString? == "Social Services Job Application" ||
            if cell.serviceLabel.text as NSString? == "Job Seeker" || cell.serviceLabel.text as NSString? == "Drainage Suction Request" || cell.serviceLabel.text as NSString? == "Interlock Request" || cell.serviceLabel.text as NSString? == "Hotels" || cell.serviceLabel.text as NSString? == "Housing Support Request" || cell.serviceLabel.text as NSString? == "Aman Fire Report" || cell.serviceLabel.text as NSString? == "Find Suggestions by SEDD" || cell.serviceLabel.text as NSString? == "Bee'ah Recycling Points" || cell.serviceLabel.text as NSString? == "SEWA Bill Payment" || cell.serviceLabel.text as NSString? == "Go Sharjah" || cell.serviceLabel.text as NSString? == "SEWA Bill Payment" || cell.serviceLabel.text as NSString? == "Accident Fine Payment" || cell.serviceLabel.text as NSString? == "Fine Payment" || cell.serviceLabel.text as NSString? == "تسجيل في خدمة أمان" || cell.serviceLabel.text as NSString? == "طلب شفط الصرف" || cell.serviceLabel.text as NSString? == "طلب الانترلوك" || cell.serviceLabel.text as NSString? == "الفنادق" || cell.serviceLabel.text as NSString? == "طلب دعم الإسكان" || cell.serviceLabel.text as NSString? == "احصل على اقتراحات من دائرة التنمية الاقتصادية بالشارقة" || cell.serviceLabel.text as NSString? == "نقاط إعادة التدوير لبيئة" || cell.serviceLabel.text as NSString? == "سداد فواتير هيئة كهرباء ومياه الشارقة" || cell.serviceLabel.text as NSString? == "سداد غرامات الحوادث" || cell.serviceLabel.text as NSString? == "الباحث عن عمل" || cell.serviceLabel.text as NSString? == "دفع المخالفات"
            {
                SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
            }
            else if (cell.serviceLabel.text as NSString? == "تقارير الحوادث الصغرى" || cell.serviceLabel.text as NSString? == "Minor Accident Reporting" ||
                cell.serviceLabel.text as NSString? == "تطبيق وظائف الخدمات الاجتماعية"
                || cell.serviceLabel.text as NSString? == "Social Services Job Application" || cell.serviceLabel.text as NSString? == "" || cell.serviceLabel.text as NSString? == "Volunteer at SSSD" || cell.serviceLabel.text as NSString? == "Adoption at SSSD" || cell.serviceLabel.text as NSString? == "Consultation Services" || cell.serviceLabel.text as NSString? == "Homecare for Elderly" || cell.serviceLabel.text as NSString? == "Nursing" ||  cell.serviceLabel.text as NSString? == "متطوعون بدائرة الخدمات الاجتماعية بالشارقة" || cell.serviceLabel.text as NSString? == "الاحتضان  من خلال دائرة الخدمات الاجتماعية بالشارقة" || cell.serviceLabel.text as NSString? == "خدمات استشارية" || cell.serviceLabel.text as NSString? == "الرعاية المنزلية لكبار السن" || cell.serviceLabel.text as NSString? == "تمريض")
            {
                
                if (!isLoggedIn)
                {
                    SetDefaultWrappers().showAlert(info:"Login to use this feature".localized(), viewController: self)
                }
                else
                {

                        
                       if let seg = self.filterDataDict[indexPath.row].value(forKey: "segue") as? String
                        {
                            if let title = self.filterDataDict[indexPath.row].value(forKey: "serviceName") as? String
                            {
                                 self.selection = title
                            }
                            self.performSegue(withIdentifier:seg, sender: self)
                        }
    
                }
                
                
            }
            /*else
            {
                
                if let seg = self.filterDataDict[indexPath.row].value(forKey: "segue") as? String
                {
                    if let title = self.filterDataDict[indexPath.row].value(forKey: "serviceName") as? String
                    {
                         self.selection = title
                    }
                    
                   self.performSegue(withIdentifier:seg, sender: self)
                }
            }*/
        }
        else
        {
            if (self.tagN == 1)
            {
                let cell = self.tableView .cellForRow(at: indexPath) as! ServicesCell
                if  cell.serviceLabel.text as NSString? == "Job Seeker"  || cell.serviceLabel.text as NSString? == "Drainage Suction Request" || cell.serviceLabel.text as NSString? == "Interlock Request" || cell.serviceLabel.text as NSString? == "Hotels" || cell.serviceLabel.text as NSString? == "Housing Support Request" || cell.serviceLabel.text as NSString? == "Aman Fire Report" || cell.serviceLabel.text as NSString? == "Find Suggestions by SEDD" || cell.serviceLabel.text as NSString? == "Bee'ah Recycling Points" || cell.serviceLabel.text as NSString? == "SEWA Bill Payment" || cell.serviceLabel.text as NSString? == "Go Sharjah" || cell.serviceLabel.text as NSString? == "SEWA Bill Payment" || cell.serviceLabel.text as NSString? == "Accident Fine Payment" || cell.serviceLabel.text as NSString? == "Fine Payment" || cell.serviceLabel.text as NSString? == "تسجيل في خدمة أمان" || cell.serviceLabel.text as NSString? == "طلب شفط الصرف" || cell.serviceLabel.text as NSString? == "طلب الانترلوك" || cell.serviceLabel.text as NSString? == "الفنادق" || cell.serviceLabel.text as NSString? == "طلب دعم الإسكان" || cell.serviceLabel.text as NSString? == "احصل على اقتراحات من دائرة التنمية الاقتصادية بالشارقة" || cell.serviceLabel.text as NSString? == "نقاط إعادة التدوير لبيئة" || cell.serviceLabel.text as NSString? == "سداد فواتير هيئة كهرباء ومياه الشارقة" || cell.serviceLabel.text as NSString? == "سداد غرامات الحوادث" || cell.serviceLabel.text as NSString? == "الباحث عن عمل" || cell.serviceLabel.text as NSString? == "Media" || cell.serviceLabel.text as NSString? == "وسائل الإعلام" || cell.serviceLabel.text as NSString? == "دفع المخالفات"
                {
                    SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                }
                else if cell.serviceLabel.text as NSString? == "تقارير الحوادث الصغرى" || cell.serviceLabel.text as NSString? == "Minor Accident Reporting" || cell.serviceLabel.text as NSString? == "تطبيق وظائف الخدمات الاجتماعية" || cell.serviceLabel.text as NSString? == "Social Services Job Application" || cell.serviceLabel.text as NSString? == "Volunteer at SSSD" || cell.serviceLabel.text as NSString? == "Adoption at SSSD" || cell.serviceLabel.text as NSString? == "Consultation Services" || cell.serviceLabel.text as NSString? == "Homecare for Elderly" || cell.serviceLabel.text as NSString? == "Nursing" ||  cell.serviceLabel.text as NSString? == "متطوعون بدائرة الخدمات الاجتماعية بالشارقة" || cell.serviceLabel.text as NSString? == "الاحتضان  من خلال دائرة الخدمات الاجتماعية بالشارقة" || cell.serviceLabel.text as NSString? == "خدمات استشارية" || cell.serviceLabel.text as NSString? == "الرعاية المنزلية لكبار السن" || cell.serviceLabel.text as NSString? == "تمريض"
                {
                    if (!isLoggedIn)
                    {
                        SetDefaultWrappers().showAlert(info:"Login to use this feature".localized(), viewController: self)
                    }
                    else
                    {
                            _rowIndex = indexPath.row
                            _tagIndex = tagIndex
                            
                            self.selection = self.data1[tagIndex][indexPath.row]
                            
                            
                        self.performSegue(withIdentifier: self.segues1[tagIndex][indexPath.row], sender: self)
                    }
                }
                else
                {
                    //noor edit
                    if ( cell.serviceLabel.text as NSString? == "Restaurants" || cell.serviceLabel.text as NSString? == "المطاعم"){
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Resturant", bundle: nil)
                        let restaurantViewController = storyBoard.instantiateViewController(withIdentifier: "resturant") as! Resturant
//                        self.present(balanceViewController, animated: true, completion: nil)
                        self.navigationController?.title = "Restaurants"
                        self.navigationController?.pushViewController(restaurantViewController, animated: true)
                        
                        print("going through from here")
                        
                    }
                        //---end
                    else{
                                               
                        _rowIndex = indexPath.row
                        _tagIndex = tagIndex
                        
                        self.selection = self.data1[tagIndex][indexPath.row]
                        
                        
                    self.performSegue(withIdentifier: self.segues1[tagIndex][indexPath.row], sender: self)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
}

extension ServicesListVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != ""
        {
            let arrNames:Array = self.filterDataDict
            let namePredicate = NSPredicate(format: "serviceName contains[cd] %@",searchText)
            self.filterDataDict = arrNames.filter { namePredicate.evaluate(with: $0) }
            self.tableView.reloadData()
        }
        else
        {
            self.filterDataDict = self.tempDataDict
            self.tableView.reloadData()
        }
       
    }
}
