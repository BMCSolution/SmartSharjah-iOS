//
//  NewsViewController.swift
//  smartSharjah
//
//  Created by OzzY on 8/18/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class NewsViewController: UICollectionViewCell {
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var title: UILabel!
    
    
    func resetCell()
    {
        self.imgImage.image = nil
        self.title.text = ""
    }
}
