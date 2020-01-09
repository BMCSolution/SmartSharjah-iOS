//
//  History.swift
//  smartSharjah
//
//  Created by Usman on 07/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit


class History{
    
    let titles_Key = "his_title"
    let titles_Ar_Key = "his_title_Ar"
    let Images_Key = "his_Image"
    let itemTag_key = "item_Tag"
    let collectionTag_Key = "Collection_Tag"
    
    
    var historyServices: [NSMutableDictionary] = []
    var historyImages: [UIImage] = []
    var historyTitles: [String] = []
    var historyTitles_Ar: [String] = []
    var itemTags: [Int] = []
    var collectionTags: [Int] = []
    
    func addService()
    {
        
    }
    
    func addServiceToHistory(title: String, title_Ar: String, Image: UIImage, CollectionTag: Int, itemTag: Int)
    {
        
        if !self.serviceAlreadyExists(title: title)
        {
            
            // Get previously added services
            self.historyImages = self.getImages()
            self.historyTitles = self.getTitles()
            self.historyTitles_Ar = self.getTitles_Ar()
            self.itemTags = self.getItemTags()
            self.collectionTags = self.getcollectionTags()
            
            self.historyImages.insert(Image, at: 0)//append(Image)
            self.historyTitles.insert(title, at: 0)//append(title)
            self.historyTitles_Ar.insert(title_Ar, at: 0)//append(title_Ar)
            self.itemTags.insert(itemTag, at: 0)//append(itemTag)
            self.collectionTags.insert(CollectionTag, at: 0)//append(CollectionTag)
            
            let userDef = UserDefaults.standard
            let data : Data = NSKeyedArchiver.archivedData(withRootObject: historyImages)
            userDef.set(data, forKey: Images_Key)
            userDef.set(historyTitles, forKey: titles_Key)
            userDef.set(historyTitles_Ar, forKey: titles_Ar_Key)
            userDef.set(itemTags, forKey: itemTag_key)
            userDef.set(collectionTags, forKey: collectionTag_Key)
            userDef.synchronize()

            print("Service Added to history...!!")
        }
        else
        {
            print("Service already exist in history...!")
        }
       
    }
    
    func getIndexFor(array: [String], item: String) -> Int
    {
        return array.index(of: item)!
    }
    
    
    func serviceAlreadyExists(title: String) -> Bool
    {
        if let srvTitles = self.getTitles() as? [String]
        {
            if srvTitles.count > 0
            {
                for sTitle in srvTitles
                {
                    if sTitle == title
                    {
                        return true
                    }
                }
            }
        }

        return false
    }
    
    func getTitles() -> [String]
    {
       let userDef = UserDefaults.standard
        if let titles = userDef.object(forKey: titles_Key) as? [String]
        {
            if titles.count > 0
            {
                return titles
            }
            
        }
        return []
    }
    
    
    func getItemTags() -> [Int]
    {
        let userDef = UserDefaults.standard
        if let titles = userDef.object(forKey: itemTag_key) as? [Int]
        {
            if titles.count > 0
            {
                return titles
            }
            
        }
        return []
    }
    
    func getcollectionTags() -> [Int]
    {
        let userDef = UserDefaults.standard
        if let titles = userDef.object(forKey: collectionTag_Key) as? [Int]
        {
            if titles.count > 0
            {
                return titles
            }
            
        }
        return []
    }
    
    
    func getTitles_Ar() -> [String]
    {
        let userDef = UserDefaults.standard
        if let titles = userDef.object(forKey: titles_Ar_Key) as? [String]
        {
            if titles.count > 0
            {
                return titles
            }
            
        }
        return []
    }
    
    func getImages() -> [UIImage]
    {
        let userDef = UserDefaults.standard
        if let  d = userDef.object(forKey: Images_Key) as? Data
        {
            if let imgs = NSKeyedUnarchiver.unarchiveObject(with: d) as? [UIImage]
            {
                if imgs.count > 0
                {
                    return imgs
                }
                
            }
        }
        
        return []
    }
    
    func getServices() -> [NSMutableDictionary]
    {
        let userDef = UserDefaults.standard
        if let  d = userDef.object(forKey: "his_Services") as? Data
        {
            if let ser = NSKeyedUnarchiver.unarchiveObject(with: d) as? [NSMutableDictionary]
            {
                if ser.count > 0
                {
                     return ser
                }
               
            }
        }
        
        return []
    }
    

    
    func removeServices()
    {
        let userDef = UserDefaults.standard
        if userDef.object(forKey: titles_Key) != nil
        {
            userDef.removeObject(forKey: titles_Key)
            userDef.synchronize()
        }
        if userDef.object(forKey: titles_Ar_Key) != nil
        {
            userDef.removeObject(forKey: titles_Ar_Key)
            userDef.synchronize()
        }
        if userDef.object(forKey: Images_Key) != nil
        {
            userDef.removeObject(forKey: Images_Key)
            userDef.synchronize()
        }
        if userDef.object(forKey: itemTag_key) != nil
        {
            userDef.removeObject(forKey: itemTag_key)
            userDef.synchronize()
        }
        if userDef.object(forKey: collectionTag_Key) != nil
        {
            userDef.removeObject(forKey: collectionTag_Key)
            userDef.synchronize()
        }
    }
}
