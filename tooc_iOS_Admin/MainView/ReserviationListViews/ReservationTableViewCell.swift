//
//  ReservationTableViewCell.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/3/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var lineImgview: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var paymentProgress: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var rate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
