//
//  DashboardCell.swift
//  ParentCraftVendor
//
//  Created by admin on 20/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class DashboardCell: UICollectionViewCell {
    
    @IBOutlet weak var dashboardImage: UIImageView!
    
    @IBOutlet weak var dashboardLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellView.layer.cornerRadius = 5
        self.countLabel.layer.cornerRadius = self.countLabel.frame.size.height / 2
        self.countLabel.clipsToBounds = true
        
        countLabel.isHidden = true
        // self.cellView.layer.borderWidth = 1
        //self.cellView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
