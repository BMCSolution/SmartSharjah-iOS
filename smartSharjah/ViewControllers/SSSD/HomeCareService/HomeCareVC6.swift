//
//  HomeCareVC6.swift
//  smartSharjah
//
//  Created by Usman on 13/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import MobileCoreServices


class HomeCareVC6: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var navbar: NavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var qualificationTF: TextField!
    @IBOutlet weak var graduationYearTF: TextField!
    @IBOutlet weak var specialityTF: TextField!
    @IBOutlet weak var cvTF: TextField!
    @IBOutlet weak var licenseTF: TextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    
    
    
    func getAllTextFields(fromView view: UIView)-> [TextField] {
        return view.subviews.flatMap { (view) -> [TextField]? in
            if view is TextField {
                return [(view as! TextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
       }
    
    func validated() -> Bool{
        
        
        
        for x in getAllTextFields(fromView: self.view){
            
            if (!x.validate())
            {
                return false
            }
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Utility.isArabicSelected() {
            qualificationTF.hint = "المؤهلات العلمية"
            graduationYearTF.hint = "Graduation Year"
            graduationYearTF.keyboardType = UIKeyboardType.numberPad
            specialityTF.hint = "Speciality"
            cvTF.hint = "CV"
            licenseTF.hint = "License"
        } else {
            qualificationTF.hint = "qualification *"
            graduationYearTF.hint = "Graduation Year *"
            graduationYearTF.keyboardType = UIKeyboardType.numberPad
            specialityTF.hint = "Speciality *"
            cvTF.hint = "CV *"
            licenseTF.hint = "License *"
        }
        
        if (self.navbar != nil)
        {
            if let title = UserDefaults.standard.value(forKey: "service") as? String{
                self.navbar.title.text = title
            }
            else{
                self.navbar.title.text = "Home Care"
            }
            self.navbar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
         self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 1000)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        if (self.validated())
        {
            SetDefaultWrappers().showAlert(info:"Your application has been successfully submitted".localized(), viewController: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        }
    
    }
    
}

