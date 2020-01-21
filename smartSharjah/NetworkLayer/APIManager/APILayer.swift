//
//  APILayer.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 05/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Alamofire

class APILayer {

    //var baseURL = "https://stg-smtshjapp.shj.ae/api/"
    //http://172.16.0.29:8070/SmartSharjahWebApi/
    //var baseURL = "http://110.93.228.86:8070/SmartSharjahWebApi/"
    //var baseURLImg = "http://110.93.228.86:8070/SmartSharjahWebApi"
    
    var baseURL = "https://stg-smtshjapp.shj.ae/"
    var baseURLImg = "https://stg-smtshjapp.shj.ae"
    
    //var baseURL = "http://172.16.0.29:8070/SmartSharjahWebApi/"
    
    func resolveData(input: [NSDictionary], language: String) -> [String]{
    
        var output:[String] = []
        output = input.map{
            
            (element) -> String in
            if let lng = element.value(forKey: "name_"+language) as? String{
                return lng
            }
            
            if let lng = element.value(forKey: "name_"+language) as? Int{
                return "\(lng)"
            }
            
            return "-"
            
        }
        
        return output
    }
    
    func createNewUser(name: String!, method: HTTPMethod, path:String, username: String, fullName: String, emiratesID: String, licenseNo: String, emailAddr:String, AddrHome: String, userActStatus: String, headers: [String: String],
                       completion: @escaping (Bool, [NSDictionary]?) -> Void)
    {
        
        print ("API Call: \(self.baseURL + path)")
        
        let params = ["username":username, "fullName":fullName,"emiratesID":emiratesID,"licenseNo":licenseNo,"emailAddr":username,"AddrHome":"","userActStatus": 1, "picture":"" ] as! [String: Any]
        
        print ("Method: \(method)")
        print ("Params: \(params)")
        
        if Reachability.isConnectedToNetwork()
        {
            
            
            Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers).responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [])
                }
                else
                {
                     if let value = response.result.value as? NSDictionary{
                        
                        print ("***Value: \(value)")
                        
                        if let dataJson = value.value(forKey: "data") as? [NSDictionary]{
                            
                            
                            if (dataJson.count > 0)
                            {
                                let userDefauls = UserDefaults.standard
                                let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                userDefauls.setValue(dataObject, forKey: name! )
                                
                                print ("Saved: \(name!)")
                                completion(true, dataJson)
                            }
                            else
                            {
                                completion(false, [])
                            }
                            
                            
                        }
                        else{
                            print ("Error 002, No Data [Dictionary]")
                            completion(false, [])
                        }
                        
                    }
                    else{
                        print("*Error 003, No Value in JSON")
                        
                        if let status = response.result.value as? Bool{
                            
                            if (status)
                            {
                                print ("True Received")
                                completion(true, [])
                            }
                            else
                            {
                                
                                print ("False Received")
                                completion(false, [])
                            }
                        }
                        else if let status = response.result.value as? String{
                            
                            print ("status String: \(status)")
                            completion(false, [])
                            
                        }
                        
                        
                        if let status = response.result.value as? String{
                            
                            if (status != nil)
                            {
                                print ("True Received", status)
                                completion(true, [])
                            }
                            else
                            {
                                
                                print ("False Received", status)
                                completion(false, [])
                            }
                        }
                        
                        
                        
                    }
                }
                
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
    }
    
    func postDataToAPI(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String],
                       completion: @escaping (Bool, NSDictionary) -> Void)
    {
     
        print ("API Call: \(self.baseURL + path)")
        print ("Params: \(params)")
        print ("Method: \(method)")
        
        if Reachability.isConnectedToNetwork()
        {
            Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers).responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [:])
                }
                else
                {
                    if let value = response.result.value as? NSDictionary{
                        
                        print ("*--Value: \(value)")
                        
                        
                        if let status = value.value(forKey: "status") as? Bool{
                            completion(true, NSDictionary() )
                        }
                        else
                            
                        if let status = value.value(forKey: "status") as? String{
                            if status == "error"
                            {
                                completion(false,[:])
                            }
                            else
                            {
                                if name == "UpdateUser"
                                {
                                   if let data = value.value(forKey: "data") as? [NSDictionary]{
                                                           
                                  let dataJson = data[0]
                                   var userDefauls = UserDefaults.standard
                                   let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                   userDefauls.setValue(dataObject, forKey: name! )
                                    User().setUserJson(d: dataJson, replaceProfilePic: false)
                                   print ("Saved: \(name!)")
                                  completion(true, dataJson)
                                  
                              }
                              else{
                                  print ("Error 002, No Data [Dictionary]")
                                  
                                  completion(false, [:])
                              }

                                }
                                else
                                {
                                    if let data = value.value(forKey: "data") as? NSDictionary{
                                           
                                           completion(true, data)
                                       }
                                       else
                                       {
                                           completion(true, [:])
                                       }
                                }
                                
                                
                                
                            }
                            
                        }
                        else if let dataJson = value.value(forKey: "data") as? NSDictionary{
                            
                                var userDefauls = UserDefaults.standard
                                let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                userDefauls.setValue(dataObject, forKey: name! )
                                
                                print ("Saved: \(name!)")
                                completion(true, dataJson)
                                
                            
                            
                        }
                         else if let data = value.value(forKey: "data") as? [NSDictionary]{
                         
                            let dataJson = data[0]
                             var userDefauls = UserDefaults.standard
                             let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                             userDefauls.setValue(dataObject, forKey: name! )
                            User().setUserJson(d: dataJson, replaceProfilePic: false)
                             print ("Saved: \(name!)")
                            completion(true, dataJson)
                            
                        }
                        else{
                            print ("Error 002, No Data [Dictionary]")
                            
                            completion(false, [:])
                        }
                        
                    }
                    else{
                        print("*Error 003, No Value in JSON")
                        
                        if let status = response.result.value as? Bool{
                            
                            if (status)
                            {
                                print ("True Received")
                                completion(true, [:])
                            }
                            else
                            {
                                
                                print ("False Received")
                                completion(false, [:])
                            }
                        }
                        
                        
                    }
                }
                
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
    }
    
    
    func postDataToAPINewInsertUser(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String],
                       completion: @escaping (Bool, NSDictionary) -> Void)
    {
     
        print ("API Call: \(self.baseURL + path)")
        print ("Params: \(params)")
        print ("Method: \(method)")
        print ("Headers: \(headers)")
        
        if Reachability.isConnectedToNetwork()
        {
            
            let ulr =  URL(string: self.baseURL + path)!
            var request = URLRequest(url: ulr as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if(name == "UpdateUserProfile")
            {
                        let userDefaults = UserDefaults.standard
                    
                           let accesstoken = userDefaults.object(forKey: "access_token") as! String
                           let authData = accesstoken
                 request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
            }
            let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                       let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                       if let json = json {
                           print(json)
                       }
                       request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            
            Alamofire.request(request as! URLRequestConvertible)
                           .responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [:])
                }
                else
                {
                    
                    
                    if let code = response.response?.statusCode as? Int{
                        if code == 401
                        {
                            completion(false,["StatusCode":code])
                        }
                        else
                        {
                            
                            if let value = response.result.value as? NSDictionary{
                                
                                print ("*--Value: \(value)")
                                
                                
                               
                                
                                    
                                if let status = value.value(forKey: "status") as? String{
                                    if status == "error"
                                    {
                                        completion(false,[:])
                                    }
                                    else
                                    {
                                        
                                        
                                        if(name == "UserSignup")
                                        {
                                                  completion(true,["OTP":value.value(forKey: "data") as? String])
                                        }else{
                                             completion(true,[:])
                                        }
                                        
                                       
                                        
                                    }
                                }
                                
                            }
                            else{
                                print("*Error 003, No Value in JSON")
                                
                                if let status = response.result.value as? Bool{
                                    
                                    if (status)
                                    {
                                        print ("True Received")
                                        completion(true, [:])
                                    }
                                    else
                                    {
                                        
                                        print ("False Received")
                                        completion(false, [:])
                                    }
                                }
                                
                                
                            }
                        }
                    }
                    
                }
                
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
    }
    
    func postDataToAPINew(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String],
                       completion: @escaping (Bool, NSDictionary) -> Void)
    {
     
        print ("API Call: \(self.baseURL + path)")
        print ("Params: \(params)")
        print ("Method: \(method)")
        print ("Headers: \(headers)")
        
        if Reachability.isConnectedToNetwork()
        {
            Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers).responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [:])
                }
                else
                {
                    if let value = response.result.value as? NSDictionary{
                        
                        print ("*--Value: \(value)")
                        
                        
                        if let status = value.value(forKey: "OTPFlag") as? String{
                            if status == "False"
                            {
                                
                               let expires = value.value(forKey: ".expires") as? String
                                                                                                                            
                                                                                             let expires_in = value.value(forKey: "expires_in") as? String
                                                                                             let issued = value.value(forKey: ".issued") as? String
                                                                                             let OTP = value.value(forKey: "OTP") as? String
                                                                                             let access_token = value.value(forKey: "access_token") as? String
                                                                                             let token_type = value.value(forKey: "token_type") as? String
                                                                                             let userName = value.value(forKey: "userName") as? String
                                                               
                                                                                            let otpFlag = value.value(forKey: "OTPFlag") as? String
                                                                                             
                                                                                             let auth = token_type!+" "+access_token!
                                                                                             let userDefauls = UserDefaults.standard
                                                                                             
                                                                                              userDefauls.setValue(otpFlag, forKey: "OTPFlag" )
                                                                                               userDefauls.setValue(expires_in, forKey: "expires_in" )
                                                                                              userDefauls.setValue(expires, forKey: ".expires" )
                                                                                              userDefauls.setValue(issued, forKey: ".issued" )
                                                                                              userDefauls.setValue(OTP, forKey: "OTP" )
                                                                                              userDefauls.setValue(auth, forKey: "access_token" )
                                                                                              userDefauls.setValue(token_type, forKey: "token_type" )
                                                                                              userDefauls.setValue(userName, forKey: "userName" )
                                                                                              userDefauls.synchronize()
                                
                                let UserDetails = value.value(forKey: "UserDetails") as? String
                                let datas = UserDetails!.data(using: .utf8)
                               
                                do {
                                    if let jsonArray = try JSONSerialization.jsonObject(with: datas!, options : .allowFragments) as? Dictionary<String,Any>
                                    {
                                       print(jsonArray) // use the json here
                                        
                                        if let data = jsonArray as? NSDictionary{
                                                                     
                                            let dataJson = data
                                             var userDefauls = UserDefaults.standard
                                             let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                             userDefauls.setValue(dataObject, forKey: name! )
                                              User().setUserJson(d: dataJson, replaceProfilePic: false)
                                             print ("Saved: \(name!)")
                                            completion(true, dataJson)
                                            
                                        }
                                        else{
                                            print ("Error 002, No Data [Dictionary]")
                                            
                                            completion(false, [:])
                                        }
                                        
                                    } else {
                                        print("bad json")
                                    }
                                } catch let error as NSError {
                                    print(error)
                                }
                                
                                /* if let data = value.value(forKey: "data") as? [NSDictionary]{
                                                                                          
                                                                 let dataJson = data[0]
                                                                  var userDefauls = UserDefaults.standard
                                                                  let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                                                  userDefauls.setValue(dataObject, forKey: name! )
                                                                   User().setUserJson(d: dataJson, replaceProfilePic: false)**/
                                
                           // completion(true, NSDictionary() )
                            }
                            else
                            {
                                
                                let expires = value.value(forKey: ".expires") as? String
                                                                                             
                                                              let expires_in = value.value(forKey: "expires_in") as? String
                                                              let issued = value.value(forKey: ".issued") as? String
                                                              let OTP = value.value(forKey: "OTP") as? String
                                                              let access_token = value.value(forKey: "access_token") as? String
                                                              let token_type = value.value(forKey: "token_type") as? String
                                                              let userName = value.value(forKey: "userName") as? String
                                
                                                             let otpFlag = value.value(forKey: "OTPFlag") as? String
                                                              
                                                              let auth = token_type!+" "+access_token!
                                                              let userDefauls = UserDefaults.standard
                                                              
                                                               userDefauls.setValue(otpFlag, forKey: "OTPFlag" )
                                                                userDefauls.setValue(expires_in, forKey: "expires_in" )
                                                               userDefauls.setValue(expires, forKey: ".expires" )
                                                               userDefauls.setValue(issued, forKey: ".issued" )
                                                               userDefauls.setValue(OTP, forKey: "OTP" )
                                                               userDefauls.setValue(auth, forKey: "access_token" )
                                                               userDefauls.setValue(token_type, forKey: "token_type" )
                                                               userDefauls.setValue(userName, forKey: "userName" )
                                                               userDefauls.synchronize()
                                
                                completion(false,["OTPFlag":otpFlag])
                            }
                        }
                        else
                            
                        if let status = value.value(forKey: "OTPFlag") as? String{
                            if status == "error"
                            {
                                completion(false,[:])
                            }
                            else
                            {
                                if name == "UpdateUser"
                                {
                                   if let data = value.value(forKey: "data") as? [NSDictionary]{
                                                           
                                  let dataJson = data[0]
                                   var userDefauls = UserDefaults.standard
                                   let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                   userDefauls.setValue(dataObject, forKey: name! )
                                    User().setUserJson(d: dataJson, replaceProfilePic: false)
                                   print ("Saved: \(name!)")
                                  completion(true, dataJson)
                                  
                              }
                              else{
                                  print ("Error 002, No Data [Dictionary]")
                                  
                                  completion(false, [:])
                              }

                                }
                                else
                                {
                                    if let data = value.value(forKey: "data") as? NSDictionary{
                                           
                                           completion(true, data)
                                       }
                                       else
                                       {
                                           completion(true, [:])
                                       }
                                }
                                
                                
                                
                            }
                            
                        }
                        else if let dataJson = value.value(forKey: "data") as? NSDictionary{
                            
                                var userDefauls = UserDefaults.standard
                                let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                userDefauls.setValue(dataObject, forKey: name! )
                                
                                print ("Saved: \(name!)")
                                completion(true, dataJson)
                                
                            
                            
                        }
                         else if let data = value.value(forKey: "data") as? [NSDictionary]{
                         
                            let dataJson = data[0]
                             var userDefauls = UserDefaults.standard
                             let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                             userDefauls.setValue(dataObject, forKey: name! )
                            User().setUserJson(d: dataJson, replaceProfilePic: false)
                             print ("Saved: \(name!)")
                            completion(true, dataJson)
                            
                        }
                        else{
                            print ("Error 002, No Data [Dictionary]")
                            
                            completion(false, [:])
                        }
                        
                    }
                    else{
                        print("*Error 003, No Value in JSON")
                        
                        if let status = response.result.value as? Bool{
                            
                            if (status)
                            {
                                print ("True Received")
                                completion(true, [:])
                            }
                            else
                            {
                                
                                print ("False Received")
                                completion(false, [:])
                            }
                        }
                        
                        
                    }
                }
                
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
    }
    
    func getOTPSMSNew(name: String!, method: HTTPMethod, path:String, params:  [String: Any], headers: [String: String],
                        completion: @escaping (Bool, String) -> Void)
    {
        print ("API Call: \(self.baseURL + path)")
        
        if Reachability.isConnectedToNetwork()
        {
                       
                    let ulr =  URL(string: self.baseURL + path)!
                                  var request = URLRequest(url: ulr as URL)
                                  request.httpMethod = "POST"
                                  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                  if(name == "loginotp")
                                  {
                                              let userDefaults = UserDefaults.standard
                                          
                                                 let accesstoken = userDefaults.object(forKey: "access_token") as! String
                                                 let authData = accesstoken
                                       request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
                                  }
                                  let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                                             let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                             if let json = json {
                                                 print(json)
                                             }
                                             request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                                  
                                  Alamofire.request(request as! URLRequestConvertible)
                                                 .responseJSON { (response) in
                       
                
                print ("Resp: *\(response.data)*")
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, "")
                }
                else
                {
                    
                    
                    if let data = response.result.value as? NSDictionary{
                        
                        if let status = data.value(forKey: "message") as? String{
                            
                            if (status == "Request Successful!")
                            {
                                print ("OTP Code: \(status)")
                                completion(true, status)
                            }
                            else
                            {
                                
                                completion(false, status)
                            }
                        }
                        
                    }
                    
                    
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
        
    }
    
    
    func getNewOtp(name: String!, method: HTTPMethod, path:String, params:  [String: Any], headers: [String: String],
                        completion: @escaping (Bool, NSDictionary) -> Void)
    {
        print ("API Call: \(self.baseURL + path)")
        
        if Reachability.isConnectedToNetwork()
        {
                       
                    let ulr =  URL(string: self.baseURL + path)!
                                  var request = URLRequest(url: ulr as URL)
                                  request.httpMethod = "POST"
                                  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                  if(name == "logingetnewotp")
                                  {
                                              let userDefaults = UserDefaults.standard
                                          
                                                 let accesstoken = userDefaults.object(forKey: "access_token") as! String
                                                 let authData = accesstoken
                                       request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
                                  }
                                  let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                                             let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                             if let json = json {
                                                 print(json)
                                             }
                                             request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                                  
                                  Alamofire.request(request as! URLRequestConvertible)
                                                 .responseJSON { (response) in
                       
                
                print ("Resp: *\(response.data)*")
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [:])
                }
                else
                {
                    
                    
                    if let data = response.result.value as? NSDictionary{
                        
                      if let status = data.value(forKey: "status") as? String{
                            if status == "error"
                            {
                                completion(false,[:])
                            }
                            else
                            {
                             completion(true,["OTPCode":data.value(forKey: "data") as? String])
                            
                            }
                        }
                        
                    }
                    
                    
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
        
    }
    
    func createNewUserNew(name: String!, method: HTTPMethod, path:String, username: String, fullName: String, emiratesID: String, licenseNo: String, emailAddr:String, AddrHome: String, userActStatus: String, headers: [String: String],
                          completion: @escaping (Bool, [NSDictionary]?) -> Void)
       {
           
           print ("API Call: \(self.baseURL + path)")
           
           let params = ["username":username, "fullName":fullName,"emiratesID":emiratesID,"licenseNo":licenseNo,"emailAddr":username,"AddrHome":"","userActStatus": 1, "picture":"" ] as! [String: Any]
           
           print ("Method: \(method)")
           print ("Params: \(params)")
           
           if Reachability.isConnectedToNetwork()
           {
               
               
               Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers).responseJSON { (response) in
                   
                   if (response.error != nil)
                   {
                       print ("Error 001, \(response.error)")
                       completion(false, [])
                   }
                   else
                   {
                        if let value = response.result.value as? NSDictionary{
                           
                           print ("***Value: \(value)")
                           
                           if let dataJson = value.value(forKey: "data") as? [NSDictionary]{
                               
                               
                               if (dataJson.count > 0)
                               {
                                   let userDefauls = UserDefaults.standard
                                   let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                   userDefauls.setValue(dataObject, forKey: name! )
                                   
                                   print ("Saved: \(name!)")
                                   completion(true, dataJson)
                               }
                               else
                               {
                                   completion(false, [])
                               }
                               
                               
                           }
                           else{
                               print ("Error 002, No Data [Dictionary]")
                               completion(false, [])
                           }
                           
                       }
                       else{
                           print("*Error 003, No Value in JSON")
                           
                           if let status = response.result.value as? Bool{
                               
                               if (status)
                               {
                                   print ("True Received")
                                   completion(true, [])
                               }
                               else
                               {
                                   
                                   print ("False Received")
                                   completion(false, [])
                               }
                           }
                           else if let status = response.result.value as? String{
                               
                               print ("status String: \(status)")
                               completion(false, [])
                               
                           }
                           
                           
                           if let status = response.result.value as? String{
                               
                               if (status != nil)
                               {
                                   print ("True Received", status)
                                   completion(true, [])
                               }
                               else
                               {
                                   
                                   print ("False Received", status)
                                   completion(false, [])
                               }
                           }
                           
                           
                           
                       }
                   }
                   
               }
           }
           else
           {
               Utility.showInternetErrorAlert()
           }
           
           
       }
    
    
    func getOTPSMS(name: String!, method: HTTPMethod, path:String, params: [String: AnyObject], headers: [String: String],
                        completion: @escaping (Bool, String) -> Void)
    {
        print ("API Call: \(self.baseURL + path)")
        
        if Reachability.isConnectedToNetwork()
        {
            
            
            Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers).responseJSON { (response) in
                
                print ("Resp: *\(response.data)*")
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, "")
                }
                else
                {
                    
                    
                    if let data = response.result.value as? NSDictionary{
                        
                        if let status = data.value(forKey: "data") as? String{
                            
                            if (status != nil)
                            {
                                print ("OTP Code: \(status)")
                                completion(true, status)
                            }
                            else
                            {
                                
                                completion(false, status)
                            }
                        }
                        
                    }
                    
                    
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
        
    }
    
    
    
    func removeImageFromServer(name: String!, method: HTTPMethod, path:String, params: [String: AnyObject], headers: [String: String],
                        completion: @escaping (Bool, [NSDictionary]?) -> Void)
    {
        
        print ("API Call: \(self.baseURL + path)")
        Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers).debugLog().responseJSON { (response) in
            
            if (response.error != nil)
            {
                print ("Error 001, \(response.error)")
                completion(false, [])
            }
            else
            {
                
                
                if let value = response.result.value as? NSDictionary{
                    
                    
                    if let dataJson = value.value(forKey: "Data") as? [NSDictionary]{
                        
                        
                        if (dataJson.count > 0)
                        {
                            var userDefauls = UserDefaults.standard
                            let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                            userDefauls.setValue(dataObject, forKey: name! )
                            
                            print ("Saved: \(name!)")
                            completion(true, dataJson)
                        }
                        else
                        {
                            print ("Error Saving \(name)")
                            completion(false, [])
                        }
                        
                        
                        
                    }
                    else{
                        print ("Error 002, No Data [Dictionary]")
                        
                        
                        
                        completion(false, [])
                    }
                    
                }
                else{
                    print("*Error 003, No Value in JSON")
                    
                    completion(false, [])
                }
            }
        }
        
        
    }
    
    
    func uploadProfileImageNew(endUrl: String, imageData: Data?, parameters: [String : Any], completion: @escaping (Bool, String?) -> Void) {
        
        let url = self.baseURL + endUrl/* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            

            
            if let data = imageData{
                multipartFormData.append(data, withName: "image_", fileName: ("image_\(Utility.getUdid())_\(Date().millisecondsSince1970).png"), mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        completion(false, "")
                        return
                    }
                    
                    if let value = response.result.value as? NSDictionary{
                        
                        print("Response: \(value)")
                        if let dataJson = value.value(forKey: "data") as? String{
                            
                            
                            if (dataJson != "")
                            {
                                completion(true, self.baseURLImg+dataJson)
                            }
                            else
                            {
                               // print ("Error Saving \(String(describing: name))")
                                completion(false, "")
                            }
                        }
                        else{
                            print ("Error 002, No Data [Dictionary]")
                            completion(false, "")
                        }
                        
                    }
                    else{
                        print("*Error 003, No Value in JSON")
                        
                        completion(false, "")
                    }
                   //completion(true, "")
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completion(false, "")
            }
        }
    }
    
    func uploadProfileImage(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String], completion: @escaping (Bool, String?) -> Void) {
        let urlString = (self.baseURL + path).addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        let prams = self.createJSONInput(parameters: params)
        //print("Params: \(prams)")
        if Reachability.isConnectedToNetwork()
        {
            Alamofire.request(URL(string: urlString!)!, method: method, parameters: params, headers: headers).responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error?.localizedDescription)")
                    completion(false, "")
                }
                else
                {
                    
                    if let value = response.result.value as? NSDictionary{
                        
                        print("Response: \(value)")
                        if let dataJson = value.value(forKey: "data") as? String{
                            
                            
                            if (dataJson.count > 0)
                            {
                                completion(true, dataJson)
                            }
                            else
                            {
                                print ("Error Saving \(String(describing: name))")
                                completion(false, "")
                            }
                        }
                        else{
                            print ("Error 002, No Data [Dictionary]")
                            completion(false, "")
                        }
                        
                    }
                    else{
                        print("*Error 003, No Value in JSON")
                        
                        completion(false, "")
                    }
                }
            }
            
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
    }

    
    func getDataFromAPINew(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String],
                        completion: @escaping (Bool, [NSDictionary]?) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            
            let ulr =  URL(string: self.baseURL + path)!
                       var request = URLRequest(url: ulr as URL)
                       request.httpMethod = "POST"
                       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                       if(name == "UpdateUserProfile")
                       {
                                   let userDefaults = UserDefaults.standard
                               
                                      let accesstoken = userDefaults.object(forKey: "access_token") as! String
                                      let authData = accesstoken
                            request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
                       }
                       let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                                  let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                  if let json = json {
                                      print(json)
                                  }
                                  request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                       
                       Alamofire.request(request as! URLRequestConvertible)
                                      .responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [])
                }
                else
                {
                    print("Response: \(response)")
                    if name == "GetUserInfo"
                    {
                        if let resp = response.result.value as? [NSDictionary]
                        {
                            
                            print("**************:\(resp)")
                            completion(true, resp)
                        }
                        else
                        {
                            print ("Error Saving \(name)")
                            completion(false, [])
                        }
                    }
                    else
                    {
                        if let value = response.result.value as? NSDictionary
                        {
                             print("Response: \(value)")
                            
                            if let dataJson = value.value(forKey: "data") as? [NSDictionary]{
                                
                                
                                if (dataJson.count > 0)
                                {
                                    
                                    var userDefauls = UserDefaults.standard
                                    let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                    userDefauls.setValue(dataObject, forKey: name! )
                                    
                                    print ("Saved: \(name!)")
                                    completion(true, dataJson)
                                }
                                else
                                {
                                    print ("Error Saving \(name)")
                                    completion(false, [])
                                }
                                
                                
                                
                            }
                            else{
                                print ("Error 002, No Data [Dictionary]")
                                
                                completion(false, [])
                            }
                            
                        }
                        else{
                            print("*Error 003, No Value in JSON")
                            
                            completion(false, [])
                        }
                    }
                    
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
        
        
    }
    
    
    func getLocalizationNew(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String],
                        completion: @escaping (Bool, [NSDictionary]?) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            
            let ulr =  URL(string: self.baseURL + path)!
                       var request = URLRequest(url: ulr as URL)
                       request.httpMethod = "POST"
                       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                       let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                                  let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                  if let json = json {
                                      print(json)
                                  }
                                  request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
                       
                       Alamofire.request(request as! URLRequestConvertible)
                                      .responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [])
                }
                else
                {
                    print("Response: \(response)")
                    
                    if let value = response.result.value as? NSDictionary
                    {
                        if let resp = value.value(forKey: "data") as? [NSDictionary]
                                              {
                                                  
                                                  print("**************:\(resp)")
                                                  completion(true, resp)
                                              }
                                              else
                                              {
                                                  print ("Error Saving \(name)")
                                                  completion(false, [])
                                              }
                    }
               
                    
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
            completion(false, nil)
        }
        
        
        
        
    }
    
    func getDataFromAPI(name: String!, method: HTTPMethod, path:String, params: [String: Any], headers: [String: String],
                        completion: @escaping (Bool, [NSDictionary]?) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            
            print ("*\(self.baseURL + path)")
            
            let ulr =  URL(string: self.baseURL + path)!
            var request = URLRequest(url: ulr as URL)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let userDefaults = UserDefaults.standard
               
                      let accesstoken = userDefaults.object(forKey: "access_token") as! String
                      let authData = accesstoken
            request.setValue(authData as! String, forHTTPHeaderField: "Authorization" )
            let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)

                       let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                       if let json = json {
                           print(json)
                       }
            if(method.rawValue == "POST")
            {
                request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            }
                       
            
            Alamofire.request(request as! URLRequestConvertible)
            //Alamofire.request(URL(string: self.baseURL + path)!, method: method, parameters: params, headers: headers)
                .responseJSON { (response) in
                
                if (response.error != nil)
                {
                    print ("Error 001, \(response.error)")
                    completion(false, [])
                }
                else
                {
                    print("Response: \(response)")
                    if name == "GetUserInfo"
                    {
                        if let resp = response.result.value as? [NSDictionary]
                        {
                            
                            print("**************:\(resp)")
                            completion(true, resp)
                        }
                        else
                        {
                            print ("Error Saving \(name)")
                            completion(false, [])
                        }
                    }
                    else
                    {
                        if let value = response.result.value as? NSDictionary
                        {
                             print("Response: \(value)")
                            
                            if let dataJson = value.value(forKey: "data") as? [NSDictionary]{
                                
                                
                                if (dataJson.count > 0)
                                {
                                    
                                    var userDefauls = UserDefaults.standard
                                    let dataObject : Data = NSKeyedArchiver.archivedData(withRootObject: dataJson)
                                    userDefauls.setValue(dataObject, forKey: name! )
                                    
                                    print ("Saved: \(name!)")
                                    completion(true, dataJson)
                                }
                                else
                                {
                                    print ("Error Saving \(name)")
                                    completion(false, [])
                                }
                                
                                
                                
                            }
                            else{
                                print ("Error 002, No Data [Dictionary]")
                                
                                completion(false, [])
                            }
                            
                        }
                        else{
                            print("*Error 003, No Value in JSON")
                            
                            completion(false, [])
                        }
                    }
                    
                }
            }
        }
        else
        {
            Utility.showInternetErrorAlert()
        }
        
        
        
        
    }
    
    
    private func createJSONInput (parameters : Dictionary<String, Any>) -> String {
        
        let theJSONData = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let theJSONText = NSString(data: theJSONData!, encoding: String.Encoding.utf8.rawValue)
        //        print("Params list are: \(theJSONText!)")
        return theJSONText! as String
    }
    
    
    func validateEmailAddress(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }

}
extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
