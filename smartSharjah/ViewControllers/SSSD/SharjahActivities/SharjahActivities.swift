//
//  SharjahActivities.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SharjahActivities: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navBar: NavBar!
    
    var activitySelectedIndex          :   Int!
    
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
    
    @IBOutlet weak var activityListTableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "الأنشطة"
            } else {
                self.navBar.title.text = "Activities"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
//        navBar.title.text = "Sharjah Activities"
        
        if Utility.isArabicSelected() {
             (self.searchBar.value(forKey: "cancelButton") as! UIButton).setTitle("إلغاء", for: .normal)
            self.callSharjahActivitiesAPI(lang: "ar")
        } else {
            (self.searchBar.value(forKey: "cancelButton") as! UIButton).setTitle("Cancel", for: .normal)
            self.callSharjahActivitiesAPI(lang: "en")
        }
        
        self.searchBar.delegate = self
        self.activityListTableViewOutlet.keyboardDismissMode = .onDrag
    }
    
    func resetData() {
        
        
        
        self.activityTitleArr = SmartSharjahShareClass.sharedInstance.activityTitleArr
        
        self.activityLocationURLArr = SmartSharjahShareClass.sharedInstance.activityLocationURLArr
        
        self.activityUpdateDateArr = SmartSharjahShareClass.sharedInstance.activityUpdateDateArr
        
        self.activitySubtitleArr = SmartSharjahShareClass.sharedInstance.activitySubtitleArr
        
        self.activityFeaturedArr = SmartSharjahShareClass.sharedInstance.activityFeaturedArr
        
        self.activityImageURLArr = SmartSharjahShareClass.sharedInstance.activityImageURLArr
        
        self.activityLocationCordArr = SmartSharjahShareClass.sharedInstance.activityLocationCordArr
        
        self.activityWebsiteArr = SmartSharjahShareClass.sharedInstance.activityWebsiteArr
        
        self.activityPhoneNoArr = SmartSharjahShareClass.sharedInstance.activityPhoneNoArr
        
        self.activityEmailArr = SmartSharjahShareClass.sharedInstance.activityEmailArr
        
        self.activityCategoriesArr = SmartSharjahShareClass.sharedInstance.activityCategoriesArr
        
        self.activityTagsArr = SmartSharjahShareClass.sharedInstance.activityTagsArr
        
        self.activityBudgetArr = SmartSharjahShareClass.sharedInstance.activityBudgetArr
        
        self.activityDestTagArr = SmartSharjahShareClass.sharedInstance.activityDestTagArr
        
        self.activityTerritoryTagArr = SmartSharjahShareClass.sharedInstance.activityTerritoryTagArr
        
        self.activityContentTypeArr = SmartSharjahShareClass.sharedInstance.activityContentTypeArr
        
        self.activityParentArr = SmartSharjahShareClass.sharedInstance.activityParentArr
        
        self.activityListTableViewOutlet.reloadData()
        
    }
    
    
    func clearLocal()
    {
        self.activityTitleArr          = []
        self.activityLocationURLArr    = []
        self.activityUpdateDateArr     = []
        self.activitySubtitleArr       = []
        self.activityFeaturedArr       = []
        self.activityImageURLArr       = []
        self.activityLocationCordArr   = []
        self.activityWebsiteArr        = []
        self.activityPhoneNoArr        = []
        self.activityEmailArr          = []
        self.activityCategoriesArr     = []
        self.activityTagsArr           = []
        self.activityBudgetArr         = []
        self.activityDestTagArr        = []
        self.activityTerritoryTagArr   = []
        self.activityContentTypeArr    = []
        self.activityParentArr         = []
        
        self.activityListTableViewOutlet.reloadData()
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
        
        self.activityTitleArr          = []
        self.activityLocationURLArr    = []
        self.activityUpdateDateArr     = []
        self.activitySubtitleArr       = []
        self.activityFeaturedArr       = []
        self.activityImageURLArr       = []
        self.activityLocationCordArr   = []
        self.activityWebsiteArr        = []
        self.activityPhoneNoArr        = []
        self.activityEmailArr          = []
        self.activityCategoriesArr     = []
        self.activityTagsArr           = []
        self.activityBudgetArr         = []
        self.activityDestTagArr        = []
        self.activityTerritoryTagArr   = []
        self.activityContentTypeArr    = []
        self.activityParentArr         = []
        
        self.activityListTableViewOutlet.reloadData()
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
                                self.activityTitleArr.append(activitiesListApiObj[indexActItem]["title"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityLocationURLArr.append(activitiesListApiObj[indexActItem]["url"].stringValue)
                                self.activityLocationURLArr.append(activitiesListApiObj[indexActItem]["url"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityUpdateDateArr.append(activitiesListApiObj[indexActItem]["updateDate"].stringValue)
                                self.activityUpdateDateArr.append(activitiesListApiObj[indexActItem]["updateDate"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activitySubtitleArr.append(activitiesListApiObj[indexActItem]["subtitle"].stringValue)
                                self.activitySubtitleArr.append(activitiesListApiObj[indexActItem]["subtitle"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityFeaturedArr.append(activitiesListApiObj[indexActItem]["featured"].stringValue)
                                self.activityFeaturedArr.append(activitiesListApiObj[indexActItem]["featured"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityImageURLArr.append(activitiesListApiObj[indexActItem]["image"].stringValue)
                                self.activityImageURLArr.append(activitiesListApiObj[indexActItem]["image"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityLocationCordArr.append(activitiesListApiObj[indexActItem]["location"].stringValue)
                                self.activityLocationCordArr.append(activitiesListApiObj[indexActItem]["location"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityWebsiteArr.append(activitiesListApiObj[indexActItem]["website"].stringValue)
                                self.activityWebsiteArr.append(activitiesListApiObj[indexActItem]["website"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityPhoneNoArr.append(activitiesListApiObj[indexActItem]["phone"].stringValue)
                                self.activityPhoneNoArr.append(activitiesListApiObj[indexActItem]["phone"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityEmailArr.append(activitiesListApiObj[indexActItem]["email"].stringValue)
                                self.activityEmailArr.append(activitiesListApiObj[indexActItem]["email"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityCategoriesArr.append(activitiesListApiObj[indexActItem]["categories"].stringValue)
                                self.activityCategoriesArr.append(activitiesListApiObj[indexActItem]["categories"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityTagsArr.append(activitiesListApiObj[indexActItem]["typeTags"].stringValue)
                                self.activityTagsArr.append(activitiesListApiObj[indexActItem]["typeTags"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityBudgetArr.append(activitiesListApiObj[indexActItem]["budget"].stringValue)
                                self.activityBudgetArr.append(activitiesListApiObj[indexActItem]["budget"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityDestTagArr.append(activitiesListApiObj[indexActItem]["destinationTags"].stringValue)
                                self.activityDestTagArr.append(activitiesListApiObj[indexActItem]["destinationTags"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityTerritoryTagArr.append(activitiesListApiObj[indexActItem]["territoryTags"].stringValue)
                                self.activityTerritoryTagArr.append(activitiesListApiObj[indexActItem]["territoryTags"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityContentTypeArr.append(activitiesListApiObj[indexActItem]["contentType"].stringValue)
                                self.activityContentTypeArr.append(activitiesListApiObj[indexActItem]["contentType"].stringValue)
                                SmartSharjahShareClass.sharedInstance.activityParentArr.append(activitiesListApiObj[indexActItem]["parent"].stringValue)
                                self.activityParentArr.append(activitiesListApiObj[indexActItem]["parent"].stringValue)

                                
                            }
                            self.resetData()
//                            self.activityListTableViewOutlet.reloadData()
                            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
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
        return self.activityTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let actCell = tableView.dequeueReusableCell(withIdentifier: "activityCellID", for: indexPath) as! ActListTableViewCell
        
        if (self.activityImageURLArr[indexPath.row] == "")
        {
            actCell.imageView?.image = UIImage(named: "noImageAsset")
        }
        else
        {
            let imgURL = URL(string: "\(self.activityImageURLArr[indexPath.row])?mode=crop&width=320&height=240")
            
            print ("*LoadingURL: \(self.activityImageURLArr[indexPath.row])?mode=crop&width=320&height=240")
//            "\(self.activityImageURLArr[indexPath.row])?mode=crop&width=320&height=240")
            actCell.activityImageOutlet.kf.indicatorType = .activity
            actCell.activityImageOutlet.kf.setImage(with: imgURL)
        }
        
        if(self.activityFeaturedArr[indexPath.row] == "False")
        {
            //actCell.activityCellHolderViewOutlet.layer.borderColor = (UIColor.red as! CGColor)
            //actCell.activityCellHolderViewOutlet.layer.borderWidth = 1.5
        }
        actCell.activityTitleLblOutlet.text = self.activityTitleArr[indexPath.row]
        actCell.activitySubTitleLblOutlet.text = self.activitySubtitleArr[indexPath.row]
        
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

extension SharjahActivities: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           self.resetData()
            self.searchBar.text = ""
           self.searchBar.endEditing(true)
       }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if (searchBar.text != "")
        {
            
            self.clearLocal()
            
            for (index, x) in SmartSharjahShareClass.sharedInstance.activityTitleArr.enumerated(){
                
                if (x.lowercased().contains(searchBar.text!.lowercased()))
                {
                    print ("Contains: \(x) YES contains \(searchBar.text!)")
                    
                    
                    self.activityTitleArr.append(SmartSharjahShareClass.sharedInstance.activityTitleArr[index])
                    
                    self.activityLocationURLArr.append(SmartSharjahShareClass.sharedInstance.activityLocationURLArr[index])
                    
                    self.activityUpdateDateArr.append(SmartSharjahShareClass.sharedInstance.activityUpdateDateArr[index])
                    
                    self.activitySubtitleArr.append(SmartSharjahShareClass.sharedInstance.activitySubtitleArr[index])
                    
                    self.activityFeaturedArr.append(SmartSharjahShareClass.sharedInstance.activityFeaturedArr[index])
                    
                    self.activityImageURLArr.append(SmartSharjahShareClass.sharedInstance.activityImageURLArr[index])
                    
                    self.activityLocationCordArr.append(SmartSharjahShareClass.sharedInstance.activityLocationCordArr[index])
                    
                    self.activityWebsiteArr.append(SmartSharjahShareClass.sharedInstance.activityWebsiteArr[index])
                    
                    self.activityPhoneNoArr.append(SmartSharjahShareClass.sharedInstance.activityPhoneNoArr[index])
                    
                    self.activityEmailArr.append(SmartSharjahShareClass.sharedInstance.activityEmailArr[index])
                    
                    self.activityCategoriesArr.append(SmartSharjahShareClass.sharedInstance.activityCategoriesArr[index])
                    
                    self.activityTagsArr.append(SmartSharjahShareClass.sharedInstance.activityTagsArr[index])
                    
                    self.activityBudgetArr.append(SmartSharjahShareClass.sharedInstance.activityBudgetArr[index])
                    
                    self.activityDestTagArr.append(SmartSharjahShareClass.sharedInstance.activityDestTagArr[index])
                    
                    self.activityTerritoryTagArr.append(SmartSharjahShareClass.sharedInstance.activityTerritoryTagArr[index])
                    
                    self.activityContentTypeArr.append(SmartSharjahShareClass.sharedInstance.activityContentTypeArr[index])
                    
                    self.activityParentArr.append(SmartSharjahShareClass.sharedInstance.activityParentArr[index])
                    
                    
                    self.activityListTableViewOutlet.reloadData()
                    
                }
                else
                {
                    print ("Skipped : \(SmartSharjahShareClass.sharedInstance.activityTitleArr[index])")
                }
                
                
            }
        }
        else
        {
            self.resetData()
        }
        
    }
    
}
