//
//  NavBar.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//
// First iOS code of my life (5 yeears of Professional Career)

import UIKit
import DropDown
import SideMenu

class NavBar: UIView {

    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var title: UILabel!
    var navController: UINavigationController?
    @IBOutlet var contentView: NavBar!
    var menuShown = false
    var dropDownMenu = DropDown()
    
    
    
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        print ("Back Pressed")
        if (self.navController!.viewControllers.count > 1)
        {self.navController?.popViewController(animated: true)}
        else{
            self.navController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        print ("Menu Pressed")
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openMenu"), object: nil)
    }
    
    @IBAction func optionsBtnPressed(_ sender: UIButton) {
        print ("Menu options Pressed")
        dropDownMenu.show()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchPressed"), object: nil)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func menuSettings(navController: UINavigationController?, menuShown: Bool){
        
        if (navController != nil)
        {
            self.navController = navController!
        }
        self.menuShown = menuShown
        
        if (!menuShown)
        {
            self.backBtn.isHidden = false
            
            if Utility.isArabicSelected()
            {
                let backImage = UIImage(named: "forward")
                self.backBtn.setImage(backImage, for: .normal)
            }
            
            self.searchBtn.isHidden = true
            self.optionsBtn.isHidden = true
            self.menuBtn.isHidden = true
        }
        else
        {
            self.backBtn.isHidden = true
            self.searchBtn.isHidden = false
            self.optionsBtn.isHidden = false
            self.menuBtn.isHidden = false
        }
        
        if (self.navController != nil)
        {
            
        }
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("Navbar", owner: self, options: nil)
        self.configureDropDwon()
//        self.configureSideMenu()
        addSubview(self.contentView)

        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func configureDropDwon() -> () {
        // The view to which the drop down will appear on
        dropDownMenu.anchorView = self.menuBtn
        dropDownMenu.direction = .bottom
        if let username = UserDefaults.standard.value(forKey: "username") as? String{
            
            if Utility.isArabicSelected()
            {
                dropDownMenu.dataSource =  ["English","تـسجيل الخروج"]
            }
            else
            {
                dropDownMenu.dataSource =  ["العربية","Logout"]
            }
            
        }
        else
        {
            if Utility.isArabicSelected()
            {
                dropDownMenu.dataSource =  ["English","تسجيل الدخول"]
            }
            else
            {
                dropDownMenu.dataSource =  ["العربية","Login"]
            }
        }
       
        
        
        dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)!)
        dropDownMenu.width = UIScreen.main.bounds.width  //view.frame.size.width
        // Action triggered on selection
      
        dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
//            print("Current language before change \(LanguageManager.currentLanguageString()!)")
            if item == "العربية"
            {
//                LanguageManager.saveLanguage(by: 1)// Arabic is at 1 index
//                LanguageManager.setupCurrentLanguage()
//                self.changeRootVC()
                LanguageManager.saveLanguage(by: 1)
                LanguageManager.setupCurrentLanguage()
                self.changeRootVC()
            }
            else if item == "English"
            {
                print("change to english called")
                LanguageManager.saveLanguage(by: 0)// English is at 1 index
                LanguageManager.setupCurrentLanguage()
                self.changeRootVC()
//                 print("Current language before change \(LanguageManager.currentLanguageString()!)")
            }
            else if item == "Logout" || item == "تـسجيل الخروج"
            {
                History().removeServices()
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: "username")
                userDefaults.removeObject(forKey: "fullName")
                userDefaults.removeObject(forKey: "user_image")
                userDefaults.removeObject(forKey: "rememberMe")
                userDefaults.removeObject(forKey: "user")
                userDefaults.synchronize()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Logout"), object: nil)
            }
            else if item == "Login" || item == "تسجيل الدخول"
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Login"), object: nil)
            }
            
            self.dropDownMenu.hide()
            
        }
    }
    
    func changeRootVC()
    {
        print("change root vc called")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
//        appDelegate.window?.rootViewController = vc
//        appDelegate.window?.makeKeyAndVisible()
       
       
        UserDefaults.standard.set("langChanged", forKey: "langChanged")
        UserDefaults.standard.synchronize()
//
        if let topVC = UIApplication.topViewController()
        {
            topVC.dismiss(animated: true, completion: nil)
        }
        
        self.restartApplication()
    }
    
    func restartApplication() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
                return
            }
        
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        })
        
    }
    
    
    
    func restartApplicationOnLogout() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "StartingVC") as! StartingVC
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
                return
        }
        
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        })
        print("Logged out called....")
        SetDefaultWrappers().showAlert(info: "You have successfully logged out".localized(), viewController: vc)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
