//
//  SharjahActivitiesDetailsVC.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices
import Tags

class ResturantDetails: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var navBar: NavBar!
    
    @IBOutlet weak var tagsV: TagsView!
    @IBOutlet weak var ActDetailHolderViewOutlet: UIView!
    
    @IBOutlet weak var ActDetailsImgViewOutlet: UIImageView!
    
    @IBOutlet weak var ActDetailTitleLblOutlet: UILabel!
    
    @IBOutlet weak var ActDetailsSubTitleLblOutlet: UILabel!
    
     @IBOutlet weak var ActDetailsFeatureTagLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsLocationLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsWebsiteLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsPhoneLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsEmailLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsCatFlagLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsTypeFlagLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsBudgetTypeLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsDestTypeLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsContentTypeLblOutlet: UILabel!
     
    @IBOutlet weak var ActDetailsActivityURLLblOutlet: UILabel!
     
     //@IBOutlet weak var ActDetailsSubTitleLblOutlet: UILabel!
     
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if Utility.isArabicSelected()
         {
                self.ActDetailTitleLblOutlet.font = UIFont(name: AppFontArabic.bold, size: self.ActDetailTitleLblOutlet.font.pointSize)
        }
        else
        {
            self.ActDetailTitleLblOutlet.font = UIFont(name: AppFontEnglish.bold, size: self.ActDetailTitleLblOutlet.font.pointSize)
        }
        
       
        
        if (self.navBar != nil)
        {
//            self.navBar.title.text = "Smart Activities"
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
            navBar.contentView.backgroundColor = UIColor.clear
            self.navBar.superview?.bringSubviewToFront(self.navBar)
        }
        
        
        
//        ActDetailTitleLblOutlet.lineBreakMode = .byWordWrapping
//        ActDetailTitleLblOutlet.numberOfLines = 0
//        
//        ActDetailsSubTitleLblOutlet.lineBreakMode = .byWordWrapping
//        ActDetailsSubTitleLblOutlet.numberOfLines = 0
        // Do any additional setup after loading the view.
        
        self.loadSelectedActivityData()
    }
    

    func loadSelectedActivityData()
    {
        
         //@IBOutlet weak var ActDetailsImgViewOutlet: UIImageView!
        
        let imgURL       =   URL(string: "\(SmartSharjahShareClass.sharedInstance.activityImageURLArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex])?mode=crop&width=800&height=600")
        
        self.ActDetailsImgViewOutlet.kf.indicatorType = .activity
        self.ActDetailsImgViewOutlet.kf.setImage(with: imgURL)
        
        self.ActDetailTitleLblOutlet.text = SmartSharjahShareClass.sharedInstance.activityTitleArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex] //[SmartSharjahShareClass.sharedInstance.activityTitleArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]]
         
        self.ActDetailsSubTitleLblOutlet.text = SmartSharjahShareClass.sharedInstance.activitySubtitleArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
        //noor edit
        let label = UILabel(frame: CGRect(x:0,y: 0,width: 250,height: 50))
        label.attributedText = try? NSAttributedString(htmlString: (self.ActDetailsSubTitleLblOutlet.text ?? nil)!)
       self.ActDetailsSubTitleLblOutlet.text = label.attributedText?.string
        //---end
        
         
//        self.ActDetailsFeatureTagLblOutlet.text = "Tags : "+SmartSharjahShareClass.sharedInstance.activityFeaturedArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
        
         //self.ActDetailsLocationLblOutlet.text = SmartSharjahShareClass.sharedInstance.activityLocationCordArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
         
        self.ActDetailsWebsiteLblOutlet.text = "Website"
         
        self.ActDetailsPhoneLblOutlet.text = "Phone : "+SmartSharjahShareClass.sharedInstance.activityPhoneNoArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
         
        self.ActDetailsEmailLblOutlet.text = "Email : "+SmartSharjahShareClass.sharedInstance.activityEmailArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
        

        //noor edit
//        self.tagsV.set(contentsOf: SmartSharjahShareClass.sharedInstance.activityCategoriesArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex].components(separatedBy: ","))
        //===end
       
        
        self.ActDetailsTypeFlagLblOutlet.text = "Cuisines : "+SmartSharjahShareClass.sharedInstance.activityCategoriesArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
         
        self.ActDetailsBudgetTypeLblOutlet.text = "Budget Type : "+SmartSharjahShareClass.sharedInstance.activityBudgetArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
         
        self.ActDetailsDestTypeLblOutlet.text = "Destination : "+SmartSharjahShareClass.sharedInstance.activityDestTagArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
         
        self.ActDetailsContentTypeLblOutlet.text = "Type : "+SmartSharjahShareClass.sharedInstance.activityContentTypeArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
         
//        self.ActDetailsActivityURLLblOutlet.text = "Event Website : "+SmartSharjahShareClass.sharedInstance.activityWebsiteArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex]
        
    }
    
    
    @IBAction func webTapFunc(_ sender: UITapGestureRecognizer) {
        
        let LocUrl = URL(string : SmartSharjahShareClass.sharedInstance.activityWebsiteArr[SmartSharjahShareClass.sharedInstance.activitySelectedIndex])
        
        if ["http", "https"].contains(LocUrl?.scheme?.lowercased() ?? "") {
            // Can open with SFSafariViewController
            let safariViewController = SFSafariViewController(url: LocUrl!)
//            self.present(safariViewController, animated: true, completion: nil)
            self.presentFromRight(safariViewController)
        } else {
            // Scheme is not supported or no scheme is given, use openURL
            if LocUrl != nil
            {
                UIApplication.shared.open(LocUrl!, options: [:], completionHandler: nil)

            }
        }
        
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismissFromLeft()
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
//noor edit
extension NSAttributedString {
    
    convenience init(htmlString html: String) throws {
        try self.init(data: Data(html.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
    }
    
}
