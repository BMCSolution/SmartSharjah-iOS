//
//  BookTaxiVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/28/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON
import Foundation

class BookTaxiVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var taxiTypetxv: TextField!
    //    @IBOutlet weak var taxiTypetxv: UITextField!
    @IBOutlet weak var datetime: UIDatePicker!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var txtFullName: TextField!
    //    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtCode: TextField!
    //    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var txtPhoneNum: TextField!
    //    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtPickerDateTime: TextField!
    //    @IBOutlet weak var txtPickerDateTime.textField: UITextField!
    @IBOutlet weak var viewForDateTime: UIView!
    @IBOutlet weak var viewForMap: UIView!
//    @IBOutlet weak var txvDriverNotes: UITextView!
    @IBOutlet weak var txvDriverNotes: TextField!
    
    @IBOutlet weak var txvDestination: UITextField!
    
    @IBOutlet weak var txtPickupLocation: TextField!
    
    @IBOutlet weak var txtDropoffLocation: TextField!
   
    
    @IBOutlet weak var driverNotes_txtView: UITextView!
    
    let locationManager = CLLocationManager()
    var currentLat="0"
    var currentLong="0"
    var dropOffLat = "0"
    var dropOfflong = "0"
    var taxiType="--"
    
    
    override func viewDidAppear(_ animated: Bool) {
        Utility.setView()
        self.fillData()
    }
    
    func fillData()
    {
        let user = User().getUser()
        if let name  = user.value(forKey: User().name_Key) as? String
        {
           self.txtFullName.textField.text = name
        }
        if let num  = user.value(forKey: User().mobileNumber_key) as? String
        {
//            self.mobileNoTF.textField.text = num
            let cd = num.prefix(3)
            if cd == "971"
            {
                self.txtCode.textField.text = String(cd)
                
                let n = num.suffix(9)
                self.txtPhoneNum.textField.text = String(n)
            }
           
            
        }
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        self.driverNotes_txtView.textAlignment = Utility.isArabicSelected() ? .right : .left
        
        if Utility.isArabicSelected() {
            txtFullName.hint = "الاسم الكامل *"
            txtCode.hint = "الرمز *"
            txtCode.keyboardType = UIKeyboardType.numberPad
            txtPhoneNum.hint = "رقم الهاتف *"
            txtPhoneNum.keyboardType = UIKeyboardType.numberPad
            txtPickerDateTime.hint = "التاريخ والوقت *"
            txvDriverNotes.hint = "ملاحظات الى السائق *"
            taxiTypetxv.hint = "نوع سيارة الأجرة *"
            //txvDestination.hint = ""
     
            
            taxiTypetxv.options = "سيارة أجرة عادية,سيارة أجرة للنساء,سيارة أجرة لأصحاب الهمم"
            txtPickupLocation.hint = "موقع الانطلاق *"
            txtDropoffLocation.hint = "الوجهة *"
        } else {
            txtFullName.hint = "Full Name *"
            txtCode.hint = "Code *"
            txtCode.keyboardType = UIKeyboardType.numberPad
            txtPhoneNum.hint = "Phone Number *"
            txtPhoneNum.keyboardType = UIKeyboardType.numberPad
            txtPickerDateTime.hint = "Date and Time *"
            txvDriverNotes.hint = "Driver Notes *"
            taxiTypetxv.hint = "Taxi Type *"
            //txvDestination.hint = ""
            txtPickupLocation.hint = "Pick Up Location *"
            txtDropoffLocation.hint = "Drop Off Location *"
             taxiTypetxv.options = "Normal Taxi,Ladies Taxi,People of Determination Taxi"
        }
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "احجز سيارة أجرة"
            } else {
                self.navBar.title.text = "Book a Taxi"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        
        mapView.showsUserLocation = true
        
        self.mapView.delegate =  self as! MKMapViewDelegate
   
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
       
        handleTap()
        
        self.getLocation()
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            
//        print ("Map Tapped")
        resignFirstResponderForAllTextfield()
    }
    
    func getAllTextFields(fromView view: UIView)-> [TextField] {
        return view.subviews.flatMap { (view) -> [TextField]? in
            if view is TextField {
                return [(view as! TextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    func validated() -> Bool{
         for x in getAllTextFields(fromView: self.view){
           
            if x.hint.contains("Driver Notes") || x.hint.contains("ملاحظات الى السائق *")
            {
                if self.driverNotes_txtView.text == ""
                {
                    var t = "cannot be empty"
                    if Utility.isArabicSelected()
                    {
                       t = "لايمكن ان يكون فارغا"
                    }

                   SetDefaultWrappers().showAlert(info:"\(x.hintLbl.text!) " + t, viewController: self)
                   return false
                }
                
            }
            else if x.hint.contains("Phone Number *") || x.hint.contains("رقم الهاتف *")
            {
                if x.textField.text == ""
                {
                    var t = "cannot be empty"
                     if Utility.isArabicSelected()
                     {
                        t = "لايمكن ان يكون فارغا"
                     }

                    SetDefaultWrappers().showAlert(info:"\(x.hintLbl.text!) " + t, viewController: self)
                    return false
                }
            }
            else
            {
                if (!x.validate())
                {
                    return false
                }
            }
            
        }
        
        return true
    }
    // MARK: - Action Buttons
    
    @IBAction func bookTaxiPress(_ sender: Any) {
       resignFirstResponderForAllTextfield()
//        if (self.txtFullName.textField.text == "") {
//            SetDefaultWrappers().showAlert(info:"Fullname cannot be empty", viewController: self)
//            return
//        } else if (self.txtCode.textField.text == "") {
//            SetDefaultWrappers().showAlert(info:"Country code cannot be empty", viewController: self)
//              return
//        } else if (!self.txtPhoneNum.validate()) {
////            SetDefaultWrappers().showAlert(info:"Phone number cannot be empty", viewController: self)
//              return
//        } else if (self.txtPickerDateTime.textField.text == ""){
//            SetDefaultWrappers().showAlert(info:"Date and time cannot be empty", viewController: self)
//              return
//        } else if (self.txtDropoffLocation.textField.text! == "")
//        {
//            SetDefaultWrappers().showAlert(info:"Destination cannot be empty", viewController: self)
//              return
//
        
    
        if validated()
        {
            if Reachability.isConnectedToNetwork()
            {
                if(Utility.checkSesion())
                {
                    apicallHttps()
                }
                else
                {
                    Utility.getFreshToken {
                        (success, response) in
                        self.apicallHttps()
                    }
                }
            }
            else
            {
                Utility.showInternetErrorAlert()
            }
        }
        
    }
    
    
    @IBAction func viewForMapTouched(_ sender: Any) {
             resignFirstResponderForAllTextfield()
        viewForMap.isHidden = false
        centerMapOnUserLocation()
    }
    
    let regionRadius: Double = 1000
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        var center = mapView.centerCoordinate
        print(center.latitude)
        print(center.longitude)
        dropOffLat=center.latitude.description
        dropOfflong=center.longitude.description
        
        let lat: Double = Double("\(dropOffLat)")!
        //21.228124
        let lon: Double = Double("\(dropOfflong)")!
        
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        getAddress(locationInput: loc)
        
    }
    
    @IBAction func closeButtonForMapTouched(_ sender: Any) {
             resignFirstResponderForAllTextfield()
        viewForMap.isHidden = true
    }
    
    @IBAction func buttonConfirmDateTimeTouched(_ sender: Any) {
             resignFirstResponderForAllTextfield()
        viewForDateTime.isHidden = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        txtPickerDateTime.textField.text = formatter.string(from: datetime.date)
        
    }
    
    @IBAction func dateTimePickerSelected(_ sender: Any) {
             resignFirstResponderForAllTextfield()
        viewForDateTime.isHidden=false
    }

    
    
    @IBAction func buttonForTaxiType(_ sender: Any) {
        let otherAlert = UIAlertController(title: "Multiple Actions", message: "The alert has more than one action which means more than one button.", preferredStyle: UIAlertController.Style.actionSheet)
        
        let printSomething = UIAlertAction(title: "Normal Taxi", style: UIAlertAction.Style.default) { _ in
           self.taxiTypetxv.textField.text="Normal Taxi"
            self.taxiType="30"
        }
        
        let callFunction = UIAlertAction(title: "Ladies Taxi", style: UIAlertAction.Style.default) { _ in
            self.taxiTypetxv.textField.text="Ladies Taxi"
            self.taxiType="60"
        }
        
        let callFunction2 = UIAlertAction(title: "Special Needs", style: UIAlertAction.Style.default ){ _ in
            self.taxiTypetxv.textField.text="Special Needs"
            self.taxiType="90"
        }
        let dismiss = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil)
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
        otherAlert.addAction(callFunction)
        otherAlert.addAction(callFunction2)
        otherAlert.addAction(dismiss)
        
        present(otherAlert, animated: true, completion: nil)
        
    }
    
    // MARK: - Location Methods
    
    func getLocation() {
        // 1
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        // 1
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        // 2
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
            
        }
        
        // 4
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            print("Current location: \(currentLocation)")
            
            getAddress(locationInput: currentLocation)
        }
    }
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getAddress(locationInput: CLLocation) -> String {
        var address: String = ""
        
        let geoCoder = CLGeocoder()
        let location = locationInput//CLLocation(latitude: selectedLat, longitude: selectedLon)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        var string = ""
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
          
            
            self.currentLat = placemarks?[0].location?.coordinate.latitude.description ?? "0.034"
            self.currentLong = placemarks?[0].location?.coordinate.longitude.description ?? "0.045"
      
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            
            if (placeMark != nil)
            {
                // Location name
                            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                                //print(locationName)
                                
                                string += (locationName as! String) + " - "
                            }
                            
                            // Street address
                            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                                //print(street)
                            }
                            
                            // City
                            if let city = placeMark.addressDictionary!["City"] as? NSString {
                                //print(city)
                                
                                 string += (city as! String) + ","
                            }
                            
                            // Zip code
                            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                                //print(zip)
                            }
                            
                            // Country
                            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                                //print(country)
                                
                                string += " " + (country as! String)
                            }
                            if self.viewForMap.isHidden == false
                            {
                //                self.txvDestination.text = string
                                self.txtDropoffLocation.textField.text = string
                            }
                            else
                            {
                //            self.lblLocation.text = string
                                self.txtPickupLocation.textField.text = string
                            }
            }
            else
            {
                let otherAlert = UIAlertController(title: "Error", message:"Couln't find location", preferredStyle: UIAlertController.Style.alert)
                let dismiss = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                                    
                                        }
                
                
                                otherAlert.addAction(dismiss)
                self.present(otherAlert, animated: true, completion: nil)
            }
            
        })
        
        return address;
    }
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        var center = mapView.centerCoordinate
        print(center.latitude)
        print(center.longitude)
        dropOffLat=center.latitude.description
        dropOfflong=center.longitude.description
        
        let lat: Double = Double("\(dropOffLat)")!
        //21.228124
        let lon: Double = Double("\(dropOfflong)")!
        
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        getAddress(locationInput: loc)
        
    }
   
    
    // MARK: - API Calls
    
    
    func apicallHttps(){
        
        
        
         SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
//        let headers = [
//            "Content-Type": "application/x-www-form-urlencoded",
//            "User-Agent": "PostmanRuntime/7.16.3",
//            "Accept": "*/*",
//            "Cache-Control": "no-cache",
//            "Postman-Token": "baeaeed5-81d7-4620-a164-879a8b4f69e7,e8a86d34-762c-4769-a919-4dcbb6935d80",
//            "Host": "ebooking.srta.gov.ae:9101",
//            "Accept-Encoding": "gzip, deflate",
//            "Content-Length": "416",
//            "Cookie": "BIGipServerSRTA_eGov_MobileApp.app~SRTA_eGov_MobileApp_pool=181141258.20480.0000",
//            "Connection": "keep-alive",
//            "cache-control": "no-cache"
//        ]
        
        
        
//        let postData = NSMutableData(data: ("countryCode="+txtCode.textField.text!).data(using: String.Encoding.utf8)!)
//
//        postData.append(("&mobile="+txtPhoneNum.textField.text!).data(using: String.Encoding.utf8)!)
//        postData.append(("&name="+txtFullName.textField.text!).data(using: String.Encoding.utf8)!)
//        postData.append("&jobType=ADVANCE".data(using: String.Encoding.utf8)!)
//        postData.append(("&pickupAddrText="+self.txtPickupLocation.textField.text!).data(using: String.Encoding.utf8)!)
//        postData.append(("&pickupAddrLat="+currentLat).data(using: String.Encoding.utf8)!)
//        postData.append(("&pickupAddrLon="+currentLong).data(using: String.Encoding.utf8)!)
//        postData.append("&pickupPoint=".data(using: String.Encoding.utf8)!)
//        postData.append(("&dropoffAddrText="+txtDropoffLocation.textField.text!).data(using: String.Encoding.utf8)!)
//        postData.append(("&dropoffAddrLat="+dropOffLat).data(using: String.Encoding.utf8)!)
//        postData.append(("&dropoffAddrLon="+dropOfflong).data(using: String.Encoding.utf8)!)
//        postData.append("&vehicleTypeId=30".data(using: String.Encoding.utf8)!)
//        postData.append(("&driverNotes="+txvDriverNotes.textField.text!).data(using: String.Encoding.utf8)!)
//        postData.append("&notificationToken=123".data(using: String.Encoding.utf8)!)
//        postData.append("&paymentMode=2".data(using: String.Encoding.utf8)!)
//        postData.append("&recurrenceId=".data(using: String.Encoding.utf8)!)
//        postData.append("&accessToken=88e085b7-c0bc-4eba-8d6a-df068949d56a".data(using: String.Encoding.utf8)!)
//        postData.append("&pickupTime=\(self.txtPickerDateTime.textField.text!)".data(using: String.Encoding.utf8)!)
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://stg-smtshjapp.shj.ae/api/BookATaxi/HireATaxi")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = postData as Data
        
        
        var params:[String: Any] = [
        "countryCode" : txtCode.textField.text!,
        "mobile" : txtPhoneNum.textField.text!,
        "name" : txtFullName.textField.text!,
        "jobType" : "ADVANCE",
        "pickupAddrText" : self.txtPickupLocation.textField.text!,
        "pickupAddrLat" : currentLat,
        "pickupAddrLon" : currentLong,
        "dropoffAddrText" : txtDropoffLocation.textField.text!,
        "dropoffAddrLat" : dropOffLat,
        "dropoffAddrLon" : dropOfflong,
        "vehicleTypeId" : 30,
        "driverNotes" : driverNotes_txtView.text!,
        "notificationToken" : 123,
        "paymentMode" : 2 ,
        "recurrenceId": "-1",
        "accessToken": "",
        "pickupTime" : self.txtPickerDateTime.textField.text!
        ]
        
        let ulr =  URL(string: APILayer().baseURL +  "api/BookATaxiController/HireATaxi")!
        var request = URLRequest(url: ulr as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userDefaults = UserDefaults.standard
           
                  let accesstoken = userDefaults.object(forKey: "access_token") as! String
                  let authData = accesstoken
        request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
        let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                   let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                   if let json = json {
                       print(json)
                   }
                   request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        
        Alamofire.request(request as! URLRequestConvertible)
        
        //Alamofire.request(URL(string: "https://stg-smtshjapp.shj.ae/api/BookATaxi/HireATaxi")!, method: .post, parameters: params)
            .responseJSON { (response) in
            
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
                        Utility.getFreshToken {
                            (success, response) in
                            self.apicallHttps()
                        }
                    }
                    else
                    {
                            if let respJson = response.value as? NSDictionary
                            {
                                print ("responseJson: \(respJson)")
                                
                                if let msg = respJson.value(forKey: "Message") as? String{
                                    
                                    var m = "Taxi has been successfully booked - Please call 600525252 to follow-up"
                                    if Utility.isArabicSelected()
                                    {
                                        m = "تم حجز المكبة بنجاح، يرجى الاتصال ب 600525252 للمتابعة"
                                    }
                                    
                                    var t = "Book a Taxi"
                                    if Utility.isArabicSelected()
                                    {
                                        t = "احجز سيارة أجرة"
                                    }
                                     let otherAlert = UIAlertController(title: t, message: m, preferredStyle: UIAlertController.Style.alert)
                                        let dismiss = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                                            self.navigationController?.dismiss(animated: true, completion: nil)
                                                }
                        
                        
                                        otherAlert.addAction(dismiss)
                                    
                                    self.present(otherAlert, animated: true, completion: nil)
                                }
                            }
                    }
                }
            }
        }
        
        print ("x: \(txtPhoneNum.textField.text!)")
        
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                   DispatchQueue.main.async
//                   {
//                            print ("Err: \(error)")
//                           SmartSharjahShareClass.hideActivityIndicator(view: self.view)
//                    }
//            } else {
//
//                let httpResponse = response as? HTTPURLResponse
//
//                print ("status: \(httpResponse?.statusCode)")
//
//                var taxiData:[String: Any] = [:]
//                do {
//                      taxiData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
//
//                    for x in taxiData.keys{
//
//                        print ("\(x): \(taxiData[x])")
//
//
//                    }
//
//
//              } catch let error as NSError {
//                  print(error)
//              }
//
//
////                if let dd = httpResponse.
//                DispatchQueue.main.async
//                    {
//                            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
////                let otherAlert = UIAlertController(title: "Cab booked", message:"Your taxi has been succefully Booked", preferredStyle: UIAlertController.Style.alert)
//
//
//             //   let dismiss = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: )
////                let dismiss = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
////                    self.navigationController?.popToRootViewController(animated: true)
////                        }
//
//
////                otherAlert.addAction(dismiss)
////               self.present(otherAlert, animated: true, completion: nil)
//
//                }
//
//            }
//        })
        
//        dataTask.resume()
    }
  
    
    // MARK: - Vehicle Type SelectionForAPI
    func myHandler(alert: UIAlertAction){
        print("You tapped: \(alert.title)")
        if alert.title == "Normal Taxi" {
            taxiTypetxv.textField.text = "Normal Taxi"
            taxiType = "30"
        }
        else if alert.title == "Ladies Taxi"{
            taxiType = "60"
              taxiTypetxv.textField.text = "Ladies Taxi"
        }
        else if alert.title == "Special Needs"{
            taxiType = "90"
              taxiTypetxv.textField.text = "Special Needs"
        }
        else
        {
            taxiType = ""
              taxiTypetxv.textField.text = ""
        }
        
    }
    
    func resignFirstResponderForAllTextfield() {
//        txtFullName.resignFirstResponder()
//        txtPhoneNum.resignFirstResponder()
//        txtCode.resignFirstResponder()
//        txvDriverNotes.resignFirstResponder()
        
    }
    
    
  
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
        dateFormatter.dateFormat = "YYYY-MM-DDThh:mm:ss.sTZD"
        
        var dateStr = dateFormatter.string(from: self)
        return dateStr
    }

}
