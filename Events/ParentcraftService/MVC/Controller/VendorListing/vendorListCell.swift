//
//  vendorListCell.swift
//  ParentcraftService
//
//  Created by admin on 26/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class vendorListCell: UITableViewCell {

    @IBOutlet weak var mView: UIView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       mView.layer.cornerRadius = 5
        profilePic.layer.cornerRadius = self.profilePic.frame.size.height/2
      //  mView.layer.borderWidth = 1
        //mView.layer.borderColor = UIColor(red:0.14, green:0.69, blue:0.93, alpha:1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
