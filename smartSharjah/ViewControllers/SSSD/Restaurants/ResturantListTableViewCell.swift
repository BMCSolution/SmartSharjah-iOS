//
//  ActListTableViewCell.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ResturantListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var activityImageOutlet: UIImageView!
    
    @IBOutlet weak var activityTitleLblOutlet: UILabel!
    
    @IBOutlet weak var activitySubTitleLblOutlet: UILabel!
    
    
    @IBOutlet weak var activityCellHolderViewOutlet: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.activityImageOutlet.roundCorners([.allCorners], radius: 25)
        //self.activityCellHolderViewOutlet.roundCorners([.allCorners], radius: 25)
        if Utility.isArabicSelected()
          {
              self.activityTitleLblOutlet.font = UIFont(name: AppFontArabic.bold, size: self.activityTitleLblOutlet.font.pointSize)
          }
           else
           {
               self.activityTitleLblOutlet.font = UIFont(name: AppFontEnglish.bold, size: self.activityTitleLblOutlet.font.pointSize)
           }
        
        self.activitySubTitleLblOutlet.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
