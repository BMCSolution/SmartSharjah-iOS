//
//  StartingVC.swift
//  smartSharjah
//
//  Created by Usman on 15/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Crashlytics

class StartingVC: UIViewController {

    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
   
    @IBOutlet weak var bg: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    var isLangChanged = false
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isLangChanged
        {
            print("Lang changed...!!!!")
            isLangChanged = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //       UIView.appearance().semanticContentAttribute = .forceLeftToRight
        if (UserDefaults.standard.value(forKey: "rememberMe") != nil ) || (UserDefaults.standard.value(forKey: "fullName") != nil){
//            self.performSegue(withIdentifier: "rememberMe", sender: self)
        }
        
//        Crashlytics().crash()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target : self, action : #selector(handleTap))
        self.backImage.addGestureRecognizer(tap)
        
        let up = UISwipeGestureRecognizer(target : self, action : #selector(upSwipe))
        up.direction = .up
        self.view.addGestureRecognizer(up)
    }
    
    @objc func upSwipe()
    {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }

    @objc func handleTap()
    {
        SetDefaultWrappers().showAlert(info: "Select a Language or swipe up for Login".localized(), viewController: self)
    }
    
    @IBAction func changeLanguagePressed(_ sender: UIButton) {
        
        
        print("Current language: \(LanguageManager.currentLanguageString()!)")
        if sender.tag == 1 {
             print("Arabic pressed")
            if Utility.isArabicSelected() == false {
                LanguageManager.saveLanguage(by: 1)// Arabic is at 1 index
                LanguageManager.setupCurrentLanguage()
                print("Current language after change: \(LanguageManager.currentLanguageString()!)")
            }
            else
            {
                print("Arabic selected already")
            }
        }else{
           print("English pressed")
            if Utility.isArabicSelected() == true {

                LanguageManager.saveLanguage(by: 0) // English is at 0 index
                LanguageManager.setupCurrentLanguage()
            }
        }
        
        self.restartApplication()
//        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    
    
    func restartApplication () {
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
            vc.isLangChanged = true
        
//        UIView.transition(with: window, duration: 0.0, options: .transitionCrossDissolve, animations: {
                 window.rootViewController = vc
                  window.makeKeyAndVisible()
                
//            })
        
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
