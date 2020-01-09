//
//  AccidentReporting.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 02/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AccidentReporting: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate {

   
    var location: CLLocation!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBar: NavBar!
    let locationManager = CLLocationManager()
    var currentLat = ""
    var currentLong = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "next")
        {
            var dest = segue.destination as? AccidentTypeVC
            dest?.location = self.location
        }
    }
    
    @IBAction func moveToNext(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    
    func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "تقارير الحوادث الصغرى"
            } else {
                self.navBar.title.text = "Report Minor Accident"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }

        self.mapView.showsUserLocation = true
        self.getLocation()
       
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        self.mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        
        let location = gestureReconizer.location(in: self.mapView)
        let coordinate = self.mapView.convert(location,toCoordinateFrom: self.mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        self.mapView.addAnnotation(annotation)
        
        if self.mapView != nil {
            self.mapView.setRegion(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            ), animated: true)
        }
        
        self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        self.getAddress(locationInput: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
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
        locationManager.requestLocation()
    }
    
    // 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            print("Current location: \(currentLocation)")
            
            
            if self.mapView != nil {
                self.mapView.setRegion(MKCoordinateRegion(
                    center: self.mapView.userLocation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                ), animated: true)
            }
            
            
            self.location = currentLocation
            
//            self.mapView.camera
            self.getAddress(locationInput: currentLocation)
        }
    }
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getAddress(locationInput: CLLocation) {
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
            
            self.locationLbl.text = string
//            return address;
            
        })
        
        
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
