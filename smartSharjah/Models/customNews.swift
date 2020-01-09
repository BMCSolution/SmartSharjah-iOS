//
//  customNews.swift
//  smartSharjah
//
//  Created by Usman on 15/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import UIKit
import HTMLParser


class FeedParser: NSObject, XMLParserDelegate {
    fileprivate var rssItems = [(title: String, description: String, pubDate: String, image: String)]()
  
  fileprivate var currentElement = ""
  
  fileprivate var currentTitle = "" {
    didSet {
      currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
  fileprivate var currentDescription = "" {
    didSet {
      currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
  fileprivate var currentPubDate = "" {
    didSet {
      currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
    fileprivate var currentImage = "" {
      didSet {
        currentImage = currentImage.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      }
    }
    
    
    
    fileprivate var parserCompletionHandler: (([(title: String, description: String, pubDate: String, image: String)]) -> Void)?
  
  func parseFeed(feedURL: String, completionHandler: (([(title: String, description: String, pubDate: String, image: String)]) -> Void)?) -> Void {
    
    parserCompletionHandler = completionHandler
    
    guard let feedURL = URL(string:feedURL) else {
      print("feed URL is invalid")
      return
    }
    
    URLSession.shared.dataTask(with: feedURL, completionHandler: { data, response, error in
      if let error = error {
        print(error)
        return
      }
      
      guard let data = data else {
        print("No data fetched")
        return
      }
      
      let parser = XMLParser(data: data)
      parser.delegate = self
      parser.parse()
    }).resume()
  }
  
  // MARK: - XMLParser Delegate
  func parserDidStartDocument(_ parser: XMLParser) {
    rssItems.removeAll()
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    currentElement = elementName
    
    if currentElement == "item" {
      currentTitle = ""
      currentDescription = ""
      currentPubDate = ""
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    /// Note: current string may only contain part of info.
    switch currentElement {
    case "title":
      currentTitle += string
    case "description":
        if Utility.isArabicSelected()
        {
            currentDescription += string.replacingOccurrences(of: ";quot&", with: "")
        }
        else
        {
             currentDescription += string.stripped.replacingOccurrences(of: "24&#58", with: "").replacingOccurrences(of: "WAM&#5", with: "")
        }
      
    case "pubDate":
      currentPubDate += string
        
    case "media:thumbnail":
        
        let all = string.components(separatedBy: "https://")
        if (all.count > 0)
        {
          currentImage  = "https://\(all.last!)"
 
        }
        else
        {
           currentImage = "no img"   
        }
        
    default:
      break
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "item" {
        let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate, image: currentImage)
      rssItems.append(rssItem)
    }
  }
  
  func parserDidEndDocument(_ parser: XMLParser) {
    parserCompletionHandler?(rssItems)
  }
  
  func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    print(parseError.localizedDescription)
  }
}
