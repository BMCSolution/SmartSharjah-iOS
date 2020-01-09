//
//  MainTabVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 16/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import SideMenu

class MainTabVC: UITabBarController {

    
    var menuLeftNavigationController: UISideMenuNavigationController!
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setNots()
        
        if Utility.isArabicSelected()
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    func setNots()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.logout), name: NSNotification.Name(rawValue: "Logout"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.gotoLogin), name: NSNotification.Name(rawValue: "GoToLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openMenu), name: NSNotification.Name(rawValue: "openMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.login), name: NSNotification.Name(rawValue: "Login"), object: nil)
        self.configureSideMenu()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.SideMenuPressed), name: NSNotification.Name(rawValue: "SideMenuPressed"), object: nil)
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.settingsPressed), name: NSNotification.Name(rawValue: "SettingsPressed"), object: nil)
        
        
    }
    
    @objc func settingsPressed()
    {
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        
            self.performSegue(withIdentifier: "OpenSettings", sender: self) 
        }
        
        
    }
    
    @objc func gotoLogin() {
        
//        print ("Closing!!")
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func SideMenuPressed() {
                self.menuLeftNavigationController.dismiss(animated: true, completion: nil)
    }
    
    @objc func login() {
//       self.dismiss(animated: true, completion: nil)
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
               
               UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                   window.rootViewController = vc
                   window.makeKeyAndVisible()
               })
    }
    
    func configureSideMenu()
    {
        //        menuLeftNavigationController: UISideMenuNavigationController!
        
        menuLeftNavigationController = nil
        let sb = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        menuLeftNavigationController = sb.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        if Utility.isArabicSelected()
        {
            SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController
        }
        else
        {
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        }
        
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuPushStyle = .subMenu
        SideMenuManager.default.menuAllowPushOfSameClassTwice = true
        SideMenuManager.default.menuDismissOnPush = true
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width * 0.8
        //        SideMenuManager.menuBlurEffectStyle = UIBlurEffectStyle.dark
        SideMenuManager.default.menuShadowRadius = 10
        SideMenuManager.default.menuShadowColor = UIColor.black
        SideMenuManager.default.menuShadowOpacity = 1
        SideMenuManager.default.menuFadeStatusBar = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            
            if let username = UserDefaults.standard.value(forKey: "username") as? String{
                
                print("Username: \(username)")
            }
            else{
                print("*No Username")
                
                let arrayOfTabBarItems = self.tabBar.items
                
                
                
                if let barItems = arrayOfTabBarItems, barItems.count > 0 {
                    let tabBarItem1 = barItems[1]
                    let tabBarItem2 = barItems[2]
                    let tabBarItem3 = barItems[3]
                    tabBarItem1.isEnabled = false
                    tabBarItem2.isEnabled = false
                    tabBarItem3.isEnabled = false
//                    tabBarItem1.isEnabled = true
//                    tabBarItem2.isEnabled = true
//                    tabBarItem3.isEnabled = true
                }
            }
            
        }
    }
    
    @objc func openMenu(){
        
        if let topVC = UIApplication.topViewController() as? MenuVC{
            print ("Already presented :\(topVC)")
        }
        else{
//            print("Top VC: \(UIApplication.topViewController())")
            self.present(menuLeftNavigationController, animated: true, completion: nil)
        }
        
        
        
    }
    
    @objc func logout() {
        
        print ("Logged out...!!")
        self.dismiss(animated: true, completion: nil)
        NavBar().restartApplicationOnLogout()

    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    }

}
