//
//  SharjahDestinations.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SharjahDestinations: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var navBar: NavBar!
    
    @IBOutlet weak var ShjDestTableViewOutlet: UITableView!
    
    
    var destTitleArr: [String] = []
    var destURLArr : [String]   = []
    var destSubTitleArr: [String]  = []
    var destDescArr: [String]  = []
    var destImageArr: [String]  = []
    var destLocationArr: [String] = []
    var destCategoriesArr: [String] = []
    var destTagsArr: [String]   = []
    var destTerritoryArr: [String]  = []
    var destParentArr: [String] = []

    var title_dest = ""
    var image_dest = ""
    var teritory_dest = ""
    var tags_dest = ""
    var subtitle_dest = ""
    var cat_dest = ""
    var desc_dest = ""

    
    override func viewDidLoad() {
        
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "الوجهات السياحية"
            } else {
                navBar.title.text = "Destinations"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        if Utility.isArabicSelected() {
             (self.searchBar.value(forKey: "cancelButton") as! UIButton).setTitle("إلغاء", for: .normal)
            self.callSharjahDestinationsAPI(lang: "ar")
        } else {
             (self.searchBar.value(forKey: "cancelButton") as! UIButton).setTitle("Cancel", for: .normal)
            self.callSharjahDestinationsAPI(lang: "en")
        }
        self.searchBar.delegate = self
       self.ShjDestTableViewOutlet.keyboardDismissMode = .onDrag
    }

    func clearDestGlobalArr()
    {
        SmartSharjahShareClass.sharedInstance.destTitleArr      = []
        SmartSharjahShareClass.sharedInstance.destURLArr        = []
        SmartSharjahShareClass.sharedInstance.destSubTitleArr   = []
        SmartSharjahShareClass.sharedInstance.destDescArr       = []
        SmartSharjahShareClass.sharedInstance.destImageArr      = []
        SmartSharjahShareClass.sharedInstance.destLocationArr   = []
        SmartSharjahShareClass.sharedInstance.destCategoriesArr = []
        SmartSharjahShareClass.sharedInstance.destTagsArr       = []
        SmartSharjahShareClass.sharedInstance.destTerritoryArr  = []
        SmartSharjahShareClass.sharedInstance.destParentArr     = []
    }
    
    func resetData()
    {
       destTitleArr = SmartSharjahShareClass.sharedInstance.destTitleArr
       destURLArr = SmartSharjahShareClass.sharedInstance.destURLArr
       destSubTitleArr  = SmartSharjahShareClass.sharedInstance.destSubTitleArr
       destDescArr =  SmartSharjahShareClass.sharedInstance.destDescArr
       destImageArr = SmartSharjahShareClass.sharedInstance.destImageArr
       destLocationArr = SmartSharjahShareClass.sharedInstance.destLocationArr
       destCategoriesArr = SmartSharjahShareClass.sharedInstance.destCategoriesArr
       destTagsArr =  SmartSharjahShareClass.sharedInstance.destTagsArr
       destTerritoryArr =  SmartSharjahShareClass.sharedInstance.destTerritoryArr
       destParentArr =  SmartSharjahShareClass.sharedInstance.destParentArr
      
        self.ShjDestTableViewOutlet.reloadData()
    }
    
    
    func clearLocal()
    {
        destTitleArr = []
        destURLArr = []
        destSubTitleArr  = []
        destDescArr = []
        destImageArr = []
        destLocationArr = []
        destCategoriesArr = []
        destTagsArr = []
        destTerritoryArr = []
        destParentArr = []
        
        self.ShjDestTableViewOutlet.reloadData()
    }
    
    func callSharjahDestinationsAPI(lang: String)
    {
        
        self.clearDestGlobalArr()
        SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        let webURL = "https://www.visitsharjah.com/sctdalogin/surface/Api/Destinations?lang="+lang; Alamofire.request(webURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                if let destListApiObj = json["result"].arrayValue as [JSON]?
                {
                    if(destListApiObj.count > 0)
                    {
                        print(destListApiObj.count)
                        
                        for indexDestItem in 0...destListApiObj.count-1
                        {
                            
                            SmartSharjahShareClass.sharedInstance.destTitleArr.append(destListApiObj[indexDestItem]["title"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destURLArr.append(destListApiObj[indexDestItem]["url"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destSubTitleArr.append(destListApiObj[indexDestItem]["subtitle"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destDescArr.append(destListApiObj[indexDestItem]["description"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destImageArr.append(destListApiObj[indexDestItem]["image"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destLocationArr.append(destListApiObj[indexDestItem]["location"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destCategoriesArr.append(destListApiObj[indexDestItem]["categories"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destTagsArr.append(destListApiObj[indexDestItem]["destinationTags"].stringValue)
                            SmartSharjahShareClass.sharedInstance.destTerritoryArr.append(destListApiObj[indexDestItem]["territoryTags"].stringValue)
                        
                            
                        }
                        self.resetData()
//                        self.ShjDestTableViewOutlet.reloadData()
                        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        })
                    }
                    else
                    {
                        SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                        SetDefaultWrappers().showAlert(info:"No Destinations found", viewController: self)
                        self.clearDestGlobalArr()
                        self.ShjDestTableViewOutlet.reloadData()
                    }
                }
                
            case .failure(let error):
                print(error)
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                self.clearDestGlobalArr()
                SetDefaultWrappers().showAlert(info:"Unexpected Error", viewController: self)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DestDetailSegue"
        {
            let dest = segue.destination as! SHJDestDetailVC
            dest.title_dest = self.title_dest
            dest.image_dest = self.image_dest
            dest.teritory_dest = self.teritory_dest
            dest.tags_dest = self.tags_dest
            dest.subtitle_dest = self.subtitle_dest
            dest.cat_dest = self.cat_dest
            dest.desc_dest = self.desc_dest
            
        }
    }
}


extension SharjahDestinations: UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 4
        return self.destTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let destCell = tableView.dequeueReusableCell(withIdentifier: "destinationCellID", for: indexPath) as! ShjDestTableViewCell
        
        if (self.destImageArr[indexPath.row] == "")
        {
            destCell.destImgOutlet?.image = UIImage(named: "noImageAsset")
        }
        else
        {
            let imgURL = URL(string: "\(self.destImageArr[indexPath.row])?mode=crop&width=320&height=240")
            
//            https://www.visitsharjah.com/media/1508/nahwa.jpg?mode=crop&width=640&height=480
            
            print ("*LoadingURL: \(self.destImageArr[indexPath.row])")
            destCell.destImgOutlet.kf.indicatorType = .activity
            destCell.destImgOutlet.kf.setImage(with: imgURL)
        }
    
        destCell.destTitleOutlet.text = self.destTitleArr[indexPath.row]
        destCell.destSubTitleOutlet.text = self.destSubTitleArr[indexPath.row]
        
        return destCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if indexPath.row >= 0
        {
            SmartSharjahShareClass.sharedInstance.destinationSelectedIndex = indexPath.row
            if((SmartSharjahShareClass.sharedInstance.destinationSelectedIndex) != nil)
            {
                self.title_dest = self.destTitleArr[indexPath.row]
                self.image_dest = self.destImageArr[indexPath.row]
                self.teritory_dest = self.destTerritoryArr[indexPath.row]
                self.tags_dest = self.destTagsArr[indexPath.row]
//                print("Tags: \(self.tags_dest)")
                self.subtitle_dest = self.destSubTitleArr[indexPath.row]
                self.cat_dest = self.destCategoriesArr[indexPath.row]
                self.desc_dest = self.destDescArr[indexPath.row]
                self.performSegue(withIdentifier: "DestDetailSegue", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension SharjahDestinations: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.resetData()
            self.searchBar.text = ""
            self.searchBar.endEditing(true)
       }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != "")
        {
           self.clearLocal()
               
             for (index, x) in SmartSharjahShareClass.sharedInstance.destTitleArr.enumerated(){
                   
                   if (x.lowercased().contains(searchBar.text!.lowercased()))
                   {
                       print ("Contains: \(x) YES contains \(searchBar.text!)")
                    
                    destTitleArr.append(SmartSharjahShareClass.sharedInstance.destTitleArr[index])
                    destURLArr.append(SmartSharjahShareClass.sharedInstance.destURLArr[index])
                    destSubTitleArr.append(SmartSharjahShareClass.sharedInstance.destSubTitleArr[index])
                    destDescArr.append(SmartSharjahShareClass.sharedInstance.destDescArr[index])
                    destImageArr.append(SmartSharjahShareClass.sharedInstance.destImageArr[index])
                    destLocationArr.append(SmartSharjahShareClass.sharedInstance.destLocationArr[index])
                    destCategoriesArr.append(SmartSharjahShareClass.sharedInstance.destCategoriesArr[index])
                    destTagsArr.append(SmartSharjahShareClass.sharedInstance.destTagsArr[index])
                    destTerritoryArr.append(SmartSharjahShareClass.sharedInstance.destTerritoryArr[index])
                
                    self.ShjDestTableViewOutlet.reloadData()
                    }
                   else{
                    print("Skipped...")
                }
                
            }
                    
        }
        else
        {
            self.resetData()
            self.searchBar.endEditing(true)
        }
        
    }
    
    
    
}
