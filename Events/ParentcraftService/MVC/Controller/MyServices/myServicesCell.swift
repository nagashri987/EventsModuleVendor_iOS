//
//  myServicesCell.swift
//  ParentCraftVendor
//
//  Created by admin on 18/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class myServicesCell: UICollectionViewCell {

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var listLabel: UILabel!
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var sevicesImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.listView.layer.cornerRadius = 12
    }
    
   

}
