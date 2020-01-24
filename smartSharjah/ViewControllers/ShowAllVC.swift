//
//  ShowAllVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ShowAllVC: UIViewController {

    @IBOutlet weak var navbar: NavBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var type:String!
    var itemImg:UIImage!
    var itemTitle:String!
    var tag: Int!
    
    var itemImgN:UIImage!
    var itemTitleN:String!
    var tagItem: Int!
    var tagN: Int!
    
    var imageArray = [UIImage(named: "news2"),
                      UIImage(named: "news3"),
                      UIImage(named: "news2"),
                      UIImage(named: "news3"),
                      UIImage(named: "news2"),
                      UIImage(named: "news3"),
                      UIImage(named: "news2"),
                      UIImage(named: "news3")]
    
    var paymentArray = [UIImage(named: "pay1"),
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
    
    let columnLayout = FlowLayout(
        cellsPerRow: 5,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (collectionView.tag == 0)
        {
            let history = History()
            self.paymentArray = history.getImages()
            self.paymentTitles = history.getTitles()
            self.paymentTitles_Ar = history.getTitles_Ar()
            self.collectionView.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Utility.isArabicSelected() {
            otherTitles = ["تذكير الطب"]
        }
        
        self.collectionView.tag = self.tag
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        if (self.navbar != nil)
        {
            navbar.title.text = type
            self.navbar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "allServices")
        {
            let destNav = segue.destination as! UINavigationController
            let dest = destNav.viewControllers[0] as! ServicesListVC
            dest.itemImg = self.itemImgN
            dest.itemTitle = self.itemTitleN
            dest.tagN = self.tagN
            dest.tagIndex = self.tagItem
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

extension ShowAllVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.tag == 0)
        {
            self.itemImgN = paymentArray[indexPath.row]
            self.itemTitleN = self.paymentTitles[indexPath.row]
//            if Utility.isArabicSelected()
//            {
//                if UserDefaults.standard.object(forKey: "username") == nil  && self.govtTitles[indexPath.row] == "الخدمات الاجتماعية"
//                {
//                  SetDefaultWrappers().showAlert(info: loginToUseFeatureMsg.localized(), viewController: self)
//                }
//                else
//                {
//                    self.itemTitleN = self.paymentTitles_Ar[indexPath.row]
//                }
//
//            }
//            else
//            {
//                if UserDefaults.standard.object(forKey: "username") == nil  && self.govtTitles[indexPath.row] == "Social Services"
//                {
//                  SetDefaultWrappers().showAlert(info: loginToUseFeatureMsg.localized(), viewController: self)
//                }
//                else
//                {
//                    self.itemTitleN = self.paymentTitles[indexPath.row]
//                }
                
//            }
            
//            self.tagN = 0
        }
        else if (collectionView.tag == 1)
        {
            if indexPath.row == 3 || indexPath.row == 10
                            {
                               SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                                return
                           }
            //                else if UserDefaults.standard.object(forKey: "username") == nil  && self.govtTitles[indexPath.row] == "Social Services"
            //                {
            //                  SetDefaultWrappers().showAlert(info: loginToUseFeatureMsg.localized(), viewController: self)
            //                }
                           else
                            {
                                self.itemImgN = govtArray[indexPath.row]
                                 if Utility.isArabicSelected() {
                                     self.itemTitleN = self.govtTitles_Ar[indexPath.row]
                                 } else {
                                     self.itemTitleN = self.govtTitles[indexPath.row]
                                 }
                                 History().addServiceToHistory(title:
                                        self.govtTitles[indexPath.row], title_Ar: self.govtTitles_Ar[indexPath.row], Image: govtArray[indexPath.row]!, CollectionTag: collectionView.tag, itemTag: indexPath.row)
                            }
            
            /*if Utility.isArabicSelected()
            {
                if govtTitles_Ar[indexPath.row] == "وسائل الإعلام" || govtTitles_Ar[indexPath.row] == "التبرعات"
                 {
                      SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                    return
                  }
//                else if UserDefaults.standard.object(forKey: "username") == nil  && self.govtTitles[indexPath.row] == "الخدمات الاجتماعية"
//                   {
//                     SetDefaultWrappers().showAlert(info: loginToUseFeatureMsg.localized(), viewController: self)
//                   }
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
//                else if UserDefaults.standard.object(forKey: "username") == nil  && self.govtTitles[indexPath.row] == "Social Services"
//                {
//                  SetDefaultWrappers().showAlert(info: loginToUseFeatureMsg.localized(), viewController: self)
//                }
               else
                {
                    self.itemImgN = govtArray[indexPath.row]
                     if Utility.isArabicSelected() {
                         self.itemTitleN = self.govtTitles_Ar[indexPath.row]
                     } else {
                         self.itemTitleN = self.govtTitles[indexPath.row]
                     }
                     History().addServiceToHistory(title:
                            self.govtTitles[indexPath.row], title_Ar: self.govtTitles_Ar[indexPath.row], Image: govtArray[indexPath.row]!, CollectionTag: collectionView.tag, itemTag: indexPath.row)
                }
                
            }*/
            
           
//            self.tagN = 1
        }
        else if (collectionView.tag == 2)
        {
            if Utility.isArabicSelected()
              {
                  if self.otherTitles_Ar[indexPath.row] == "منظم الدواء"
                  {
                       SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                    return
                  }
                  
              }
              else
              {
                  if self.otherTitles[indexPath.row] == "Medicine Reminder"
                  {
                       SetDefaultWrappers().showAlert(info:"Coming soon...".localized(), viewController: self)
                    return
                  }
                 
              }
//            self.itemImgN = otherArray[indexPath.row]
//            if Utility.isArabicSelected()
//            {
//                self.itemTitleN = "تذكير الطب"
//            }else{
//                self.itemTitleN = self.otherTitles[indexPath.row]
//            }
//            self.tagN = 2
        }
        
        
        if (collectionView.tag == 0)
        {
            let his = History()
            if Utility.isArabicSelected()
            {
                self.tagN = his.getcollectionTags()[his.getIndexFor(array:self.paymentTitles_Ar , item: self.itemTitleN )] //collectionView.tag
                self.tagItem = History().getItemTags()[his.getIndexFor(array:self.paymentTitles_Ar , item: self.itemTitleN )] //indexPath.row
            }
            else
            {
                self.tagN = his.getcollectionTags()[his.getIndexFor(array:self.paymentTitles , item: self.itemTitleN )]//collectionView.tag
                self.tagItem = History().getItemTags()[his.getIndexFor(array:self.paymentTitles , item: self.itemTitleN )]
            }

        }
        else
        {
            self.tagN = collectionView.tag
            self.tagItem = indexPath.row
        }
        
        self.performSegue(withIdentifier: "allServices", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (collectionView.tag == 0){
//            return imageArray.count
//        }
//        else
        if (collectionView.tag == 0)
        {
            return paymentArray.count
            
        }
        else if (collectionView.tag == 1)
        {
            return govtArray.count
        }
        else if (collectionView.tag == 2)
        {
            return otherArray.count
        }
        
        return otherArray.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
//        if (collectionView.tag == 0)
//        {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! NewsViewController
//            cell.imgImage.image = imageArray[indexPath.row]
//
//            //cell.imgImage.tag = indexPath.row
//            return cell
//        }
//        else
        
            if (collectionView.tag == 0)
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
        else if (collectionView.tag == 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! PaymentViewController
            cell.paymentImage.image = govtArray[indexPath.row]
            
            if Utility.isArabicSelected() {
                cell.titleLabel.text = self.govtTitles_Ar[indexPath.row]
            } else {
                cell.titleLabel.text = self.govtTitles[indexPath.row]
            }
            cell.bgView.layer.cornerRadius = 10
            
            return cell
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! PaymentViewController
            cell.paymentImage.image = otherArray[indexPath.row]
            if Utility.isArabicSelected()
            {
                cell.titleLabel.text = self.otherTitles_Ar[indexPath.row]
            }
            else {
                cell.titleLabel.text = self.otherTitles[indexPath.row]
            }
            
            cell.bgView.layer.cornerRadius = 10
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionCell", for: indexPath) as! PaymentViewController
        
        return cell
        
        
    }
    
    
}

extension ShowAllVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120 , height: 100)
    }
}
