//
//  ReviewHeaderTableViewCell.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/11/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class ReviewHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
