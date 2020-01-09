//
//  FlightTableViewCell.swift
//  smartSharjah
//
//  Created by OzzY on 8/31/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    
    @IBOutlet weak var flightAirlineNameLbl: UILabel!
    
    @IBOutlet weak var flightNoLbl: UILabel!
    
    @IBOutlet weak var flightFromToLbl: UILabel!
    @IBOutlet weak var flightToLbl: UILabel!
    
    @IBOutlet weak var flightDateTime: UILabel!
    @IBOutlet weak var flightDate: UILabel!
    
    @IBOutlet weak var flightStatusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
