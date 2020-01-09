//
//  NewAllNewsVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 12/11/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import HTMLParser

class NewAllNewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: NavBar!
    
    var mainNewsImgURL : NSArray!
    var mainNewsTitle : NSArray!
    var mainNewsDescription : NSArray!
    
    var selectedImageURL: String!
    var selectedDescription: String!
    var selectedTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                navBar.title.text = "الأخبار"
            } else {
                navBar.title.text = "News"
            }
            
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
        }
        
        
    }
    

    func getText(fromHTML: String) -> String
    {
        let htmlObj = HTMLParser.stripHTML(fromHTML)!
        let str = htmlObj.replacingOccurrences(of: "&#160;", with: "").replacingOccurrences(of: "\n", with: "")
        return str
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "destinationSegue"
        {
            let dest = segue.destination as! SHJDestDetailVC
            dest.isNewsShown = true
            dest.newsImgURL = self.selectedImageURL
            dest.newsDescription = self.getText(fromHTML: self.selectedDescription)
            dest.newsTitle = self.selectedTitle
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewAllNewsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          return mainNewsImgURL.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row < mainNewsTitle.count
        {
            self.selectedImageURL = self.mainNewsImgURL[indexPath.row] as? String ??  " "
            self.selectedDescription = self.mainNewsDescription[indexPath.item] as? String ?? " "
            self.selectedTitle = self.mainNewsTitle[indexPath.item] as? String ?? " "
            self.performSegue(withIdentifier: "destinationSegue", sender: self)
        }
       
        
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsTableCell") as! NewsTableCell
        
        if indexPath.row < mainNewsTitle.count
        {
            cell.lbl.text = self.mainNewsTitle[indexPath.row] as? String
                   
                   let url = URL(string: self.mainNewsImgURL[indexPath.row] as! String)
                   
                   
                   cell.img.kf.setImage(
                       with: url,
                       placeholder: UIImage(named: "news_Default"),
                       options: nil)
                   {
                       result in
                       switch result {
                       case .success(let value):
                           print("Task done for: \(value.source.url?.absoluteString ?? "")")
                       case .failure(let error):
                           print("Job failed: \(error.localizedDescription)")
                       }
                   }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}
