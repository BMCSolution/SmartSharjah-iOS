//
//  ProfileTopCell.swift
//  smartSharjah
//
//  Created by Usman on 24/10/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class ProfileTopCell: UITableViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.setRounded()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
