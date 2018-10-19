//
//  SpaceTableViewCell.swift
//  space
//
//  Created by Nick on 18/10/18.
//  Copyright © 2018 Krishna. All rights reserved.
//

import UIKit

class SpaceTableViewCell: UITableViewCell {
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDetail: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var lblLanding: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMain.layer.masksToBounds = false
        viewMain.layer.shadowColor = UIColor.lightGray.cgColor
        viewMain.layer.shadowOffset = .zero
        viewMain.layer.shadowRadius = 5.0
        viewMain.layer.shadowOpacity = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
