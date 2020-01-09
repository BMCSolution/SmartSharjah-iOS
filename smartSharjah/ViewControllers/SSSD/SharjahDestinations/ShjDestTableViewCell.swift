//
//  ShjDestTableViewCell.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ShjDestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var destImgOutlet: UIImageView!
    
    
    @IBOutlet weak var destTitleOutlet: UILabel!
    
    @IBOutlet weak var destSubTitleOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            if Utility.isArabicSelected()
           {
               self.destTitleOutlet.font = UIFont(name: AppFontArabic.bold, size: self.destTitleOutlet.font.pointSize)
           }
            else
            {
                self.destTitleOutlet.font = UIFont(name: AppFontEnglish.bold, size: self.destTitleOutlet.font.pointSize)
            }
         
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
