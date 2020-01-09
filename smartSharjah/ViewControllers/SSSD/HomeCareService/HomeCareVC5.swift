//
//  HomeCareVC5.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class HomeCareVC5: UIViewController {

    @IBOutlet weak var imagebtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBar: NavBar!
    var picture: UIImage!
    
//    @IBOutlet weak var fullName2TF: TextField!
//    @IBOutlet weak var emiratesID2TF: TextField!
//    @IBOutlet weak var gender2TF: TextField!
//    @IBOutlet weak var nationality2TF: TextField!
//    @IBOutlet weak var dob2TF: TextField!
//    @IBOutlet weak var category2TF: TextField!
//    @IBOutlet weak var branch2TF: TextField!
//    @IBOutlet weak var idFront: TextField!
//    @IBOutlet weak var idBack: TextField!
//    @IBOutlet weak var passportPic: TextField!
//    @IBOutlet weak var medicalPic: TextField!
//
//    var emiratesIDFront2: UIImage?
//    var emiratesIDBack2: UIImage?
//    var passportImg2: UIImage?
//    var medicalReport2: UIImage?
//
//    var emiratesIDFront: UIImage?
//    var emiratesIDBack: UIImage?
//    var passportImg: UIImage?
//    var residenceCard: UIImage?
//
//    var fullName:String!
//    var emiratiID:String!
//    var mobileNo:String!
//    var emailAddress:String!
//    var nationality:String!
//    var familyRegistration:String!
//    var dob:String!
//    var placeOfBirth:String!
//    var gender:String!
//    var maritalStatus:String!
//    var numOfChildren:String!
//
//    var phoneNumber:String!
//    var issuedBy:String!
//    var city:String!
//    var fullAddress:String!
//
//    var qualification:String!
//    var dateOfIssue:String!
//    var qualificationIssuedBy:String!
//    var employmentStatus:String!
//    var monthlyIncome:String!
//
//    var passportNum: String!
//    var passportIssuePlace: String!
//    var passportDateIssue: String!
//    var passportExpiry: String!
//
//    var fullName2:String!
//    var emiratesID2:String!
//    var gender2:String!
//    var nationality2:String!
//    var dob2:String!
//    var category2:String!
//    var branch2:String!
    
    
    override func viewDidAppear(_ animated: Bool) {
          Utility.setView()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navBar != nil)
        {
            if let title = UserDefaults.standard.value(forKey: "service") as? String{
                self.navBar.title.text = title
            }
            else{
                self.navBar.title.text = "Home Care"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        // Do any additional setup after loading the view.
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width*0.9, height: 1250)
    }
    
    
    func getAllTextFields(fromView view: UIView)-> [TextField] {
        return view.subviews.flatMap { (view) -> [TextField]? in
            if view is TextField {
                return [(view as! TextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
            }.flatMap({$0})
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

    
    @IBAction func choosePickerPressed(_ sender: UIButton) {
        
        let pickerController = UIImagePickerController()
        //        pickerController.delegate = self
        pickerController.allowsEditing = true
        //        pickerController.mediaTypes = [.image]
        pickerController.sourceType = .photoLibrary
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func nextPressed(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
        
        
        
        
         if (self.validated())
        
        {APILayer().postDataToAPI(name: "HomeCare", method: .post, path: "/", params: [:], headers: [:]) { (success, responseDict) in
            
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccess"), object: nil)
                self.navigationController?.dismiss(animated: true, completion: nil)
            
        }}
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let img = info[.editedImage] as? UIImage {
            self.imagebtn.setImage(img, for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
        //        self.pickerController(picker, didSelect: image)
        
    }
    
}

