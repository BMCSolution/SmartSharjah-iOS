//
//  User.swift
//  smartSharjah
//
//  Created by Usman on 19/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit

/*"username":"usman@email.com",
"fullName":"Usman Kha",
"emirateID":"",
"licenseNo":"",
"emailAddr":"usman@email.com",
"AddressHome":"sfs",
"isActive":1,
"pictureUrl":"http://sharjah24.ae/",
"phoneNo":"" */

class User {
    
    let name_Key = "fullName"
    let email_Key = "emailAddr"
    let emirateID_Key = "emirateID"
    let licenseNo_key = "licenseNo"
    let address_Key = "addressHome"
    let mobileNumber_key = "phoneNo"
    let profilePicURL_key = "pictureUrl"
    let username_key = "username"
    let OTP_key = "OTP"
    let OTPFlag_key = "OTPFlag"
    let expiresIn_key = ".expires"
  
    func isLoggedin() -> Bool
    {
        let userDef = UserDefaults.standard
        if userDef.object(forKey: "username") != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func setUserJson(d: NSDictionary!, replaceProfilePic: Bool){
        
        let data : Data = NSKeyedArchiver.archivedData(withRootObject: d)
        let userDef = UserDefaults.standard
        
        if replaceProfilePic
        {
            userDef.set(data, forKey: "user")
            userDef.synchronize()
            self.reSaveProfilePic(url: self.getProfilePic())
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "profileUpdated"), object: nil)
            print("User Saved Successfuly....!")
        }
        else
        {
             userDef.set(data, forKey: "user")
             userDef.synchronize()
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "profileUpdated"), object: nil)
            print("User Saved Successfuly....!")
        }
        
       

    }
    
    
    func getUserData(field:String) -> Any
       {
            let userDef = UserDefaults.standard
           return userDef.object(forKey: field) as? String ?? ""
       }
    
    func getUser(field:String) -> Any
    {
        
        let userDef = UserDefaults.standard
        if let  de = userDef.object(forKey: "user") as? Data
        {
            let v = NSKeyedUnarchiver.unarchiveObject(with: de) as! NSDictionary
            if let f = v.value(forKey: field)
            {
                return f
            }
            else
            {
                return ""
            }
        }
        
        return ""
    }
    
    func reSaveProfilePic(url: String)
    {
        let user = self.getUser().mutableCopy() as! NSMutableDictionary
        user[profilePicURL_key] = url
        self.setUserJson(d: user as NSDictionary, replaceProfilePic: false)

    }
    
    func saveProfilePicInPrefs(url: String)
    {
       let userDef = UserDefaults.standard
        userDef.set(url, forKey: "pictureUrl")
        userDef.synchronize()
    }
    
    func getProfilePic() -> String
    {
         let user = self.getUser()
        
        if let  v = user.value(forKey: self.profilePicURL_key) as? String
        {
            return v
        }

        return ""
    }
    
    func getUser() -> NSDictionary{
        
        let userDef = UserDefaults.standard
        if let  d = userDef.object(forKey: "user") as? Data
        {
            let v = NSKeyedUnarchiver.unarchiveObject(with: d) as! NSDictionary
            if v.count > 0
            {
                return v
            }
            else
            {
                print("Parsing Data to Array of Dictionary failed...")
            }
           
        }
        return [:]
    }
    
}
