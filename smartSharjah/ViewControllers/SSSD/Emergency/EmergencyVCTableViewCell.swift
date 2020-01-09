//
//  EmergencyVCTableViewCell.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit
import Foundation

class EmergencyVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var EmerTabLabelOutlet1: UILabel!
    
    @IBOutlet weak var EmerTabLabelOutlet2: UILabel!
    
    @IBOutlet weak var EmerTabLabelOutlet3: UILabel!
    
    @IBOutlet weak var EmerTabLabelOutlet4: UILabel!
    
    @IBOutlet weak var EmerTabLabelOutlet5: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear;
        self.contentView.layer.cornerRadius = 8;
        self.contentView.layer.masksToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
