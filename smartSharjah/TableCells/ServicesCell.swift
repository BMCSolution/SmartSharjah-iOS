//
//  ServicesCell.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ServicesCell: UITableViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var servicesImage: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
