//
//  Utility.swift
//  smartSharjah
//
//  Created by Usman on 15/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {
    static func isArabicSelected() -> Bool
    {
        if LanguageManager.currentLanguageCode() == "ar" {
            return true
        }else{
            return false
        }
    }
    
    func changeRootVC()
    {
        
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = mainStoryBoard.instantiateInitialViewController()
        appdelegate.window?.makeKeyAndVisible()
    }

    
    static func showAlertWithTitle(_ title:String,message:String,sender:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonOK.localized(), style: UIAlertAction.Style.default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    static func showErrorAlert(_ message:String,sender:UIViewController){
        let alert = UIAlertController(title: Alert.localized(), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonOK.localized(), style: UIAlertAction.Style.default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    static func showInternetErrorAlert()
    {
        let alert = UIAlertController(title: "No Internet Connection".localized(), message: "Make sure your device is connected to the internet.".localized(), preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default) { (action) in
            //
        }
        alert.addAction(okBtn)
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true)
    }
    
    
    static func setView()
    {
        if Utility.isArabicSelected()
        {
             UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    static func getUdid() -> String
    {
        let macAdd =  (UIDevice.current.identifierForVendor?.uuidString)!
        return  macAdd; 
    }
    static func getDeviceDetail() -> String
    {
        return UIDevice.current.name + "-" + UIDevice.current.name;
    }
    
    static func getMobileDateTime() -> String
    {
            var date = Date()
            var calendar = NSCalendar.current
            calendar.timeZone = TimeZone.current
           var formatter = DateFormatter()
        //12-13-2019 17:58:50
            formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            formatter.locale = Locale.init(identifier: "en_US")
            formatter.timeZone = TimeZone.current
            let executiondatetime = formatter.string(from:date)
        
            let executiondatetimeobject = formatter.date(from: executiondatetime)
        return executiondatetime;
    }
    
    
    static func checkSesion() -> Bool
    {
        
            var date = Date()
            let locale = NSTimeZone.init(abbreviation: "GMT")
            NSTimeZone.default = locale as! TimeZone
            var calendar = NSCalendar.current
            calendar.timeZone = TimeZone.current
            var formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            formatter.locale = Locale.init(identifier: "en_US")
            formatter.timeZone = TimeZone.current
            let curentDateTime = formatter.string(from:date)
            var expirytime :String
            if let val = User().getUserData(field: User().expiresIn_key) as? String {
            expirytime = val
            //Mon, 06 Jan 2020 13:59:20
            var formatterexp = DateFormatter()
            formatterexp.dateFormat = "EEE, dd MMM yyyy HH:mm:ss xx"
            formatterexp.locale = Locale.init(identifier: "en_US")
            formatterexp.timeZone = TimeZone.current
                
            let expiredDateTime = formatterexp.date(from:expirytime.replacingOccurrences(of: " GMT", with: " +0000")) ?? Date()
                  print("expiredDateTime: \(expiredDateTime)")
            //if(curentDateTime < expiredDateTime?.toString(dateFormat: "MM-dd-yyyy HH:mm:ss"))
                if(date < expiredDateTime)
                {
                    return true
                }
                else
                {
                    return false
                }
            }

        return false
    }
    
    static func getFreshToken(completion: @escaping (Bool, NSDictionary) -> Void)
    {
        APILayer().postDataToAPINew(name: "UserLogin", method: .post, path: "AuthenticationTokenService", params: [
                       "grant_type":"password",
                       "username":(User().getUserData(field: User().username_key) as! String),
                       "ServiceTYPE": "refreshtoken",
                       "DeviceDetails": Utility.getDeviceDetail(),
                       "DeviceUDID": Utility.getUdid(),
                       "DeviceTYPE": "IOS",
                       "MobileDateTime": Utility.getMobileDateTime()], headers: [:]) { (success, response) in
                                  print ("Success: \(success)")

                       if (success)
                       {
                           completion(true, [:])
                       }
                       else
                       {
                           completion(false, [:])
                       }
        }
    }
}



