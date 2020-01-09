//
//  arcGISVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 12/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import ArcGIS

class arcGISVC: UIViewController {

    @IBOutlet weak var mapView: AGSMapView!
    @IBOutlet weak var navBar: NavBar!
    
    private var featureTable: AGSServiceFeatureTable?
    private var featureLayer: AGSFeatureLayer?
    
    private var selectedFeatures = [AGSFeature]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        
        let map = AGSMap(basemapType: .lightGrayCanvas, latitude: 25.322327, longitude: 55.513641, levelOfDetail: 15)
        
        // assign map to the map view
        
        mapView.map = map
        mapView.touchDelegate = self
        
        /// The url of a map service layer containing sample census data of United States counties.
        
//        let statesFeatureTableTestURL = URL(string:"https://services8.arcgis.com/RNNeHJW4qeTckynv/arcgis/rest/services/SUPC_POSTAL_CODE_INFO/FeatureServer/0")!
        let statesFeatureTableURL = URL(string: "https://services7.arcgis.com/1YoEERcXGYn0wSah/ArcGIS/rest/services/SUPC_POSTAL_CODE_INFO/FeatureServer/0")!
        // create feature table using a url
        let featureTable = AGSServiceFeatureTable(url: statesFeatureTableURL)
        self.featureTable = featureTable
        
        // create feature layer using this feature table
        let featureLayer = AGSFeatureLayer(featureTable: featureTable)
        self.featureLayer = featureLayer
        // show the layer at all scales
//        self.featureLayer?.setValue("CSYbkWXAOA90ptpW", forKey: "clientId")
        featureLayer.minScale = 0
        featureLayer.maxScale = 0
        
        // set a new renderer
        let lineSymbol = AGSSimpleLineSymbol(style: .solid, color: .black, width: 1)
        let fillSymbol = AGSSimpleFillSymbol(style: .solid, color: UIColor.yellow.withAlphaComponent(0.1), outline: lineSymbol)
        featureLayer.renderer = AGSSimpleRenderer(symbol: fillSymbol)
        
        
        // add feature layer to the map
        map.operationalLayers.add(featureLayer)
        
        // center the layer
//        mapView.setViewpointCenter(AGSPoint(x: -11e6, y: 5e6, spatialReference: .webMercator()), scale: 9e7)
        
        
        
    }
    
//    @IBAction func search(_ sender: UIButton) {
////        selectFeaturesForSearchTerm("yarmook")
//    }
    
    func selectFeaturesForSearchTerm(_ searchTerm: String) {
        guard let featureLayer = featureLayer,
            let featureTable = featureTable else {
                return
        }
        
        // deselect all selected features
        if !selectedFeatures.isEmpty {
            featureLayer.unselectFeatures(selectedFeatures)
            selectedFeatures.removeAll()
        }
        
        let queryParams = AGSQueryParameters()
        queryParams.whereClause = "AREA_CODE LIKE '%3011%'"//"upper(AREA_NAME_) LIKE '%\(searchTerm.uppercased())%'"
        
//        let statsParams =
//        statsParams.whereClause = "upper(AREA_NAME_) LIKE '%\(searchTerm.uppercased())%'"
        
//        featureTable.queryStatistics(with: queryParams) { (result, err) in
//
//            print ("result:: \(result), err:: \(err)")
//        }
        
        featureTable.queryFeatures(with: queryParams) { [weak self] (result: AGSFeatureQueryResult?, error: Error?) in
            guard let self = self else {
                return
            }
            
//            print ("result: \(result?.fields)")
            
            if let error = error {
                // display the error as an alert
//                self.presentAlert(error: error)
                print ("error: \(error.localizedDescription)")
            } else if let features = result?.featureEnumerator().allObjects {
                if !features.isEmpty {
                    // display the selection
                    featureLayer.select(features)
                    
                    // zoom to the selected feature
                    self.mapView.setViewpointGeometry(features.first!.geometry!, padding: 25)
                } else {
                    
                    if let fullExtent = featureLayer.fullExtent {
                        // no matches, zoom to show everything in the layer
                        self.mapView.setViewpointGeometry(fullExtent, padding: 10)
                    }
                }
                
                // update selected features array
                self.selectedFeatures = features
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

extension arcGISVC: AGSGeoViewTouchDelegate{
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        //if the callout is not shown, show the callout with the coordinates of the tapped location
        if self.mapView.callout.isHidden {
            var t = "POSTAL CODE"
            if Utility.isArabicSelected()
            {
                t = "الرمز البريدي"
            }
            self.mapView.callout.title = t
            self.mapView.callout.isAccessoryButtonHidden = true
//            self.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
            
            //envelop
            //feature query params.
            
            
            var env = AGSEnvelope(xMin: mapPoint.x-10.0, yMin: mapPoint.y-10, xMax: mapPoint.x+10.0, yMax:mapPoint.y+10.0, spatialReference: geoView.spatialReference)
            
            var queryP = AGSQueryParameters()
            queryP.geometry = env
            queryP.maxFeatures = 1000
//            queryP.outSpatialReference = AGSSpatialReference(wkText: "POST_CODE")
            queryP.orderByFields = [AGSOrderBy.init(fieldName: "POST_CODE", sortOrder: .ascending)]
            
//            let queryParams = AGSQueryParameters()
//            queryParams.whereClause = "AREA_CODE LIKE '%3011%'"
            
            
            self.featureLayer?.selectFeatures(withQuery: queryP, mode: .new, completion: { (result, err) in
              
                if (result!.featureEnumerator().allObjects.count != 0)
                {
                    
                    var first = result!.featureEnumerator().allObjects.first!
                    
                    print ("**: \(first.attributes)")
                    
                    if let postal = first.attributes.value(forKey: "POST_CODE") as? String
                    {
                        self.mapView.callout.detail = postal
                    }
                    else
                    {
                        self.mapView.callout.detail = "Not found"
                    }
                    
                    
                    self.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                    
                    
                }
                
//                 print ("result: \(result?.featureEnumerator()), err: \(err)")
                
            })
            
//
//            self.featureLayer?.getSelectedFeatures(completion: { (result, err) in
//
//
//            })
//
            
            
//            if let featureLayer = self.mapView.map!.operationalLayers[0] as? AGSLayer
//            {
////                print ("Feature Layer: \(featureLayer.fullExtent)")
//            }
//            else
//            {
//                print ("**")
//            }
            
            
        } else {  //hide the callout
            self.mapView.callout.dismiss()
        }
    }
    
    
}
