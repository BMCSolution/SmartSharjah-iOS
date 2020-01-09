//
//  ResturantVC.swift
//  smartSharjah
//
//  Created by Noor on 27/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ResturantVC: UIViewController {
    
    @IBOutlet weak var navBar: NavBar!
    
    
    @IBOutlet weak var activityListTableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        
        
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "Arabic"
            } else {
                self.navBar.title.text = "Resturants"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        //        navBar.title.text = "Sharjah Activities"
        
        if Utility.isArabicSelected() {
            self.callSharjahActivitiesAPI(lang: "ar")
        } else {
            self.callSharjahActivitiesAPI(lang: "en")
        }
    }
    
    func clearActivityGlobalArr()
    {
        SmartSharjahShareClass.sharedInstance.activityTitleArr          = []
        SmartSharjahShareClass.sharedInstance.activityLocationURLArr    = []
        SmartSharjahShareClass.sharedInstance.activityUpdateDateArr     = []
        SmartSharjahShareClass.sharedInstance.activitySubtitleArr       = []
        SmartSharjahShareClass.sharedInstance.activityFeaturedArr       = []
        SmartSharjahShareClass.sharedInstance.activityImageURLArr       = []
        SmartSharjahShareClass.sharedInstance.activityLocationCordArr   = []
        SmartSharjahShareClass.sharedInstance.activityWebsiteArr        = []
        SmartSharjahShareClass.sharedInstance.activityPhoneNoArr        = []
        SmartSharjahShareClass.sharedInstance.activityEmailArr          = []
        SmartSharjahShareClass.sharedInstance.activityCategoriesArr     = []
        SmartSharjahShareClass.sharedInstance.activityTagsArr           = []
        SmartSharjahShareClass.sharedInstance.activityBudgetArr         = []
        SmartSharjahShareClass.sharedInstance.activityDestTagArr        = []
        SmartSharjahShareClass.sharedInstance.activityTerritoryTagArr   = []
        SmartSharjahShareClass.sharedInstance.activityContentTypeArr    = []
        SmartSharjahShareClass.sharedInstance.activityParentArr         = []
    }
    
    func callSharjahActivitiesAPI(lang: String)
    {
        
        self.clearActivityGlobalArr()
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        // string URL = "https://www.visitsharjah.com/sctdalogin/surface/Api/Activities?lang=" + lang
        //self.clearADVAlues()
        let webURL = "https://www.visitsharjah.com/sctdalogin/surface/Api/Activities?lang="+lang; Alamofire.request(webURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                if let activitiesListApiObj = json["result"].arrayValue as [JSON]?
                {
                    if(activitiesListApiObj.count > 0)
                    {
                        print(activitiesListApiObj.count)
                        
                        for indexActItem in 0...activitiesListApiObj.count-1
                        {
                            
                            SmartSharjahShareClass.sharedInstance.activityTitleArr.append(activitiesListApiObj[indexActItem]["title"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityLocationURLArr.append(activitiesListApiObj[indexActItem]["url"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityUpdateDateArr.append(activitiesListApiObj[indexActItem]["updateDate"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activitySubtitleArr.append(activitiesListApiObj[indexActItem]["subtitle"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityFeaturedArr.append(activitiesListApiObj[indexActItem]["featured"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityImageURLArr.append(activitiesListApiObj[indexActItem]["image"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityLocationCordArr.append(activitiesListApiObj[indexActItem]["location"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityWebsiteArr.append(activitiesListApiObj[indexActItem]["website"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityPhoneNoArr.append(activitiesListApiObj[indexActItem]["phone"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityEmailArr.append(activitiesListApiObj[indexActItem]["email"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityCategoriesArr.append(activitiesListApiObj[indexActItem]["categories"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityTagsArr.append(activitiesListApiObj[indexActItem]["typeTags"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityBudgetArr.append(activitiesListApiObj[indexActItem]["budget"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityDestTagArr.append(activitiesListApiObj[indexActItem]["destinationTags"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityTerritoryTagArr.append(activitiesListApiObj[indexActItem]["territoryTags"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityContentTypeArr.append(activitiesListApiObj[indexActItem]["contentType"].stringValue)
                            SmartSharjahShareClass.sharedInstance.activityParentArr.append(activitiesListApiObj[indexActItem]["parent"].stringValue)
                            
                            self.activityListTableViewOutlet.reloadData()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        })
                        
                    }
                    else
                    {
                        
                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        SetDefaultWrappers().showAlert(info:"No Activities found", viewController: self)
                        self.clearActivityGlobalArr()
                        //self.AccountDetailsSearchFieldOutlet.text = ""
                        //self.AccountDetailsListTableOutlet.reloadData()
                        
                    }
                }
                
            case .failure(let error):
                print(error)
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                self.clearActivityGlobalArr()
                SetDefaultWrappers().showAlert(info:"Unexpected Error", viewController: self)
            }
        }
        
    }
}

extension SharjahActivities: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 4
        return SmartSharjahShareClass.sharedInstance.activityTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let actCell = tableView.dequeueReusableCell(withIdentifier: "activityCellID", for: indexPath) as! ActListTableViewCell
        
        if (SmartSharjahShareClass.sharedInstance.activityImageURLArr[indexPath.row] == "")
        {
            actCell.imageView?.image = UIImage(named: "noImageAsset")
        }
        else
        {
            let imgURL       =   URL(string: SmartSharjahShareClass.sharedInstance.activityImageURLArr[indexPath.row])
            
            actCell.activityImageOutlet.kf.indicatorType = .activity
            actCell.activityImageOutlet.kf.setImage(with: imgURL)
        }
        
        if(SmartSharjahShareClass.sharedInstance.activityFeaturedArr[indexPath.row] == "False")
        {
            //actCell.activityCellHolderViewOutlet.layer.borderColor = (UIColor.red as! CGColor)
            //actCell.activityCellHolderViewOutlet.layer.borderWidth = 1.5
        }
        actCell.activityTitleLblOutlet.text = SmartSharjahShareClass.sharedInstance.activityTitleArr[indexPath.row]
        actCell.activitySubTitleLblOutlet.text = SmartSharjahShareClass.sharedInstance.activitySubtitleArr[indexPath.row]
        
        return actCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SmartSharjahShareClass.sharedInstance.activitySelectedIndex = indexPath.row
        if(SmartSharjahShareClass.sharedInstance.activitySelectedIndex != nil)
        {
            self.performSegue(withIdentifier: "ActivityDetailSegue", sender: self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

