//
//  ViewController.swift
//  smartSharjah
//
//  Created by OzzY on 7/14/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import HTMLParser

import Crashlytics
//import SwiftyXMLParser


//import MaterialComponents.MaterialButtons


class ViewController: UIViewController,XMLParserDelegate {
    
    @IBOutlet weak var recentLbl: UILabel!
    
    fileprivate let feedParser = FeedParser()
    fileprivate var rssItems: [(title: String, description: String, pubDate: String, image: String)]?
    
    
    //noor edit
    var dataArray: NSMutableArray = []
    var ftitle = NSMutableString()
    var link = NSMutableString()
    //    var img:  [AnyObject] = []
    var fdescription = NSMutableString()
    
    //    let arrayOfArray : NSMutableArray = []
    
    //    var ipAddr:String!
    //     var mainNewsImgURL: [String] = []
    var mainNewsImgURL : NSMutableArray = []
    var mainNewsTitle : NSMutableArray = []
    var mainNewsDescription : NSMutableArray = []
    var newsArray: [NSMutableDictionary] = []
    var newsArr: [RSSItem] = []
    //    var mainNewsImgURL = []
    var ipAddr:String = ""
    var heading = ""
    var webLink = ""
    var details = ""
    var thumbImg = ""
    //    var currentParsingElement = ""
    var currentParsingElement:String = ""
    
    @IBOutlet weak var ipAddressLabel:UILabel!
    @IBOutlet weak var countryCodeLabel:UILabel!
    @IBOutlet weak var countryNameLabel:UILabel!
    @IBOutlet weak var latitudeLabel:UILabel!
    @IBOutlet weak var longitudeLabel:UILabel!
    //==end
    @IBOutlet weak var navBar: NavBar!
    
    
    var imgBaseURL = "http://sharjah24.ae"
    
//    var imageArray = [UIImage(named: "news2"),
//                      UIImage(named: "news3"),
//                      UIImage(named: "news2"),
//                      UIImage(named: "news3")]
    
    var newsImgURL: [String] = []
    var newsTitle: [String] = []
    var newsDescription: [String] = []
    var selectedImageURL: String!
    var selectedDescription: String!
    var selectedTitle: String!
    
    var historyArray: [UIImage] = []
    var historyTitles: [String] = []
    var historyTitles_Ar: [String] = []
    
    var paymentArray = [UIImage(named: "ic_du_payment_new"),
                        UIImage(named: "pay2"),
                        UIImage(named: "pay3")]
    
    var paymentTitles = ["DU Payment", "RTA Traffic Fine", "Etisalat Bill"]
    var paymentTitles_Ar = ["دفع DU","هيئة الطرق والمواصلات غرامة المرور","فاتورة اتصالات"]
    
    
    var govtArray = [UIImage(named: "goverment_20190929_183417310"),
                     UIImage(named: "ic_transport_new"),
                     UIImage(named: "Govt3"),
                     UIImage(named: "Govt4"),
                     UIImage(named: "complaints_20190929_183408718"),
                     UIImage(named: "color_new_ic_safety_en"),
                     UIImage(named: "ic_social_services_new"),
                     UIImage(named: "sharja landmark_20190929_183421161"),
                     UIImage(named: "Govt9"),
                     UIImage(named: "ulity and bills_20190929_183413107"),
                     UIImage(named: "Donations_20190929_183402875")]
    
    
    var govtTitles = ["Working with Government",
                      "Vehicles & Transport",
                      "Housing & Property",
                      "Media",
                      "Complaints & Suggestions",
                      "Safety & Environment",
                      "Social Services" ,
                      "Sharjah Landmarks",
                      "Commerce",
                      "Utilities & Bills",
                      "Donations"]
    
    var govtTitles_Ar = [
        "العمل مع الحكومة",
    "المركبات والمواصلات",
    "الإسكان والعقارات",
    "وسائل الإعلام",
    "الشكاوى والاقتراحات",
    "السلامة والبيئة",
    "الخدمات الاجتماعية",
    "معالم الشارقة",
    "التجارة",
    "الدفعات والفواتير",
    "التبرعات"
    ]

    
    
    var otherArray = [UIImage(named: "Other1")]
    
    var otherTitles = ["Medicine Reminder"]
   
    var otherTitles_Ar = ["منظم الدواء"]
    
    var type = ""
    var itemImg:UIImage!
    var itemTitle = ""
    var tag = 0
    var str = ""
    
    var itemImgN:UIImage!
    var itemTitleN:String!
    var tagItem: Int!
    var tagN: Int!
    var searchMode: Bool!
    
    let manager = Alamofire.SessionManager.default
    //@IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var uaepassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var viewBarOther: UIView!
    @IBOutlet weak var viewLoginBar: UIView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var paymentBar1: UIView!
    @IBOutlet weak var paymentBar2: UIView!
    @IBOutlet weak var paymentBar3: UIView!
    @IBOutlet weak var paymentBar4: UIView!
    
    @IBOutlet weak var topBannerViewOutlet: UIView!
    
    
    @IBOutlet weak var GovtServicesCard: UIView!
    @IBOutlet weak var paymentCollectionViewOutlet: UICollectionView!
    
    @IBOutlet weak var newsCollectionViewOutlet: UICollectionView!
    
    @IBOutlet weak var govtServicesCollectionOutlet: UICollectionView!
    
    @IBOutlet weak var otherServicesCollectionOutlet: UICollectionView!
    
    @IBOutlet weak var newsLoadingView: UIView!
    @IBOutlet weak var activityIndicatorNews: UIActivityIndicatorView!
    
    var newsDictionary: NSMutableDictionary = [:]
    
    var localizationData : [NSDictionary] = []
    
    func parseNewsTesting(lang: String)
    {
        let feedURL = "http://sharjah24.ae/" + lang + "/rss"
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
          self?.rssItems = rssItems
          
          DispatchQueue.main.async {
            print("___*****---*****___ Total items: \(self?.rssItems?.count ?? 0) ")
            self!.newsCollectionViewOutlet.reloadData()
          }
        }
    }
    func scrollOtherCollection()
       {
        let collection: UICollectionView = self.otherServicesCollectionOutlet
        if Utility.isArabicSelected()
        {
            collection.layoutIfNeeded()
            let offset = collection.contentSize.width - collection.bounds.size.width
                      collection.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
                      
        }
        else
        {
            collection.layoutIfNeeded()
            let offset = collection.contentSize.width - collection.bounds.size.width
                      collection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                      
        }
          
           //setContentOffSet(CGPoint(x: offset, y: 0), animated: true)
       }
    
    
    func scrollCollection(collection: UICollectionView)
    {
        if Utility.isArabicSelected()
        {
            if collection == self.newsCollectionViewOutlet
            {
                collection.layoutIfNeeded()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                    let offset = collection.contentSize.width - collection.bounds.size.width
                    collection.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
                }
                
                
//                let frame: CGRect = CGRect(x : offset ,y : collection.contentOffset.y ,width : collection.frame.width,height : collection.frame.height)
//
//                collection.scrollRectToVisible(frame, animated: true)
            }
            else
            {
                collection.layoutIfNeeded()
                let offset = collection.contentSize.width - collection.bounds.size.width
                print("Offset: \(offset)")
                          collection.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
            }
            
            
                      
        }
        else
        {
            collection.layoutIfNeeded()
            let offset = collection.contentSize.width - collection.bounds.size.width
                      collection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                      
        }
        
//        collection.layoutIfNeeded()
//        let offset = collection.contentSize.width - collection.bounds.size.width
//        collection.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
        //setContentOffSet(CGPoint(x: offset, y: 0), animated: true)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        let history = History()
        self.paymentArray = history.getImages()
        self.paymentTitles = history.getTitles()
        self.paymentTitles_Ar = history.getTitles_Ar()
        
        self.configureViews()
        
    }
    
    func configureViews()
    {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if Utility.isArabicSelected()
                        {
                        
                            self.newsCollectionViewOutlet.layoutIfNeeded()
                            self.newsCollectionViewOutlet.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
                            self.newsCollectionViewOutlet.reloadData()
                            
                            self.paymentCollectionViewOutlet.layoutIfNeeded()
                            self.paymentCollectionViewOutlet.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
                            self.paymentCollectionViewOutlet.reloadData()
                            
                            self.govtServicesCollectionOutlet.layoutIfNeeded()
                            self.govtServicesCollectionOutlet.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
                            self.govtServicesCollectionOutlet.reloadData()
                           
                            self.otherServicesCollectionOutlet.layoutIfNeeded()
                            self.otherServicesCollectionOutlet.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
                              
                        }
                        else
                        {
                            
                            
                            self.paymentCollectionViewOutlet.layoutIfNeeded()
                            self.paymentCollectionViewOutlet.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
                            self.paymentCollectionViewOutlet.reloadData()
                            
                            self.govtServicesCollectionOutlet.layoutIfNeeded()
                            self.govtServicesCollectionOutlet.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
                            self.govtServicesCollectionOutlet.reloadData()
                            
                            self.otherServicesCollectionOutlet.layoutIfNeeded()
                            self.otherServicesCollectionOutlet.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
                            
                            
                            self.newsCollectionViewOutlet.layoutIfNeeded()
                            self.newsCollectionViewOutlet.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
                            self.newsCollectionViewOutlet.reloadData()
                            
                       
                        }
                        
                        self.scrollCollection(collection: self.govtServicesCollectionOutlet)
                        self.scrollCollection(collection: self.newsCollectionViewOutlet)
                        self.scrollOtherCollection()
                        if self.paymentArray.count > 0
                        {
                            self.scrollCollection(collection: self.paymentCollectionViewOutlet)

                        }
                  
            }
              
                    
    }
    
    func getItems(forType: String) -> [String]
    {
        var arr: [String] = []
        if self.rssItems?.count ?? 0 > 0
        {
            for item in self.rssItems!
            {
                if forType == "title"
                {
                    arr.append(item.title)
                }
                else if forType == "description"
                {
                    arr.append(item.description)
                }
                else
                {
                    arr.append(item.image)
                }
                
            }
        }
        return arr
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier == "NewsShowAll")
        {
            if let dest = segue.destination as? NewAllNewsVC{
                dest.mainNewsImgURL = self.getItems(forType: "image") as? NSArray
                dest.mainNewsTitle = self.getItems(forType: "title") as? NSArray
                dest.mainNewsDescription = self.getItems(forType: "description") as? NSArray
            }
        }
        
        if (segue.identifier == "showAll")
        {
            if let dest = segue.destination as? ShowAllVC{
                dest.type = self.type
                dest.itemImg = self.itemImg
                dest.itemTitle = self.itemTitle
                dest.tag = self.tag
                dest.govtTitles = self.govtTitles
                dest.govtTitles_Ar = self.govtTitles_Ar
            }
        }
        
        if (segue.identifier == "allServices")
        {
            let destNav = segue.destination as! UINavigationController
            
            let dest = destNav.viewControllers[0] as! ServicesListVC
            dest.itemImg = self.itemImg
            dest.itemTitle = self.itemTitleN
            dest.tagN = self.tagN
            dest.tagIndex = self.tagItem
            dest.searchMode = self.searchMode
        }
        
        if segue.identifier == "destinationSegue"
        {
            let dest = segue.destination as! SHJDestDetailVC
            dest.isNewsShown = true
            dest.newsImgURL = self.selectedImageURL
            dest.newsDescription = self.getText(fromHTML: self.selectedDescription)
            dest.newsTitle = self.selectedTitle
        }
        
    }
    
    func getText(fromHTML: String) -> String
    {
        let htmlObj = HTMLParser.stripHTML(fromHTML)!
        let str = htmlObj.replacingOccurrences(of: "&#160;", with: "").replacingOccurrences(of: "\n", with: "")
        return str
    }
    
    @IBAction func showMorePressed(_ sender: UIButton) {
        
        if (sender.tag == -1)
        {
            if Utility.isArabicSelected() {
                self.type = "أخبار"
            } else {
                self.type = "News"
            }
            self.tag = 0
             self.performSegue(withIdentifier: "NewsShowAll", sender: self)
        }
        if (sender.tag == 0)
        {
            if Utility.isArabicSelected() {
                self.type = "مستخدم حديثا"
            } else {
                self.type = "Recently Used"
            }
            self.tag = 0
             self.performSegue(withIdentifier: "showAll", sender: self)
        }
        else if (sender.tag == 1)
        {
            if Utility.isArabicSelected() {
                self.type = "الخدمات الحكومية"
            } else {
                self.type = "Government Services"
            }
            self.tag = 1
             self.performSegue(withIdentifier: "showAll", sender: self)
        }
        else if (sender.tag == 2)
        {
            if Utility.isArabicSelected() {
                self.type = "خدمات أخرى"
            } else {
                self.type = "Other Services"
            }
            self.tag = 2
             self.performSegue(withIdentifier: "showAll", sender: self)
        }
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //print(dataArray.count)
        //noor edit
                /*if Utility.isArabicSelected() {
                    parseNewsTesting(lang: "ar")
        //            getXMLDataFromServer(lang: "ar")
        //            self.getNewsRSS(lang: "ar")
                    otherTitles = ["منظم الدواء"]
                } else {
                    parseNewsTesting(lang: "en")
        //            getXMLDataFromServer(lang: "en")
        //            self.getNewsRSS(lang: "en")
                }*/
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DispatchQueue.main.async {

                if Utility.isArabicSelected() {
                        self.parseNewsTesting(lang: "ar")
            //            getXMLDataFromServer(lang: "ar")
            //            self.getNewsRSS(lang: "ar")
                        self.otherTitles = ["منظم الدواء"]
                    } else {
                        self.parseNewsTesting(lang: "en")
            //            getXMLDataFromServer(lang: "en")
            //            self.getNewsRSS(lang: "en")
                    }
            
        }
        
        //noor edit
        
        
       
       
        print(dataArray.count)
      
        // Do any additional setup after loading the view.
        manager.session.configuration.timeoutIntervalForResource = 10
        manager.session.configuration.timeoutIntervalForRequest = 10
        if User().isLoggedin()
        {
            DispatchQueue.main.async {
                if Reachability.isConnectedToNetwork()
                {
                    if(Utility.checkSesion())
                    {
                        self.getData()
                    }
                    else
                    {
                        Utility.getFreshToken {
                            (success, response) in
                            self.getData()
                        }
                    }
                }
            }
        }
        
        
        
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.searchPressed), name: NSNotification.Name(rawValue: "searchPressed"), object: nil)
        
        viewBarStyle()
        viewBarOtherStyle()
        viewLoginBarStyle()
        textFieldStyle()
        paymentBarStyle()
        govtServicesCardStyle()
        
        //self.topBannerViewOutlet.roundCorners([.bottomLeft], radius: 10)
        //loadGif()
        
        if (self.navBar != nil)
        {
            self.navBar.title.text = "Smart Sharjah".localized()
            self.navBar.menuSettings(navController: self.navigationController, menuShown: true)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logout), name: NSNotification.Name(rawValue: "Logout"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.gotoLogin), name: NSNotification.Name(rawValue: "GoToLogin"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.switchTab(_:)), name: NSNotification.Name(rawValue: "switchTab"), object: nil)
        
        self.loadLocalization();
    }
    
    func loadLocalization()
    {

         SmartSharjahShareClass.showActivityIndicator(view: self.view, targetVC: self)
        APILayer().getLocalizationNew(name: "ListLocalization", method: .get, path: "api/LocalizationController/ListLocalizationByScreenName", params: ["ScreenName":"MainScreen"], headers: [:]) { (success, response) in
            
            if (success)
            {
                self.localizationData = (response as? [NSDictionary])!
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                print("success: \(success)")
                if response!.count > 0
                {
                    self.loadingLocalizationData();
                }
            }
            else
            {
                SmartSharjahShareClass.hideActivityIndicator(view: self.view)
                if(response != nil)
                {
                    print("Response: \(response)")
                    SetDefaultWrappers().showAlert(info:"Request Failed!", viewController: self)
                }
            }
        }
    }
    
    func loadingLocalizationData()
    {
        if(self.getItemFromKey(labelName: "ApplicationName") != -1)
        {
            self.navBar.title.text = self.localizationData[self.getItemFromKey(labelName: "ApplicationName")][Utility.isArabicSelected() ? "value_AR" : "value_EN"] as? String
        }
        
        if(self.getItemFromKey(labelName: "WorkingWithGovernment") != -1)
        {
            self.govtTitles[0] = self.localizationData[self.getItemFromKey(labelName: "WorkingWithGovernment")]["value_EN"] as! String
            self.govtTitles_Ar[0] = self.localizationData[self.getItemFromKey(labelName: "WorkingWithGovernment")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "VehiclesAndTransport") != -1)
        {
            self.govtTitles[1] = self.localizationData[self.getItemFromKey(labelName: "VehiclesAndTransport")]["value_EN"] as! String
            self.govtTitles_Ar[1] = self.localizationData[self.getItemFromKey(labelName: "VehiclesAndTransport")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "HousingAndProperty") != -1)
        {
            self.govtTitles[2] = self.localizationData[self.getItemFromKey(labelName: "HousingAndProperty")]["value_EN"] as! String
            self.govtTitles_Ar[2] = self.localizationData[self.getItemFromKey(labelName: "HousingAndProperty")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "Media") != -1)
        {
            self.govtTitles[3] = self.localizationData[self.getItemFromKey(labelName: "Media")]["value_EN"] as! String
            self.govtTitles_Ar[3] = self.localizationData[self.getItemFromKey(labelName: "Media")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "ComplaintsAndSuggestions") != -1)
        {
            self.govtTitles[4] = self.localizationData[self.getItemFromKey(labelName: "ComplaintsAndSuggestions")]["value_EN"] as! String
            self.govtTitles_Ar[4] = self.localizationData[self.getItemFromKey(labelName: "ComplaintsAndSuggestions")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "SafetyAndEnvironment") != -1)
        {
            self.govtTitles[5] = self.localizationData[self.getItemFromKey(labelName: "SafetyAndEnvironment")]["value_EN"] as! String
            self.govtTitles_Ar[5] = self.localizationData[self.getItemFromKey(labelName: "SafetyAndEnvironment")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "SocialServices") != -1)
        {
            self.govtTitles[6] = self.localizationData[self.getItemFromKey(labelName: "SocialServices")]["value_EN"] as! String
            self.govtTitles_Ar[6] = self.localizationData[self.getItemFromKey(labelName: "SocialServices")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "SharjahLandmarks") != -1)
        {
            self.govtTitles[7] = self.localizationData[self.getItemFromKey(labelName: "SharjahLandmarks")]["value_EN"] as! String
            self.govtTitles_Ar[7] = self.localizationData[self.getItemFromKey(labelName: "SharjahLandmarks")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "Commerce") != -1)
        {
            self.govtTitles[8] = self.localizationData[self.getItemFromKey(labelName: "SocialServices")]["value_EN"] as! String
            self.govtTitles_Ar[8] = self.localizationData[self.getItemFromKey(labelName: "SocialServices")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "UtilitiesAndBills") != -1)
        {
            self.govtTitles[9] = self.localizationData[self.getItemFromKey(labelName: "UtilitiesAndBills")]["value_EN"] as! String
            self.govtTitles_Ar[9] = self.localizationData[self.getItemFromKey(labelName: "UtilitiesAndBills")]["value_AR"] as! String
        }
        if(self.getItemFromKey(labelName: "Donations") != -1)
        {
            self.govtTitles[10] = self.localizationData[self.getItemFromKey(labelName: "Donations")]["value_EN"] as! String
            self.govtTitles_Ar[10] = self.localizationData[self.getItemFromKey(labelName: "Donations")]["value_AR"] as! String
        }
        
        self.configureViews()
        
    }
    
    func getItemFromKey(labelName: String ) -> Int
    {
        var iterator = 0;
        for obj in self.localizationData {
            if(obj["localizationKey"] as? String == labelName)
            {
                return iterator;
            }
            iterator += 1
        }
        return -1;
    }
    
    func showNewsLoader()
    {
        
        UIView.transition(with:newsCollectionViewOutlet , duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.newsLoadingView.alpha = 1
            self.activityIndicatorNews.startAnimating()
        })
    }
    
    func hideNewsLoader()
    {
        print("News loader is hidden")
        self.newsLoadingView.alpha = 0
        self.activityIndicatorNews.stopAnimating()
    }
    
    
    @objc func gotoLogin() {
        
        print ("Closing!!")
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    // handle notification
    @objc func switchTab(_ notification: NSNotification) {
         print ("inside notification")
        if let numm = notification.userInfo?["number"] as? Int {
//            if numm != 0 {
                
                if UserDefaults.standard.object(forKey: "username") == nil && numm > 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        SetDefaultWrappers().showAlert(info: "Login to use this feature".localized(), viewController: self)
                    }

                } else {
                    self.tabBarController?.selectedIndex = numm
                    print ("Tab Changed to \(numm)")
                }
//            }
        }
        
        
    }
    
    @objc func logout() {
        print ("Logged out from vc...!")
//        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func searchPressed()
    {
        //        print("searchPressed...")
        self.searchMode = true
        self.performSegue(withIdentifier: "allServices", sender: self)
    }
    
    func govtServicesCardStyle() {
        //GovtServicesCard.roundCorners(UIRectCorner, radius: 5)
    }
    
    func paymentBarStyle() {
        paymentBar1?.layer.shadowPath = UIBezierPath(rect: paymentBar1.bounds).cgPath
        paymentBar1?.layer.shadowRadius = 3
        paymentBar1?.layer.cornerRadius = 5
        paymentBar1?.layer.shadowOffset = .zero
        paymentBar1?.layer.shadowOpacity = 0.4
        
        paymentBar2?.layer.shadowPath = UIBezierPath(rect: paymentBar2.bounds).cgPath
        paymentBar2?.layer.shadowRadius = 3
        paymentBar2?.layer.cornerRadius = 5
        paymentBar2?.layer.shadowOffset = .zero
        paymentBar2?.layer.shadowOpacity = 0.4
        
        paymentBar3?.layer.shadowPath = UIBezierPath(rect: paymentBar3.bounds).cgPath
        paymentBar3?.layer.shadowRadius = 3
        paymentBar3?.layer.cornerRadius = 5
        paymentBar3?.layer.shadowOffset = .zero
        paymentBar3?.layer.shadowOpacity = 0.4
        
        paymentBar4?.layer.shadowPath = UIBezierPath(rect: paymentBar4.bounds).cgPath
        paymentBar4?.layer.shadowRadius = 3
        paymentBar4?.layer.cornerRadius = 5
        paymentBar4?.layer.shadowOffset = .zero
        paymentBar4?.layer.shadowOpacity = 0.4
    }
    
    func textFieldStyle() {
        usernameTxt?.layer.cornerRadius = 5
        passwordTxt?.layer.cornerRadius = 5
        usernameTxt?.layer.borderColor = UIColor.black.cgColor
        passwordTxt?.layer.borderColor = UIColor.black.cgColor
    }
    
    func viewLoginBarStyle() {
        viewLoginBar?.layer.shadowPath = UIBezierPath(rect: viewLoginBar.bounds).cgPath
        viewLoginBar?.layer.shadowRadius = 5
        viewLoginBar?.layer.cornerRadius = 15
        //viewLoginBar?.layer.shadowOffset = .zero
        viewLoginBar?.layer.shadowOpacity = 0.5
    }
    
    func viewBarOtherStyle() {
        viewBarOther?.layer.shadowPath = UIBezierPath(rect: viewBarOther.bounds).cgPath
        viewBarOther?.layer.shadowRadius = 3
        viewBarOther?.layer.cornerRadius = 5
        viewBarOther?.layer.shadowOffset = .zero
        viewBarOther?.layer.shadowOpacity = 0.4
    }
    
    func viewBarStyle() {
        viewBar?.layer.shadowPath = UIBezierPath(rect: viewBar.bounds).cgPath
        viewBar?.layer.shadowRadius = 3
        viewBar?.layer.cornerRadius = 5
        viewBar?.layer.shadowOffset = .zero
        viewBar?.layer.shadowOpacity = 0.4
    }
    
    func guestButtonStyle() {
        guestButton?.backgroundColor = .clear
        guestButton?.layer.cornerRadius = 15
        guestButton?.layer.borderWidth = 1
        guestButton?.layer.borderColor = UIColor.black.cgColor
    }
    
    func uaepassButtonStyle() {
        uaepassButton?.backgroundColor = .clear
        uaepassButton?.layer.cornerRadius = 15
        uaepassButton?.layer.borderWidth = 1
        uaepassButton?.layer.borderColor = UIColor.black.cgColor//UIColor.init(red: 35.0, green: 141.0, blue: 52.0, alpha: 1.0).cgColor
        //uaepassButton?.setTitleColor(.init(red: 35.0, green: 141.0, blue: 52.0, alpha: 1.0), for: .normal)
    }
    
    func loginButtonStyle() {
        loginButton?.backgroundColor = .clear
        loginButton?.layer.cornerRadius = 15
        loginButton?.layer.borderWidth = 1
        loginButton?.layer.borderColor = UIColor.black.cgColor
    }
    
    func signupButtonStyle() {
        signupButton?.backgroundColor = .clear
        signupButton?.layer.cornerRadius = 15
        signupButton?.layer.borderWidth = 1
        signupButton?.layer.borderColor = UIColor.black.cgColor
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate
{
    
    ////////////////// NEWS ////////////////////
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == newsCollectionViewOutlet){
            
//            return self.newsArr.count
            
            print("News Dict items : \(self.rssItems?.count ?? 0)")
                if (self.rssItems?.count ?? 0 < 15)
                {
                    self.newsLoadingView.isHidden = true
                    if self.rssItems?.count ?? 0 > 0
                    {
                        return self.rssItems!.count
                    }
                    else
                    {
                        return 0
                    }
                    
                }
                else
                {
                    self.newsLoadingView.isHidden = true
                    return 15
                }
            
        }
        else if (collectionView == paymentCollectionViewOutlet)
        {
            self.recentLbl.isHidden = (paymentArray.count != 0)
            return paymentArray.count
        }
        else if (collectionView == govtServicesCollectionOutlet)
        {
            return govtArray.count
        }
        else
        {
            return otherArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if (collectionView == newsCollectionViewOutlet)
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! NewsViewController
            
            
            cell.resetCell()
            if let item = rssItems?[indexPath.row]
            {
                cell.title.text = item.title
                let url = URL(string: item.image)
                let s = item.image
                if s.contains("http") && s.contains("jpg") && !(s.contains("shttps://www.sharjah24.aehttps://img.youtube")) || s.contains("JPG")
                {

                    cell.imgImage.kf.setImage(
                        with: url,
                        placeholder: UIImage(named: "news_Default"),
                        options: nil)
                    {
                        result in
                        switch result {
                        case .success(let value):
                            print("Task done for: \(item.image ?? "")")
                        case .failure(let error):
                            print("Job failed: \(error.localizedDescription)")
                        }
                    }

                }
                else
                {
                    cell.imgImage.image = UIImage(named: "news_Default")
                }
                
            }
//
//            let input = self.newsArr[indexPath.row].itemDescription!
//
//            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//
////            print ("matches: \(input)")
//
//            for match in matches {
//                guard let range = Range(match.range, in: input) else { continue }
//                let url = input[range]
//                print("\(indexPath.row): \(url)")
//
//            }
            
//            print ("mediathumb: \(self.newsArr[indexPath.row].mediaThumbnail)")
//            print ("mediacontent: \(self.newsArr[indexPath.row].media)")
            
//            if let imgArr = self.newsArr[indexPath.row].imagesFromContent as? [String]
//            {
//                print ("imgArr1: \(imgArr)")
//            }
//            else
//            {
//                    print ("imgArr1 is Null")
//            }
//
//            if let imgArr = self.newsArr[indexPath.row].imagesFromDescription as? [String]
//            {
//                print ("imgArr2: \(imgArr)")
//            }
//            else
//            {
//                    print ("imgArr2 is Null")
//            }
            
             
//            if mainNewsImgURL.count > 0
//            {
//                cell.imgImage.layer.cornerRadius = 10
//                cell.imgImage.clipsToBounds = true
//                //                    let url = URL(string: self.mainNewsImgURL[indexPath.item])!
////                print("News Image path: \(self.mainNewsImgURL[indexPath.item] as! String)")
//                let url = URL(string: self.newsArray[indexPath.item]["image"] as! String)//URL(string: self.mainNewsImgURL[indexPath.item] as! String)
//                let s = self.newsArray[indexPath.item]["image"] as! String//self.mainNewsImgURL[indexPath.item] as! String
//                if s.contains("http") && s.contains("jpg") && !(s.contains("shttps://www.sharjah24.aehttps://img.youtube")) || s.contains("JPG")
//                {
//
//                    cell.imgImage.kf.setImage(
//                        with: url,
//                        placeholder: UIImage(named: "news_Default"),
//                        options: nil)
//                    {
//                        result in
//                        switch result {
//                        case .success(let value):
//                            let v = value
////                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                        case .failure(let error):
//                            print("Job failed: \(error.localizedDescription)")
//                        }
//                    }
//
//                }
//                else
//                {
//                    cell.imgImage.image = UIImage(named: "news_Default")
//                }
//
//            }
//            else
//            {}

//            if mainNewsTitle.count > 0 &&  indexPath.item < mainNewsTitle.count
//            {
//
//                cell.title.text = self.mainNewsTitle[indexPath.item] as? String
//            }
            
            // ---------- new implemetation starts
            
            
            
            cell.imgImage.tag = indexPath.item
            return cell
        }
        else if (collectionView == paymentCollectionViewOutlet)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! PaymentViewController
            cell.paymentImage.image = paymentArray[indexPath.row]
            
            if Utility.isArabicSelected()
            {
                cell.titleLabel.text = self.paymentTitles_Ar[indexPath.row]
            }
            else
            {
                cell.titleLabel.text = self.paymentTitles[indexPath.row]
            }
            
            cell.bgView.layer.cornerRadius = 10
            
            if (indexPath.row%2 == 0)
            {
                //                cell.backgroundColor = UIColor.red
                
            }
            
            //cell.paymentImage.tag = indexPath.row
            return cell
        }
        else if (collectionView == govtServicesCollectionOutlet)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! PaymentViewController
            cell.paymentImage.image = govtArray[indexPath.row]
                        
            if Utility.isArabicSelected()
            {
                cell.titleLabel.text = self.govtTitles_Ar[indexPath.row]
            }
            else
            {
                cell.titleLabel.text = self.govtTitles[indexPath.row]
            }
            
            cell.bgView.layer.cornerRadius = 10
            
            return cell
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionCell", for: indexPath) as! PaymentViewController
            cell.paymentImage.image = otherArray[indexPath.row]
            if Utility.isArabicSelected()
            {
                cell.titleLabel.text = self.otherTitles_Ar[indexPath.row]
            }
            else
            {
                cell.titleLabel.text = self.otherTitles[indexPath.row]
            }
            
            cell.bgView.layer.cornerRadius = 10
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        print ("Collection Tag: \(collectionView.tag)")
        
        self.searchMode = nil
        
        if (collectionView == newsCollectionViewOutlet)
        {
            
           if let item = rssItems?[indexPath.row]
            {
                self.selectedImageURL = item.image
                self.selectedDescription = item.description
                self.selectedTitle = item.title
//                self.selectedImageURL = self.mainNewsImgURL[indexPath.row] as? String ??  " "
//                self.selectedDescription = self.mainNewsDescription[indexPath.item] as? String ?? " "
//                self.selectedTitle = self.mainNewsTitle[indexPath.item] as? String ?? " "
                self.performSegue(withIdentifier: "destinationSegue", sender: self)
            }
           
            
        }else if (collectionView == paymentCollectionViewOutlet){
            print("Happened.....!")
            self.itemImg = self.paymentArray[indexPath.row]
            self.itemImgN = self.paymentArray[indexPath.row]
            self.itemTitleN = self.paymentTitles[indexPath.row]
           
            let his = History()
            if Utility.isArabicSelected()
            {
                self.itemTitleN = self.paymentTitles_Ar[indexPath.row]
                 self.tagN = his.getcollectionTags()[his.getIndexFor(array:self.paymentTitles_Ar , item: self.itemTitleN )] //collectionView.tag
                self.tagItem = History().getItemTags()[his.getIndexFor(array:self.paymentTitles_Ar , item: self.itemTitleN )]

            }
            else
            {
                self.itemTitleN = self.paymentTitles[indexPath.row]
                self.tagN = his.getcollectionTags()[his.getIndexFor(array:self.paymentTitles , item: self.itemTitleN )]//collectionView.tag
                self.tagItem = History().getItemTags()[his.getIndexFor(array:self.paymentTitles , item: self.itemTitleN )]
                
            }
            
            self.performSegue(withIdentifier: "allServices", sender: self)
        }
        
        if (collectionView.tag == 0)
        {
            return
        }
        else if (collectionView.tag == 1)
        {
            if Utility.isArabicSelected()
               {
                   if govtTitles_Ar[indexPath.row] == "وسائل الإعلام" || govtTitles_Ar[indexPath.row] == "التبرعات"         {
                         SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                        return
                     }
                     else
                      {
                          self.itemImgN = govtArray[indexPath.row]
                           if Utility.isArabicSelected() {
                               self.itemTitleN = self.govtTitles_Ar[indexPath.row]
                           } else {
                               self.itemTitleN = self.govtTitles[indexPath.row]
                           }
                           History().addServiceToHistory(title:  self.govtTitles[indexPath.row], title_Ar: self.govtTitles_Ar[indexPath.row], Image: govtArray[indexPath.row]!, CollectionTag: collectionView.tag, itemTag: indexPath.row)
                      }
               }
               else
               {
                   if govtTitles[indexPath.row] == "Media" || govtTitles[indexPath.row] == "Donations"
                    {
                      SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                        return
                    }
                    else
                   {
                    
                    if Utility.isArabicSelected()
                    {
                           self.itemImgN = govtArray[indexPath.row]
                           if Utility.isArabicSelected() {
                               self.itemTitleN = self.govtTitles_Ar[indexPath.row]
                           } else {
                               self.itemTitleN = self.govtTitles[indexPath.row]
                           }
                           History().addServiceToHistory(title:  self.govtTitles[indexPath.row], title_Ar: self.govtTitles_Ar[indexPath.row], Image: govtArray[indexPath.row]!, CollectionTag: collectionView.tag, itemTag: indexPath.row)
                        
                    }
                    else
                    {
                    
                            self.itemImgN = govtArray[indexPath.row]
                            if Utility.isArabicSelected() {
                                self.itemTitleN = self.govtTitles_Ar[indexPath.row]
                            } else {
                                self.itemTitleN = self.govtTitles[indexPath.row]
                            }
                            History().addServiceToHistory(title:  self.govtTitles[indexPath.row], title_Ar: self.govtTitles_Ar[indexPath.row], Image: govtArray[indexPath.row]!, CollectionTag: collectionView.tag, itemTag: indexPath.row)
                      
                    }
                       
                   }
                   
               }
            //            self.tagN = 1
        }
        else if (collectionView.tag == 2)
        {
            
            if Utility.isArabicSelected()
            {
                if self.otherTitles[indexPath.row] == "منظم الدواء"
                {
                     SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                    return
                }
                else
                {
                    self.itemImg = self.otherArray[indexPath.row]
                    self.itemImgN = otherArray[indexPath.row]
                    self.itemTitleN = self.otherTitles[indexPath.row]
                }
            }
            else
            {
                if self.otherTitles[indexPath.row] == "Medicine Reminder"
                {
                     SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                    return
                }
                else
                {
                    self.itemImg = self.otherArray[indexPath.row]
                    self.itemImgN = otherArray[indexPath.row]
                    self.itemTitleN = self.otherTitles[indexPath.row]
                }
            }
            
            //            self.tagN = 2
        }
        
        self.tagN = collectionView.tag
        self.tagItem = indexPath.row
        
        self.performSegue(withIdentifier: "allServices", sender: self)
     
    }
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == newsCollectionViewOutlet)
        {
            return CGSize(width: 304, height: 191)
        }
        else if (collectionView == paymentCollectionViewOutlet)
        {
            return CGSize(width: 120, height: 82)
        }
        else if (collectionView == govtServicesCollectionOutlet)
        {
            return CGSize(width: 120, height: 82)
        }
        else
        {
            return CGSize(width: 120, height: 82)
        }
    }
}

extension ViewController{
    
    
    func getNewsToken(){
        
        self.showNewsLoader()
        
        let webURL = "http://newapi.sharjah24.ae/api/oauth/token?clientId=V3063K627O464F9CA5C43PU9E53DB205"
        
        //"https://stg-smtshjapp.shj.ae/api/GetDailyFlights?fromDate=\(self.fromDate.titleLabel!.text!)&toDate=\(self.toDate.titleLabel!.text!)&flightType=\(self.flightType)";
        print ("URL: \(webURL)")
        manager.request(URL(string: webURL)!).responseJSON { (response) in
            SmartSharjahShareClass.hideActivityIndicator(view: self.view)
            print("Token Rsponse: \(response.result)")
            if (response.error != nil)
            {
                print ("Error 501, \(response.error ?? "" as! Error)")
                self.hideNewsLoader()
            }
            else
            {
                
                if let value = response.result.value as? NSDictionary{
                    
                    if let token = value.value(forKey: "Token") as? String
                    {
                        self.getNewsArticles(token: token)
                    }
                }
            }
        }
    }
    
    func getNewsArticles(token: String)
    {
        
        let webURL = "https://newapi.sharjah24.ae/api/Articles?$top=5"
        let headers = ["Authorization": "access \(token)"]
        //        print("Headers: \(headers)")
        
        
        Alamofire.request(URL(string: webURL)!, method: .get, parameters: [:], headers: headers).responseJSON { (response) in
            
            if (response.error != nil)
            {
                print ("Error 001, \(response.error)")
                self.hideNewsLoader()
            }
            else
            {
                if let resp = response.result.value as? NSDictionary{
                    
                    if let val = resp.value(forKey: "value") as? [NSDictionary]
                    {
                        print("Articles count: \(val.count)")
                    }
                    
                    self.getNewsArticlesMedia(token: token)
                }
            }
        }
    }
    
    func getNewsArticlesMedia(token: String)
    {
        
        let webURL = "https://newapi.sharjah24.ae/api/ArticlesMediaFiles?$top=5"
        let headers = ["Authorization": "access \(token)"]
        //        print("Headers: \(headers)")
        
        
        Alamofire.request(URL(string: webURL)!, method: .get, parameters: [:], headers: headers).responseJSON { (response) in
            
            if (response.error != nil)
            {
                print ("Error 001, \(response.error)")
                self.hideNewsLoader()
            }
            else
            {
                if let resp = response.result.value as? NSDictionary{
                    
                    if let val = resp.value(forKey: "value") as? [NSDictionary]
                    {
                        print("Articles Media count: \(val.count)")
                        
                        
                        
                        if val.count > 0
                        {
                            
                            for item in val
                            {
                                if let url = item.value(forKey: "ImageURL") as? String
                                {
                                    self.newsImgURL.append("\(self.imgBaseURL)"+"\(url)")
                                }
                            }
                        }
                    }
                    //                    self.newsCollectionViewOutlet.reloadData()
                    
                    self.getNewsArticlesStories(token: token)
                }
            }
        }
    }
    
    func getNewsArticlesStories(token: String)
    {
        
        let webURL = "https://newapi.sharjah24.ae/api/ArticlesStories?$top=5"
        let headers = ["Authorization": "access \(token)"]
        //        print("Headers: \(headers)")
        
        
        Alamofire.request(URL(string: webURL)!, method: .get, parameters: [:], headers: headers).responseJSON { (response) in
            
            if (response.error != nil)
            {
                print ("Error 001, \(response.error)")
                self.hideNewsLoader()
            }
            else
            {
                if let resp = response.result.value as? NSDictionary{
                    if let val = resp.value(forKey: "value") as? [NSDictionary]
                    {
                        print("Articles stories count: \(val)")
                        
                        if val.count > 0
                        {
                            for item in val
                            {
                                if let title = item.value(forKey: "Title") as? String
                                {
                                    self.newsTitle.append(title)
                                }
                                if let body = item.value(forKey: "Body") as? String
                                {
                                    self.newsDescription.append(body)
                                }
                            }
//                            self.newsCollectionViewOutlet.reloadData()
                        }
                        print("Total news: \(self.newsDescription.count)")
                        self.hideNewsLoader()
//                        self.newsCollectionViewOutlet.reloadData()
                    }
                }
            }
        }
    }
}

extension ViewController{
    
    func saveLookupsData(key: String, value: String)
    {
        let userDef = UserDefaults.standard
        userDef.set(value, forKey: key)
        userDef.synchronize()
    }
    
    func getData(){
        
        APILayer().getDataFromAPI(name: "GetContactType", method:.get, path: "api/ContactTypeController/GetListContactType", params: [:], headers: [:]) { (successGetContactType, GetContactType) in
            
            if (successGetContactType)
            {
                
                let arr = APILayer().resolveData(input: GetContactType!, language: "EN")
                let css = arr.joined(separator: ",")
                self.saveLookupsData(key: "contactTypeLookups", value: css)
                
                APILayer().getDataFromAPI(name: "GetGender", method:.get, path: "api/GenderController/GetListGender", params: [:], headers: [:]) { (successGetGender, GetGetGender) in
                    
                    if (successGetGender)
                    {
                        let arr = APILayer().resolveData(input: GetGetGender!, language: "EN")
                        let css = arr.joined(separator: ",")
                        self.saveLookupsData(key: "genderLookups", value: css)
                        
                        
                        APILayer().getDataFromAPI(name: "GetHcCategory", method:.get, path: "api/HcCategoryController/GetListHcCategory", params: [:], headers: [:]) { (successGetHcCategory, GetGetHcCategory) in
                            
                            if (successGetHcCategory)
                            {
                                
                                let arr = APILayer().resolveData(input: GetGetHcCategory!, language: "EN")
                                let css = arr.joined(separator: ",")
                                //                                        self.maritalStatusTF.options = css
                                self.saveLookupsData(key: "hcCategoryLookUps", value: css)
                                
                                
                                APILayer().getDataFromAPI(name: "GetMaritalStatus", method:.get, path: "api/MaritalStatusController/GetMaritalStatus", params: [:], headers: [:]) { (successGetMaritalStatus, GetGetMaritalStatus) in
                                    
                                    if (successGetMaritalStatus)
                                    {
                                        
                                        let arr = APILayer().resolveData(input: GetGetMaritalStatus!, language: "EN")
                                        let css = arr.joined(separator: ",")
                                        //                                        self.maritalStatusTF.options = css
                                        self.saveLookupsData(key: "maritalStatusLookUps", value: css)
                                        
                                        APILayer().getDataFromAPI(name: "GetVolPeriod", method:.get, path: "api/VolController/VolPeriod", params: [:], headers: [:]) { (successGetVolPeriod, GetVolPeriod) in
                                            
                                            if (successGetVolPeriod)
                                            {
                                                let arr = APILayer().resolveData(input: GetVolPeriod!, language: "EN")
                                                let css = arr.joined(separator: ",")
                                                self.saveLookupsData(key: "volPeriodLookups", value: css)
                                                
                                                APILayer().getDataFromAPI(name: "GetVolCategoryType", method:.get, path: "api/VolController/VolCategoryType", params: [:], headers: [:]) { (successGetVolCategoryType, GetVolCategoryType) in
                                                    
                                                    if (successGetVolCategoryType)
                                                    {
                                                        
                                                        let arr = APILayer().resolveData(input: GetVolCategoryType!, language: "EN")
                                                        let css = arr.joined(separator: ",")
                                                        self.saveLookupsData(key: "volCategoryTypeLookups", value: css)
                                                        
                                                        APILayer().getDataFromAPI(name: "GetConsultationType", method:.get, path: "api/ConsultationController/GetListConsultationType", params: [:], headers: [:]) { (successGetConsultationType, GetConsultationType) in
                                                            
                                                            if (successGetConsultationType)
                                                            {
                                                                let arr = APILayer().resolveData(input: GetConsultationType!, language: "EN")
                                                                let css = arr.joined(separator: ",")
                                                                self.saveLookupsData(key: "consultationTypeLookups", value: css)
                                                                
                                                                APILayer().getDataFromAPI(name: "GetConsultationCategory", method:.get, path: "api/ConsultationController/GetListConsultationCategory", params: [:], headers: [:]) { (successGetConsultationCategory, GetConsultationCategory) in
                                                                    
                                                                    if (successGetConsultationCategory)
                                                                    {
                                                                        let arr = APILayer().resolveData(input: GetConsultationCategory!, language: "EN")
                                                                        let css = arr.joined(separator: ",")
                                                                        self.saveLookupsData(key: "consultationCategoryLookups", value: css)
                                                                    }
                                                                    else
                                                                    {
                                                                        print("*Error")
                                                                    }
                                                                }
                                                            }
                                                            else
                                                            {
                                                                print("*Error")
                                                            }
                                                        }
                                                    }
                                                    else
                                                    {
                                                        print("*Error")
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                print("*Error")
                                            }
                                        }
                                    }
                                    else
                                    {
                                        print("*Error")
                                    }
                                }
                            }
                            else
                            {
                                print("*Error")
                            }
                        }
                    }
                    else
                    {
                        print("*Error")
                    }
                }
                
            }
            else
            {
                print ("*Error")
            }
        }
    }
    
    
    
    //MARK:- Custom methods
    func getXMLDataFromServer(lang: String){

//
        let url = NSURL(string: "http://sharjah24.ae/" + lang + "/rss")

        //Creating data task
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in

            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
            else
            {
                let parser = XMLParser(data: data!)
                parser.delegate = self
                parser.parse()
            }



        }

        task.resume()

    }
    
    func displayOnUI(){
        //    ipAddressLabel.text = ipAddr
        //    countryCodeLabel.text = heading
        //    countryNameLabel.text = webLink
        //    latitudeLabel.text = details
        //    longitudeLabel.text = thumbImg
    }
    
    //MARK:- XML Delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        if elementName == "Response" {
            print("Started parsing...")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespaces)
        
        let dc =  DataClass.init()
        let newsDic: NSMutableDictionary = [:]
        if (!foundedChar.isEmpty) {
            if currentParsingElement == "pubDate" {
                dc.pubdate += foundedChar
                
            }
            else if currentParsingElement == "title" {
                dc.title += foundedChar.htmlToString
                newsDic["title"] = foundedChar
                
            }
            else if currentParsingElement == "link" {
                dc.link += foundedChar
                
            }
            else if currentParsingElement == "description" {
                dc.description += foundedChar.htmlToString
                newsDic["description"] = foundedChar
            }
            else if currentParsingElement == "media:thumbnail" {
//                print ("Found: \(foundedChar)")
                var i = ""
                var all = foundedChar.components(separatedBy: "https://")
                if (all.count > 0)
                {
                    dc.thumbnail = "https://\(all.last!)"
                    i = "https://\(all.last!)"
//                    print ("imgFound: \(dc.thumbnail)")
                }
                else
                {
                    i = "no img"
                    dc.thumbnail = "no img"
                    print ("imgFound: nil")
                }
                
                newsDic["image"] = i
            }
            dataArray.add(dc)
            
            if  dc.thumbnail.isEmpty  {
//                mainNewsImgURL.add("dc.thumbnail")
            }
            else{
                mainNewsImgURL.add(dc.thumbnail)
            }
           
            if newsDic != [:]
            {
               self.newsArray.append(newsDic)
                self.newsDictionary = [:]
                print("added to news...")
            }
            else
            {
                 print("Not added to news...")
            }
                   
        }
       
        
    }
    
    
    func newsExistsAlready(title: String) -> Bool
    {
        if self.newsArray.count > 0
        {
            for t in self.newsArray
            {
                if title == t["title"] as! String
                {
                    return true
                }
            }
        }
         return false
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("--------Total News items in Ditionary: \(self.newsArray.count) \n first item: \(self.newsArray.first!)")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    func getNewsRSS(lang: String){
        //    let url = "http://sharjah24.ae/en/rss"
        let url =  "http://sharjah24.ae/" + lang + "/rss"
        if Reachability.isConnectedToNetwork()
        {
            self.showNewsLoader()
            Alamofire.request(url).responseRSS() { (response) -> Void in
                self.hideNewsLoader()

                if let feed: RSSFeed = response.result.value {
                    
//                    print ("FeedItem: \(feed)")
                    
                    self.newsArr = feed.items
                    
                    
//                    do something with your new RSSFeed object!
                    for item in feed.items {
//                        print(item)

                        self.mainNewsTitle.add(item.title!)
                        var modifiedStr = ""


//                        print("ORIGINAL")
                        if (lang == "en")
                        {
                            modifiedStr =  item.description.stripped.replacingOccurrences(of: "24&#58", with: "").replacingOccurrences(of: "WAM&#5", with: "")
                        }
                        else
                        {
                            modifiedStr =  "\(item)"
                        }


//                        print ("*modified: \(modifiedStr)")
                        self.mainNewsDescription.add(modifiedStr)



                    }
                    
//                    print("****************Total News items in Ditionary: \(self.newsDictionary.count)")
//                    self.newsCollectionViewOutlet.reloadData()
                }
                
            }
        }
        else
        {
            let alert = UIAlertController(title: "No Internet Connection".localized(), message: "Make sure your device is connected to the internet.".localized(), preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "OK", style: .default) { (action) in
                //
            }
            alert.addAction(okBtn)
            UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true)
        }
        
    }
    
}
//==end
