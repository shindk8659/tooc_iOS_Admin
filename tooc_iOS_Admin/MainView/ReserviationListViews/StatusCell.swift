//
//  StatusCell.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 12/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var lineImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
