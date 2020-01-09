//
//  PostalCodesVC.swift
//  smartSharjah
//
//  Created by Usman on 09/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import ArcGIS
import Moya

class PostalCodesVC: UIViewController {
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var mapView: AGSMapView!
    
    var featureLayer: AGSFeatureLayer!
    
    private var reverseGeocodeParameters: AGSReverseGeocodeParameters!
    private var cancelable: AGSCancelable!
    private let locatorURL = "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer"
    
    private typealias Category = (title: String, color: UIColor)
    private let categories: [Category] = [("Coffee shop", .brown), ("Gas station", .orange), ("Food", .cyan), ("Hotel", .blue), ("Neighborhood", .black), ("Parks and Outdoors", .green)]
    
    var url = URL(string: "https://services7.arcgis.com/1YoEERcXGYn0wSah/ArcGIS/rest/services/SUPC_POSTAL_CODE_INFO/FeatureServer")!
    private let locatorTask = AGSLocatorTask(url: URL(string: "https://services7.arcgis.com/1YoEERcXGYn0wSah/ArcGIS/rest/services/SUPC_POSTAL_CODE_INFO/FeatureServer")!)
    
//    private let locatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    private var cancelableGeocodeTask: AGSCancelable?
    
    private let graphicsOverlay = AGSGraphicsOverlay()
//    private var isNavigatingObserver: NSKeyValueObservation?
    
    private struct AttributeKeys {
        static let placeAddress = "Place_addr"
        static let placeName = "PlaceName"
        static let postal = "Postal"
        static let postalCode = "POST_CODE"
        
    }
    
    private func findPlaces(forCategory category: Category) {
        guard let visibleArea = mapView.visibleArea else { return }
        
        mapView.callout.dismiss()
        graphicsOverlay.graphics.removeAllObjects()
        cancelableGeocodeTask?.cancel()
        
        
        let geocodeParameters = AGSGeocodeParameters()
        geocodeParameters.preferredSearchLocation = visibleArea.extent.center
        geocodeParameters.maxResults = 1000
        geocodeParameters.resultAttributeNames.append(contentsOf: [AttributeKeys.placeName, AttributeKeys.placeAddress, AttributeKeys.postal, AttributeKeys.postalCode])
        
        cancelableGeocodeTask = locatorTask.geocode(withSearchText: category.title, parameters: geocodeParameters) { [weak self] (results: [AGSGeocodeResult]?, error: Error?) -> Void in
            
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print("geocode error", error!.localizedDescription)
                return
            }
            
            guard let results = results, results.count > 0 else {
                print("No places found for category", category.title)
                return
            }
            
            for result in results {
                let placeSymbol = AGSSimpleMarkerSymbol(style: .circle, color: category.color, size: 10.0)
                placeSymbol.outline = AGSSimpleLineSymbol(style: .solid, color: .white, width: 2)
                let graphic = AGSGraphic(geometry: result.displayLocation, symbol: placeSymbol, attributes: result.attributes as [String : AnyObject]?)
                strongSelf.graphicsOverlay.graphics.add(graphic)
                
                var attr = result.attributes!
                print ("Attr: \(attr)")
                
            }
        }
        
        
    }
    
    
    
    
    var provider = MoyaProvider<RESTApi>()
    
//    let geocoder:AGSLocatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected(){
                self.navBar.title.text = "احصل على الرمز البريدي"
            }
            else
            {
                self.navBar.title.text = "Find Postal Code"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        self.mapView.map = AGSMap(basemapType: .lightGrayCanvas, latitude: 25.322327, longitude: 55.513641, levelOfDetail: 15)
        
        // *** ADD ***
        let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: false)
        
        let item = AGSPortalItem(portal: portal, itemID: "ec8feb4943e94b3f92670d94276dc311")
        
        let layer = AGSFeatureLayer(item: item, layerID: 0)
        
        // Create a shapefile feature table from a named bundle resource.
        let shapefileTable = AGSShapefileFeatureTable(name: "Public_Art")
        
        // Create a feature layer for the shapefile feature table.
        featureLayer = AGSFeatureLayer(featureTable: shapefileTable)
        
        // Add the layer to the map.
        mapView.map!.operationalLayers.add(featureLayer)
        
        
//        mapView.map!.operationalLayers.add(layer)
        
        
        self.mapView.touchDelegate = self
        
        //add the graphics overlay
//        self.mapView.graphicsOverlays.add(self.graphicsOverlay)
        //initialize locator task
        
        //initialize parameters
//        self.reverseGeocodeParameters = AGSReverseGeocodeParameters()
//        self.reverseGeocodeParameters.maxResults = 100
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func reverseGeocode(_ point: AGSPoint) {
        //cancel previous request
        if self.cancelable != nil {
            self.cancelable.cancel()
        }
        
        //hide the callout
        self.mapView.callout.dismiss()
        
        //remove already existing graphics
        self.graphicsOverlay.graphics.removeAllObjects()
        
        //normalize point
        let normalizedPoint = AGSGeometryEngine.normalizeCentralMeridian(of: point) as! AGSPoint
        
        let graphic = self.graphicForPoint(normalizedPoint)
        self.graphicsOverlay.graphics.add(graphic)
        
        //reverse geocode
        self.cancelable = self.locatorTask.reverseGeocode(withLocation: normalizedPoint, parameters: self.reverseGeocodeParameters) { [weak self] (results: [AGSGeocodeResult]?, error: Error?) in
            if let error = error as NSError? {
                if error.code != NSUserCancelledError { //user canceled error
                    print("error: \(error)")
                    //                       self?.presentAlert(error: error)
                }
            } else if let result = results?.first {
                graphic.attributes.addEntries(from: result.attributes!)
                self?.showCalloutForGraphic(graphic, tapLocation: normalizedPoint)
                return
            } else {
                print("No Address found")
                //                   self?.presentAlert(message: "No address found")
            }
            self?.graphicsOverlay.graphics.remove(graphic)
        }
    }
    
    //method returns a graphic object for the specified point and attributes
    private func graphicForPoint(_ point: AGSPoint) -> AGSGraphic {
        let markerImage = UIImage(named: "icon_mapMarker")!
        let symbol = AGSPictureMarkerSymbol(image: markerImage)
        symbol.leaderOffsetY = markerImage.size.height + 20
        symbol.offsetY = markerImage.size.height + 20
        let graphic = AGSGraphic(geometry: point, symbol: symbol, attributes: [String: AnyObject]())
        return graphic
    }
    
    //method to show callout for the graphic
    //it gets the attributes from the graphic and populates the title
    //and detail for the callout
    private func showCalloutForGraphic(_ graphic:AGSGraphic, tapLocation:AGSPoint) {
        self.mapView.callout.title = graphic.attributes["PlaceName"] as? String ?? "Unknown"
        self.mapView.callout.detail = graphic.attributes["Place_addr"] as? String ?? "no address provided"
        self.mapView.callout.isAccessoryButtonHidden = true
        self.mapView.callout.show(for: graphic, tapLocation: tapLocation, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func setupMap() {
        let itemID = "41281c51f9de45edaf1c8ed44bb10e30"
        let portal = AGSPortal(url: URL(string: "https://www.arcgis.com")!, loginRequired: false)
        let portalItem: AGSPortalItem = AGSPortalItem(portal: portal, itemID: itemID)
        
        mapView.map = AGSMap(item: portalItem)
    }
    

    func convertLatLongToZip(latitude:Double,longitude:Double) -> String {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        var str = "Not Found"
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            if let locationName = placeMark.location {
                print("locationName: \(locationName)")
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print("street: \(street)")
//                print(street)
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                print("city: \(city)")
//                print(city)
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                print("zip: \(zip)")
                str = zip
            }
            // Country
            if let country = placeMark.country {
                print("country: \(country)")
                print(country)
            }
        })
        
        return str
        
    }

    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            if error != nil
            {
                
            }
            var placeMark: CLPlacemark!
            
            placeMark = placemarks?[0]
            
            print("Placemarks: \(placeMark.areasOfInterest?.count)")
            // Location name
            //            if let locationName = placeMark.location {
            //                print("location name: \(locationName)")
            //            }
            //            // Street address
            //            if let street = placeMark.thoroughfare {
            //                print(street)
            //            }
            // City
            //            if let city = placeMark.subAdministrativeArea {
            //                print(city)
            //            }
            //            // Zip code
            //            if let zip = placeMark.isoCountryCode {
            //                print(zip)
            //            }
            
            // Postal code
            if let post = placeMark.postalCode {
                print("Postal codes\(post)")
            }
            
            // Country
            //            if let country = placeMark.country {
            //                print(country)
            //            }
        })
        
    }
}
extension PostalCodesVC: AGSGeoViewTouchDelegate{
    
    func geoView(_ geoView: AGSGeoView, didTouchUpAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        print("Did touch called...")
    }
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        
        
        
        
//        self.findPlaces(forCategory: categories.first!  )
//
//
//        self.mapView.callout.dismiss()
//        self.mapView.identify(self.graphicsOverlay, screenPoint: screenPoint, tolerance: 10, returnPopupsOnly: false, maximumResults: 2) { (result: AGSIdentifyGraphicsOverlayResult) -> Void in
//            guard result.error == nil else {
//                print(result.error!)
//                return
//            }
//            if let graphic = result.graphics.first {
//                self.showCalloutForGraphic(graphic, tapLocation: mapPoint)
//            }
//            else{
//                print ("First is Null")
//            }
//        }
        
        
        //        print("mappoint: \(mapPoint.toCLLocationCoordinate2D())")
        
//            self.reverseGeocode(mapPoint)
        
//        let location = mapPoint.toCLLocationCoordinate2D()
//        let lat = location.latitude
//        let lng = location.longitude
//        var ppp = ""
//
//
//        self.mapView.callout.dismiss()
//        self.mapView.identify(self.graphicsOverlay, screenPoint: screenPoint, tolerance: 10, returnPopupsOnly: false, maximumResults: 2) { (result: AGSIdentifyGraphicsOverlayResult) -> Void in
//            guard result.error == nil else {
//                print(result.error!)
//                return
//            }
//            if let graphic = result.graphics.first {
//                self.showCalloutForGraphic(graphic, tapLocation: mapPoint)
//            }
//            else
//            {
//                    print ("First is nil")
//            }
//        }
        
//        provider.rx.request(.arcGIS(lat: "\(lat)", lng: "\(lng)" )).subscribe(onSuccess:
//            { (response) in
//
//            do {
//
//                if let json = try response.mapJSON() as? NSDictionary
//                {
//                    print("Success Response:\(json) ")
//                    if let dataJson = json.value(forKey: "candidates") as? [NSDictionary]{
//
//                        if (dataJson.count > 0)
//                        {
//                            for x:NSDictionary in dataJson{
//                                if let attr = x.value(forKey: "attributes") as? NSDictionary{
//
//                                    if let postal = attr.value(forKey: "Postal") as? String{
//                                        print ("*Postal: \(postal)")
//                                        if (postal != "")
//                                        {
//                                            ppp = postal
//
//                                            let alert = UIAlertController(title: "Postal Code Found", message: "\(postal)", preferredStyle: .alert)
//                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
//                                                alert.dismiss(animated: true)
//
//                                                }))
//                                            self.present(alert, animated: true)
//                                            break
//                                        }
//                                    }
//
////                                    if let postal = attr.value(forKey: "StreetAddress") as? String{
////                                        print ("*StreetAddress: \(postal)")
////                                    }
//
//                                }
//                            }
//
//                            if (ppp == "")
//                            {
//                                let alert = UIAlertController(title: "Postal Code NOT Found", message: "Unable to find Postal Code for this location", preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
//                                    alert.dismiss(animated: true)
//
//                                }))
//                                self.present(alert, animated: true)
//                            }
//
//                        }
//
//                    }
//                    else
//                    {
//                        print("JSON Array conversion error....")
//
//                    }
//                }
//
//
//
//            }
//            catch{
//
//                print("failed response:\(error)")
//            }
//
//
//
//        }){(error) in
//
//            print("Request Failed: \(error)")
//        }
        
//        print(self.convertLatLongToZip(latitude: location.latitude, longitude: location.longitude))
//
//        self.geocoder.reverseGeocode(withLocation: mapPoint) { (results, err) in
//
//            print ("Error: \(err)")
//            print ("Results: \(results)")
//
//            print ("Result: \(results!.first as? AGSGeocodeResult)")
//            print (results!.first?.attributes)
//            print (results!.first?.displayLocation)
//            print (results!.first?.extent)
//            print (results!.first?.inputLocation)
//            print (results!.first?.label)
//            print (results!.first?.routeLocation)
//            print (results!.first?.score)
//
//
//
//
////            guard let firstResult = results?.first, let extent = firstResult.extent else {
////                let alert = UIAlertController(title: "Nothing found",
////                                              message: "No results found for this location",
////                    preferredStyle: .alert)
////                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
////                    alert.dismiss(animated: true)
////                }))
////                self.present(alert, animated: true)
////                return
////            }
//
//
//        }
        
//        self.mapView.identifyLayers(atScreenPoint: screenPoint, tolerance: 10, returnPopupsOnly: true) { (results, error) in
//            guard error == nil else{
//                print("Error: \(error?.localizedDescription)")
//                return
//            }
//
//            if let firstfeature = results?.first?.geoElements.first as? AGSFeature
//            {
//                self.mapView.callout.title = firstfeature.attributes.value(forKey: "Name") as? String ?? "Unknown"
//                self.mapView.callout.detail = firstfeature.attributes.value(forKey: "Text_For_Short_Desc_Field") as? String ?? "Unknown"
//                self.mapView.callout.show(for: firstfeature, tapLocation: mapPoint, animated: true)
//            }
//            else
//            {
//                print("No feature found")
//            }
//        }
        
        //        let lat = mapPoint.toCLLocationCoordinate2D().latitude
        //        let long = mapPoint.toCLLocationCoordinate2D().longitude
        //        self.convertLatLongToAddress(latitude: lat, longitude: long)
        
        
        
        
        
    }
    
}

