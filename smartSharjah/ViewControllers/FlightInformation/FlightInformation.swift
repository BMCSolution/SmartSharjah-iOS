//
//  FlightInformation.swift
//  smartSharjah
//
//  Created by OzzY on 8/29/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class FlightInformation: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var fromDate: UIButton!
    @IBOutlet weak var toDate: UIButton!
    var current = ""
    
    var flightType = "ARRIVAL"
    
    var classFromDate   = Date()
    var classToDate     = Date()
    
    var selectedFromDate: String?
    var selectedToDate: String?
    
    
    //flight details array
    fileprivate var FlightNameArr           :   [String]    = []
    fileprivate var FlightNoArr             :   [String]    = []
    fileprivate var FlightFromToNameArr     :   [String]    = []
    fileprivate var FlightTimeArr           :   [String]    = []
    fileprivate var FlightStatusArr         :   [String]    = []
    fileprivate var FlightTerArr            :   [String]    = []
    
    var allFlightData:[NSDictionary] = []
    
    var isAlreadyBusy = false
    
    override func viewDidLoad() {
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "معلومات الرحلة"
            } else {
                navBar.title.text = "Flight Information"
            }
                
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        self.dateView.isHidden = true
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        self.selectedFromDate = formatter.string(from: date)
        self.selectedToDate = formatter.string(from: date)
        self.fromDate.setTitle(formatter.string(from: date), for: .normal)
        self.toDate.setTitle(formatter.string(from: date), for: .normal)
        
        if Reachability.isConnectedToNetwork()
        {
            isAlreadyBusy = true
            if(Utility.checkSesion())
            {
                self.callFligtInfoAPI()
            }
            else
            {
                Utility.getFreshToken {
                    (success, response) in
                    self.callFligtInfoAPI()
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
    }
    
    func clearFlightData()
    {
        self.FlightNameArr          = []
        self.FlightNoArr            = []
        self.FlightFromToNameArr    = []
        self.FlightTimeArr          = []
        self.FlightStatusArr        = []
        self.FlightTerArr           = []
    }
    
    
    @IBAction func searchFlightDetailsBtnAction(_ sender: Any) {
        let fromText = self.fromDate.titleLabel?.text
        let toText = self.toDate.titleLabel?.text
        if(!isAlreadyBusy)
        {
            if (fromText == "" || toText == "" || fromText == "Select Date" || toText == "Select Date")
            {
                SetDefaultWrappers().showAlert(info:"From & To dates must be selected", viewController: self)
            }
            else
            {
                if Reachability.isConnectedToNetwork()
                {
                    isAlreadyBusy = true
                    if(Utility.checkSesion())
                    {
                        self.callFligtInfoAPI()
                    }
                    else
                    {
                        Utility.getFreshToken {
                            (success, response) in
                            self.callFligtInfoAPI()
                        }
                    }
                }
                else
                {
                    Utility.showInternetErrorAlert()
                }
               
            }
        }
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        if(!isAlreadyBusy)
        {
            if (sender.selectedSegmentIndex == 0)
            {
                    self.flightType = "ARRIVAL"
            }
            else
            {
                    self.flightType = "DEPARTURE"
            }
            if Reachability.isConnectedToNetwork()
            {
                isAlreadyBusy = true
                if(Utility.checkSesion())
                {
                    self.callFligtInfoAPI()
                }
                else
                {
                    Utility.getFreshToken {
                        (success, response) in
                        self.callFligtInfoAPI()
                    }
                }
            }
            else
            {
                Utility.showInternetErrorAlert()
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
    
    func callFligtInfoAPI()
    {
        
        let parameterLocal: Parameters = [
            "fromDate": self.fromDate.titleLabel!.text!,
            "toDate": self.toDate.titleLabel!.text!
        ]
        
        var heades = [
            "Content-Type":"application/json",
            "charset":"utf-8"
                ]
        self.clearFlightData()
//        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForResource = 10
                manager.session.configuration.timeoutIntervalForRequest = 10
        //let webURL = "https://stg-smtshjapp.shj.ae/api/GetDailyFlights/GetFlights?fromDate=\(self.selectedFromDate!)&toDate=\(self.selectedToDate!)&flightType=\(self.flightType)";
    
        //insert URL here
        
        //print ("URL: \(webURL)")
//        print ("Params: \(parameterLocal)")
        
        //if  webURL != ""
        //{
            
            SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
            let ulr =  URL(string: "https://stg-smtshjapp.shj.ae/api/DailyFlightsController/GetFlights")!
            var request = URLRequest(url: ulr as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let userDefaults = UserDefaults.standard
               
                      let accesstoken = userDefaults.object(forKey: "access_token") as! String
                      let authData = accesstoken
            request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
            let data = try! JSONSerialization.data(withJSONObject: ["fromDate":self.selectedFromDate!,"toDate":self.selectedToDate!,"flightType":self.flightType], options: JSONSerialization.WritingOptions.prettyPrinted)

                       let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                       if let json = json {
                           print(json)
                       }
                       request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            
            Alamofire.request(request as! URLRequestConvertible)
                //manager.request(URL(string: webURL)!)
                .responseJSON { (response) in
                
                print("Test...")
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                    self.isAlreadyBusy = false
//                print("Flight Rsponse: \(response)")
                if (response.error != nil)
                {
                    print ("Error 501, \(response.error?.localizedDescription ?? "Error ****" )")
                    
                }
                else
                {
                    if let code = response.response?.statusCode as? Int{
                        if code == 401
                        {
                            self.isAlreadyBusy = true
                            Utility.getFreshToken {
                            (success, response) in
                                self.callFligtInfoAPI()
                            }
                        }
                        else
                        {
                            if let val = response.result.value as? NSDictionary{
                                if let value = val.value(forKey: "data") as? String
                                {
                                    if let dict = self.convertToDictionary(text: value) as NSDictionary?
                                    {
                                        print(dict);
                                        if let arr = dict.value(forKey: "DailyScheduleResult") as? [NSDictionary]
                                        {
                                            if arr.count > 0
                                            {
                                                self.allFlightData = arr
                                                self.tableView.reloadData()
                                                
                                            }
                                            else
                                            {
                                                var m = "Data not found."
                                                if Utility.isArabicSelected()
                                                {
                                                    m = "لم يتم العثور على بيانات."
                                                }
                                                SetDefaultWrappers().showAlert(info: m, viewController: self)
                                            }
                                        }
                                        else
                                        {
                                            var m = "Data not found."
                                           if Utility.isArabicSelected()
                                           {
                                               m = "لم يتم العثور على بيانات."
                                           }
                                            SetDefaultWrappers().showAlert(info: m, viewController: self)
                                        }
                                    }
                                    else
                                    {
                                         var m = "Data not found."
                                        if Utility.isArabicSelected()
                                        {
                                            m = "لم يتم العثور على بيانات."
                                        }
                                         SetDefaultWrappers().showAlert(info: m, viewController: self)

                                        print("conversion to Dictionary failed...")
                                    }
                                }
                                
                                
                            }
                            else
                            {
                                 var m = "Data not found."
                                if Utility.isArabicSelected()
                                {
                                    m = "لم يتم العثور على بيانات."
                                }
                                 SetDefaultWrappers().showAlert(info: m, viewController: self)

                                print("conversion to String failed...")
                            }
                        }
                    }
                }
                
            }
        //}
        
        
    }

    @IBAction func selectFromDate(_ sender: UIButton) {
    
        print("hello...")
        self.dateView.subviews.map({
            if ($0.tag != 100)
            {$0.removeFromSuperview()}
        })
        self.current = "from"
        let picker : UIDatePicker = UIDatePicker()
        picker.date = self.classFromDate
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.addTarget(self, action: #selector(fromDateChanged(sender:)), for: UIControl.Event.valueChanged)
        let pickerSize : CGSize = picker.sizeThatFits(CGSize.zero)
        picker.frame = CGRect(x:0.0, y:20, width:self.dateView.frame.width, height:300)

        picker.backgroundColor = UIColor.white
        DispatchQueue.main.async {
            self.dateView.addSubview(picker)
            self.dateView.isHidden = false
            self.dateView.bringSubviewToFront(self.view)
        }
}
    
    @objc func fromDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd-MM-yyyy"
//        dateFormatter.timeStyle = .none
        self.classFromDate = sender.date
        self.selectedFromDate = dateFormatter.string(from: sender.date)
        self.fromDate.setTitle(dateFormatter.string(from: sender.date), for: .normal)
    }
    
    @objc func toDateChanged(sender:UIDatePicker){
        if(self.fromDate.titleLabel?.text == "" || self.fromDate.titleLabel?.text == "Select Date")
        {
             SetDefaultWrappers().showAlert(info:"Please select from date first", viewController: self)
        }
        else
        {
            self.classToDate = sender.date
            if(classFromDate <= classToDate)
            {
                //execute
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                self.selectedToDate = dateFormatter.string(from: sender.date)

                self.toDate.setTitle(dateFormatter.string(from: sender.date), for: .normal)
            }
            else if (classFromDate > classToDate)
            {
                var m = "From date should be earlier than To date"
                if Utility.isArabicSelected()
                {
                    m = "من تاريخ يجب أن يكون أقدم من حتى الآن"
                }
                SetDefaultWrappers().showAlert(info: m, viewController: self)
            }
            else
            {
               SetDefaultWrappers().showAlert(info:"Unexpected Error", viewController: self)
            }
        }

    }


    @IBAction func savePressed(_ sender: UIButton) {
        self.dateView.subviews.map({
            
            if ($0.tag != 100)
            {$0.removeFromSuperview()}
            
        })
        
        self.dateView.isHidden = true
    }
    
    @IBAction func selectToDate(_ sender: UIButton) {
        self.dateView.subviews.map({
            
            if ($0.tag != 100)
            {$0.removeFromSuperview()}
            
        })
        self.current = "to"
        let picker : UIDatePicker = UIDatePicker()
        picker.date = self.classToDate
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.addTarget(self, action: #selector(toDateChanged(sender:)), for: UIControl.Event.valueChanged)
        let pickerSize : CGSize = picker.sizeThatFits(CGSize.zero)
        picker.frame = CGRect(x:0.0, y:20, width:self.dateView.frame.width, height:300)
        
        picker.backgroundColor = UIColor.white
        
        DispatchQueue.main.async {
            self.dateView.addSubview(picker)
            self.dateView.isHidden = false
        }
    }
}

extension FlightInformation: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allFlightData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let flightCell = self.tableView.dequeueReusableCell(withIdentifier: "flightCellID") as! FlightTableViewCell
        
        var current = self.allFlightData[indexPath.row]
        
       
        
        if let flightcode = current.value(forKey: "AirlineCode") as? String{
            
            flightCell.flightNoLbl.text = flightcode
            
        }
        
        if let scheduledtime = current.value(forKey: "ScheduleTime") as? String{
            
            
            flightCell.flightDateTime.text = scheduledtime.components(separatedBy: " ").last!
            var date = Date()
            var formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            if let d  = formatter.date(from: scheduledtime) as? Date{
                formatter.dateFormat = "HH:mm"
                flightCell.flightDateTime.text = formatter.string(from: d)
                
                formatter.dateFormat = "dd-MM-yyyy"
                flightCell.flightDate.text = formatter.string(from: d)
            }
            
            if Utility.isArabicSelected()
            {
                if let flightname = current.value(forKey: "AirlineNameAr") as? String{
                           
                           flightCell.flightAirlineNameLbl.text = "\(flightname)"
                           
                           if let flightnum = current.value(forKey: "FlightNumber") as? String{
                               
                               flightCell.flightAirlineNameLbl.text = "\(flightname) - \(flightnum)"
                           }
                       }
                
                
                if let status = current.value(forKey: "FlightStatusAr") as? String{
                    flightCell.flightStatusLbl.text = status
                }
                if let routesList = current.value(forKey: "RouteList") as? [NSDictionary]{
                    
                    let from = routesList.first
                    let last = routesList.last
                    
                    if let str = from?.value(forKey: "AirportNameAr") as? String{
                        
                        flightCell.flightFromToLbl.text = str
                        
                    }
                        if let str = last?.value(forKey: "AirportNameAr") as? String{
                            
                            flightCell.flightToLbl.text = str
                        }
                }
            }
            else
            {
                
                if let flightname = current.value(forKey: "AirlineName") as? String{
                           
                           flightCell.flightAirlineNameLbl.text = "\(flightname)"
                           
                           if let flightnum = current.value(forKey: "FlightNumber") as? String{
                               
                               flightCell.flightAirlineNameLbl.text = "\(flightname) - \(flightnum)"
                           }
                       }
                
                if let status = current.value(forKey: "FlightStatus") as? String{
                    flightCell.flightStatusLbl.text = status
                }
                if let routesList = current.value(forKey: "RouteList") as? [NSDictionary]{
                    
                    let from = routesList.first
                    let last = routesList.last
                    
                    if let str = from?.value(forKey: "AirportName") as? String{
                        
                        flightCell.flightFromToLbl.text = str
                        
                    }
                        if let str = last?.value(forKey: "AirportName") as? String{
                            
                            flightCell.flightToLbl.text = str
                        }
                }
            }
            
        }
        return flightCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


    

