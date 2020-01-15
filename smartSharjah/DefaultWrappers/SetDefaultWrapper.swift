//
//  GetDefaultWrapper.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit


class SetDefaultWrappers : NSObject {
    
    func showAlert(info:String, viewController: UIViewController)
    {
        let thePresentedVC : UIViewController? = viewController.presentedViewController as UIViewController?
        
        if let thePresentedVCAsAlertController : UIAlertController = thePresentedVC as? UIAlertController
        {
            print("Already presented: \(thePresentedVCAsAlertController)")
        }
        else
        {
            let popUp = UIAlertController(title: "Smart Sharjah".localized(), message: info, preferredStyle: UIAlertController.Style.alert)
                   popUp.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: { action in
                       print("Tapped ok");
                       popUp.dismiss(animated: true, completion: nil)
                   }))
            DispatchQueue.main.async(execute: {
                viewController.present(popUp, animated: true, completion: nil)
            })
                   
        }
       
    }
}
