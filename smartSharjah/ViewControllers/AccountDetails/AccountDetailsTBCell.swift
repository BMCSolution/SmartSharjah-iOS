//
//  AccountDetailsTBCell.swift
//  smartSharjah
//
//  Created by OzzY on 8/24/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class AccountDetailsTBCell: UITableViewCell {

    
    @IBOutlet weak var ADPaymentIDLblOutlet: UILabel!
    
    @IBOutlet weak var ADPaymentDateLabelOutlet: UILabel!

    @IBOutlet weak var ADPaymentAmountLabelOutlet: UILabel!
    
    @IBOutlet weak var ADPAymentDescLabelOutlet: UILabel!

    
    @IBOutlet weak var amountHeading: UILabel!
    @IBOutlet weak var dateHeading: UILabel!
    @IBOutlet weak var descriptionHeading: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear;
        self.container.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
