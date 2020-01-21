//
//  HistoryCell.swift
//  smartSharjah
//
//  Created by Bmc Solution on 1/21/20.
//  Copyright © 2020 DEG. All rights reserved.
//

import Foundation

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
