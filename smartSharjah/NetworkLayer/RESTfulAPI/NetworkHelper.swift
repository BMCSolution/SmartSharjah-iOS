//
//  NetworkHelper.swift
//  smartSharjah
//
//  Created by Usman on 31/10/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit
import Moya

class NetworkHelper: NSObject{
var provider = MoyaProvider<RESTApi>()

    func userLogin(email: String, password: String,completion: @escaping (Bool, NSDictionary) -> Void)
    {
       
        provider.rx.request(.authenticate( email: email, password: password)).subscribe(onSuccess: { (response) in
        
            do {
                if let json = try response.mapJSON() as? NSDictionary
                {
                    print("Success Response:\(json) ")
                    if let dataJson = json.value(forKey: "data") as? [NSDictionary]{
                        
                        if (dataJson.count > 0)
                        {
                            completion(true,dataJson[0])
                        }
                        
                    }
                    else
                    {
                        print("JSON Array conversion error....")
                        completion(false,[:])
                    }
                }
                
               
                
            }
            catch{
                completion(false,[:])
                 print("failed response:\(error)")
            }
        
        
        
        }){(error) in
            completion(false,[:])
            print("Request Failed: \(error)")
        }
    }
    
}
