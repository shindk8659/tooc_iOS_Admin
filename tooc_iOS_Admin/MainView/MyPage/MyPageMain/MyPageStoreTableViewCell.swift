//
//  MyPageStoreTableViewCell.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/12/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var workingImg: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var oldAddressLabel: UILabel!
    @IBOutlet weak var storeTimeLabel: UILabel!
    @IBOutlet weak var storeWebsiteLabel: UILabel!
    @IBOutlet weak var storePhoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
