//
//  Custom1TableTableViewCell.swift
//  EService
//
//  Created by admin on 2021-01-22.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class Custom1TableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceCategory: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var serviceAddress: UILabel!
    @IBOutlet weak var serviceSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
