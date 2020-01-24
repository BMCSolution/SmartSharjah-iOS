//
//  PicturesVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 03/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import CoreLocation

class PicturesVC: UIViewController {

    @IBOutlet weak var testImg: UIImageView!
    var location: CLLocation!
    var type: String!
    var plateNumberString: String!
    var sourceString: String!
    var colorString: String!
    var licenseSourceString: String!
    var LicenseNumberString: String!
    var genderString: String!
    var dobString: String!
    var policyNumString: String!
    var insuranceCompanyString: String!
    var insuranceExpiryString: String!
    var ownerNameString: String!
    var mobileNumString: String!
    var EmailAddressString: String!
    var NationalityString: String!
    
    var images:[UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
    
    // for Non-Faulty car details
    var fn_plateCodeString: String!
    var fn_plateNumberString: String!
    var fn_sourceString: String!
    var fn_colorString: String!
    var fn_licenseSourceString: String!
    var fn_LicenseNumberString: String!
    var fn_genderString: String!
    var fn_dobString: String!
    var fn_policyNumString: String!
    var fn_insuranceCompanyString: String!
    var fn_insuranceExpiryString: String!
    var fn_ownerNameString: String!
    var fn_mobileNumString: String!
    var fn_EmailAddressString: String!
    var fn_NationalityString: String!
    
    
    
    
    @IBOutlet weak var navBar: NavBar!
    var selectedImage: UIImage!
    var current = 0
    
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var img1: UIButton!
    @IBOutlet weak var img2: UIButton!
    @IBOutlet weak var img3: UIButton!
    @IBOutlet weak var img4: UIButton!
    @IBOutlet weak var img5: UIButton!
    @IBOutlet weak var img6: UIButton!
    
    var allimgs:[UIButton] = []
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        self.current = sender.tag
        self.imagePicker.present(from: sender)
        
        allimgs = [img1,img2,img3,img4,img5,img6]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "next")
        {
            let dest = segue.destination as! InfoVC
            dest.location = self.location
            dest.type = self.type
            dest.plateNumberString = self.plateNumberString
            dest.sourceString = self.sourceString
            dest.colorString = self.colorString
            dest.licenseSourceString = self.licenseSourceString
            dest.LicenseNumberString = self.LicenseNumberString
            dest.genderString = self.genderString
            dest.dobString = self.dobString
            dest.policyNumString = self.policyNumString
            dest.insuranceCompanyString = self.insuranceCompanyString
            dest.insuranceExpiryString = self.insuranceExpiryString
            dest.ownerNameString = self.ownerNameString
            dest.mobileNumString = self.mobileNumString
            dest.EmailAddressString = self.EmailAddressString
            dest.NationalityString = self.NationalityString
            dest.images = self.images
            
            dest.fn_plateNumberString = self.fn_plateNumberString
            dest.fn_sourceString = self.fn_sourceString
            dest.fn_colorString = self.fn_colorString
            dest.fn_licenseSourceString = self.fn_licenseSourceString
            dest.fn_LicenseNumberString = self.fn_LicenseNumberString
            dest.fn_genderString = self.fn_genderString
            dest.fn_dobString = self.fn_dobString
            dest.fn_policyNumString = self.fn_policyNumString
            dest.fn_insuranceCompanyString = self.fn_insuranceCompanyString
            dest.fn_insuranceExpiryString = self.fn_insuranceExpiryString
            dest.fn_ownerNameString = self.fn_ownerNameString
            dest.fn_mobileNumString = self.fn_mobileNumString
            dest.fn_EmailAddressString = self.fn_EmailAddressString
            dest.fn_NationalityString = self.fn_NationalityString
            
        }
    }
    
    @IBAction func moveToNext(_ sender: UIButton) {
        self.performSegue(withIdentifier: "next", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "تحميل الصور"
            } else {
                navBar.title.text = "Upload Pictures"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
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

    func setImageForBtn(tag:Int, image: UIImage)
    {
        if tag == 1
        {
            self.img1.setBackgroundImage(image, for: .normal)
        }
        else if tag == 2
        {
            self.img2.setBackgroundImage(image, for: .normal)
        }
        else if tag == 3
        {
            self.img3.setBackgroundImage(image, for: .normal)
        }
        else if tag == 4
        {
            self.img4.setBackgroundImage(image, for: .normal)
        }
        else if tag == 5
        {
            self.img5.setBackgroundImage(image, for: .normal)
        }
        else if tag == 6
        {
            self.img6.setBackgroundImage(image, for: .normal)
        }
    }
    
}

extension PicturesVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        self.testImg.image = image
        
        if (image != nil)
        {
            
//            self.allimgs[current-1].setImage(self.testImg.image!, for: .normal)
            
            self.setImageForBtn(tag: current, image: self.testImg.image!)
            self.images[current-1] = image!
        }

    }
}

