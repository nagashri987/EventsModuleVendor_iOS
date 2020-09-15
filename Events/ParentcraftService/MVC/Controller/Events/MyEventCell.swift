//
//  MyEventCell.swift
//  ParentcraftService
//
//  Created by Parentcraft India on 20/05/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MyEventCell: UITableViewCell {
    
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventFee: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var participantsBtn: UIButton!
    @IBOutlet weak var ratingReviewBtn: UIButton!
    
    @IBOutlet weak var viewInvoiceBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
