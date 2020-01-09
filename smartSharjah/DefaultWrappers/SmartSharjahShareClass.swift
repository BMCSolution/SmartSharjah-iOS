//
//  SmartSharjahShareClass.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation

import UIKit

class SmartSharjahShareClass
{
    
    var activitySelectedIndex          :   Int!
    var destinationSelectedIndex       :   Int!
    
    //Activity Details Holder Arrays
    var activityTitleArr               :   [String]   = []
    var activityLocationURLArr         :   [String]   = []
    var activityUpdateDateArr          :   [String]   = []
    var activitySubtitleArr            :   [String]   = []
    var activityFeaturedArr            :   [String]   = []
    var activityImageURLArr            :   [String]   = []
    var activityLocationCordArr        :   [String]   = []
    var activityWebsiteArr             :   [String]   = []
    var activityPhoneNoArr             :   [String]   = []
    var activityEmailArr               :   [String]   = []
    var activityCategoriesArr          :   [String]   = []
    var activityTagsArr                :   [String]   = []
    var activityBudgetArr              :   [String]   = []
    var activityDestTagArr             :   [String]   = []
    var activityTerritoryTagArr        :   [String]   = []
    var activityContentTypeArr         :   [String]   = []
    var activityParentArr              :   [String]   = []
    
    //Destination Details Holder Arrays
    var destTitleArr               :   [String]   = []
    var destURLArr               :   [String]   = []
    var destSubTitleArr               :   [String]   = []
    var destDescArr               :   [String]   = []
    var destImageArr               :   [String]   = []
    var destLocationArr               :   [String]   = []
    var destCategoriesArr               :   [String]   = []
    var destTagsArr               :   [String]   = []
    var destTerritoryArr               :   [String]   = []
    var destParentArr               :   [String]   = []

    
    
    
    /*
     "title": "Sharjah City",
     "url": "http://www.visitsharjah.com/en/destinations/sharjah-city/",
     "updateDate": "2019-01-04 12:47:43",
     "subtitle": "A culture capital with a myriad of extraordinary experiences ",
     "description": "<p>Sharjah is home to acclaimed art galleries, buzzy waterfront areas and pleasure islands, creativity and excitement flow through the emirate. At the same time, the city stays true to its Islamic heritage, with a traditional, gracious and welcoming vibe.</p><p>Nestled between two lagoons, the city is a global metropolis of modern business and vibrant culture. UNESCO declared Sharjah a Culture Capital of the Arab World for its efforts to maintain and promote Arab traditions. The city shares its heritage through over 20 museums and galleries, local architecture and culture-packed leisure activities. Sharjah is a prime tourism destination with 106 hotels and hotel apartments, a variety of casual dining restaurants and indescribable experiences that take its guests through a rich and vibrant history.</p>",
     "image": "https://www.visitsharjah.com/media/1437/1sn_7385.jpg",
     "location": "Not available",
     "categories": "",
     "destinationTags": "Al Majaz Waterfront,Al Qasba,Al Noor Island,Al Montazah,Heart Of Sharjah",
     "territoryTags": "Sharjah City",
     "budget": "",
     "contentType": "destinationList",
     "parent": ""
     
     */
    
    
    static let sharedInstance   =   SmartSharjahShareClass()
    
    static func showActivityIndicator(view: UIView, targetVC: UIViewController) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = targetVC.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.tag = 1001
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    static func hideActivityIndicator(view: UIView) {
        let activityIndicator = view.viewWithTag(1001) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
