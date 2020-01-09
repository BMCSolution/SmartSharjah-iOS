//
//  SaveProfileCell.swift
//  smartSharjah
//
//  Created by Usman on 24/10/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class SaveProfileCell: UITableViewCell {

    @IBOutlet weak var saveBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.saveBtn.layer.cornerRadius = 10
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
