//
//  DashboardVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class DashboardVC: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fajr: UILabel!
    @IBOutlet weak var duhr: UILabel!
    @IBOutlet weak var asr: UILabel!
    @IBOutlet weak var maghrib: UILabel!
    @IBOutlet weak var isha: UILabel!
    
    var searchMode: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.navBar != nil)
        {
            if Utility.isArabicSelected()
            {
                self.navBar.title.text = "لوحة البيانات"
            }
            else
            {
                self.navBar.title.text = "Dashboard"
            }
            
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: true)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: self.scrollView.frame.height*1.25)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.searchPressed), name: NSNotification.Name(rawValue: "searchPressed"), object: nil)
        
        
        self.getNamazTime()
        // Do any additional setup after loading the view.
    }
    
    func getNamazTime() {
        
        var url = URL(string: "https://sia.gov.ae/prayers/timing/sharjah")!
        
        Alamofire.request(url).responseJSON { (response) in
            
            if (response.error != nil)
            {
                print ("Error Namaz Times, \(response.error)")
//                completion(false, [])
            }
            else
            {
                if let value = response.result.value as? NSDictionary {
                    
                    print ("value: \(value)")
                    
                    if let fajr = value.value(forKey: "fajar") as? String{
                        self.fajr.text = fajr
                    }
                    if let fajr = value.value(forKey: "zhuar") as? String{
                        self.duhr.text = fajr
                    }
                    if let fajr = value.value(forKey: "asar") as? String{
                        self.asr.text = fajr
                    }
                    if let fajr = value.value(forKey: "magrib") as? String{
                        self.maghrib.text = fajr
                    }
                    if let fajr = value.value(forKey: "ishha") as? String{
                        self.isha.text = fajr
                    }
                    
                }
            }
        }
        
        
    }
    
    @objc func searchPressed()
    {
        //        print("searchPressed...")
        self.searchMode = true
        self.performSegue(withIdentifier: "allServices", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "allServices"
        {
            
                let destNav = segue.destination as! UINavigationController
                
                let dest = destNav.viewControllers[0] as! ServicesListVC
                dest.searchMode = self.searchMode
          
        }
    }
}
