//
//  HostEventCell.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 10/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HostEventCell: UITableViewCell {

    @IBOutlet weak var mImage: UIImageView!
    
    @IBOutlet weak var startEvent: UIButton!
    @IBOutlet weak var mName: UILabel!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var mDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var interestBtn: UIButton!
    
    @IBOutlet weak var highlightBtn: UIButton!
    @IBOutlet weak var participantBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
