//
//  SearchVC.swift
//  smartSharjah
//
//  Created by Usman on 13/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var navBar: NavBar!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var servicesTable: UITableView!
    
    
    var filteredList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        if (self.navBar != nil)
        {
            if Utility.isArabicSelected() {
                self.navBar.title.text = "بحث"
            } else {
                self.navBar.title.text = "Search"
            }
            self.navBar.menuSettings(navController: self.navigationController, menuShown: false)
            self.navBar.menuBtn.isHidden = true
        }
        self.servicesTable.delegate = self
        self.servicesTable.dataSource = self
        self.searchBar.delegate = self
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

extension SearchVC: UISearchBarDelegate{
    
}


extension SearchVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesCell") as! ServicesCell
        
        cell.bg.layer.cornerRadius = 1
        
//        if (self.tagN == 1)
//        {
//            cell.serviceLabel.text = self.data1[tagIndex][indexPath.row]
//            cell.servicesImage.image = UIImage(named: self.img1[tagIndex][indexPath.row])//self.itemImg
//        }
//        else{
//            cell.servicesImage.image = self.itemImg
//        }
        
        return cell
    }
    
    
}
extension SearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
