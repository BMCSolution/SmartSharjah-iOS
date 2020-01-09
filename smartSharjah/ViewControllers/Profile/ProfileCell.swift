//
//  ProfileCell.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 04/09/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var textField: TextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textField.textField.textAlignment = Utility.isArabicSelected() ? .right : .left
        self.textField.hintLbl.textAlignment = Utility.isArabicSelected() ? .right : .left
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
