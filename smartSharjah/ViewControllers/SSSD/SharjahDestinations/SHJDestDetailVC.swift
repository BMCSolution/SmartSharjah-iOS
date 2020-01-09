//
//  SHJDestDetailVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Tags
import Kingfisher
class SHJDestDetailVC: UIViewController {

    @IBOutlet weak var newsView: UIView!
    
    @IBOutlet weak var news_Title_Lbl: UILabel!
    @IBOutlet weak var news_Details_TxtView: UITextView!
    @IBOutlet weak var news_Image: UIImageView!
    
    
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var tags: TagsView!
    
    @IBOutlet weak var destDetailHolderOutlet: UIView!
    
    @IBOutlet weak var destDetailImgViewOutlet: UIImageView!
    
    @IBOutlet weak var destSubTitleLblOutlet: UILabel!
    
    //@IBOutlet weak var destEmailsLblOutlet: UILabel!
    @IBOutlet weak var destCategoryLblOutlet: UILabel!
    @IBOutlet weak var destTagsLblOutlet: UILabel!
    @IBOutlet weak var destTerritoryLblOutlet: UILabel!
    @IBOutlet weak var destDescLblOutlet: UITextView!
 
    @IBOutlet weak var territoryLblBackground: UIView!
    var newsImgURL: String = ""
    var newsDescription: String!
    var isNewsShown = false
    var newsTitle: String!
    
    
    // Destination Objects
    var title_dest = ""
    var image_dest = ""
    var teritory_dest = ""
    var tags_dest = ""
    var subtitle_dest = ""
    var cat_dest = ""
    var desc_dest = ""
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.destDescLblOutlet.contentOffset = .zero
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.destDescLblOutlet.textAlignment = Utility.isArabicSelected() ? .right : .left
    }
    
    func setNewsDetails()
    {
        self.newsView.alpha = 1
        self.news_Title_Lbl.setBold()
        self.news_Title_Lbl.text = self.newsTitle
         self.destTerritoryLblOutlet.isHidden = true
        //            let url = URL(string: self.newsImgURL)!
        let url = URL(string: self.newsImgURL as! String)
        print("Img url str: \(self.newsImgURL)")

        if self.newsImgURL.contains("jpg") || self.newsImgURL.contains("JPG")
        {
        //                self.destDetailImgViewOutlet.kf.setImage(with: url)
         self.news_Image.kf.setImage(
            with: url,
            placeholder: UIImage(named: "news_Default"),
            options: nil)
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
                        
                        
        }
        else
        {
            self.news_Image.image = UIImage(named: "news_Default")
        }
        self.destDetailImgViewOutlet.contentMode = .scaleToFill
        self.news_Details_TxtView.text = self.newsDescription
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.news_Details_TxtView.textAlignment = Utility.isArabicSelected() ? .right : .left
        
        if Utility.isArabicSelected()
         {
                self.destTagsLblOutlet.font = UIFont(name: AppFontArabic.bold, size: self.destTagsLblOutlet.font.pointSize)
        }
        else
        {
            self.destTagsLblOutlet.font = UIFont(name: AppFontEnglish.bold, size: self.destTagsLblOutlet.font.pointSize)
        }
        
        // Do any additional setup after loading the view.
        
        if (self.navBar != nil)
        {
            self.destTerritoryLblOutlet.isHidden = false
            self.navBar.title.text = ""
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
            if !isNewsShown
            {
                self.navBar.contentView.backgroundColor = UIColor.clear
            }
            
        }
        
        if isNewsShown
        {
            self.territoryLblBackground.isHidden = true
            self.destTerritoryLblOutlet.isHidden = true
            self.destSubTitleLblOutlet.text = ""
            self.setNewsDetails()
        }
        else
        {
            self.newsView.alpha = 0
            self.destDetailImgViewOutlet.contentMode = .scaleAspectFill
            self.territoryLblBackground.isHidden = false
            self.destTerritoryLblOutlet.isHidden = false
            self.destinationDetails()
        }
        
    }
    
    
    func destinationDetails()
    {
     /*
        ]["title"].stringValue)
        ]["url"].stringValue)
        Item]["subtitle"].stringValue)
        ]["description"].stringValue)
        ]["image"].stringValue)
        ]["location"].stringValue)
        ]["categories"].stringValue)
        ["destinationTags"].stringValue)19
        ]["territoryTags"].stringValue)
        
        */
        
        
        let imgURL = URL(string: "\(self.image_dest)?mode=crop&width=800&height=600")// SmartSharjahShareClass.sharedInstance.destImageArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex])
        self.destDetailImgViewOutlet.kf.indicatorType = .activity
        self.destDetailImgViewOutlet.kf.setImage(with: imgURL)
        
        
        
        self.destSubTitleLblOutlet.text = self.subtitle_dest //SmartSharjahShareClass.sharedInstance.destSubTitleArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex]
        
        var subject = self.tags_dest //SmartSharjahShareClass.sharedInstance.destCategoriesArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex]
        
        var subComponents = subject.components(separatedBy: ",") as! [String]
        
        if (subComponents.count > 0)
        {
            for x in 0...subComponents.count-1{
                
                if (subComponents[x] == "" )
                {
                    subComponents.remove(at: x)
                }
                
            }
        }
        
        
        self.tags.removeAll()
        self.tags.set(contentsOf: subComponents)
            
            //=  SmartSharjahShareClass.sharedInstance.destCategoriesArr
        self.destTagsLblOutlet.text = self.title_dest//self.tags_dest.replacingOccurrences(of: ",", with: ", ") //SmartSharjahShareClass.sharedInstance.destTagsArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex].replacingOccurrences(of: ",", with: ", ")
        self.destTerritoryLblOutlet.text = self.teritory_dest //SmartSharjahShareClass.sharedInstance.destTerritoryArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex]
        
        if Utility.isArabicSelected()
        {
            let strToDecode = self.desc_dest //(SmartSharjahShareClass.sharedInstance.destDescArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex])

            self.destDescLblOutlet.text = strToDecode.withoutHtml
        }
        else
        {
            self.destDescLblOutlet.text = self.desc_dest.htmlToString.appending("\n\n\n\n") //(SmartSharjahShareClass.sharedInstance.destDescArr[SmartSharjahShareClass.sharedInstance.destinationSelectedIndex]).htmlToString.appending("\n\n\n\n")
        }
        
        
        self.destDescLblOutlet.contentOffset = .zero
        self.destDescLblOutlet.setContentOffset(CGPoint.zero, animated: false)
        
    }
}
