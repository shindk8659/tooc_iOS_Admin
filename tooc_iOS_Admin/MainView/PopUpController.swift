//
//  PopUpController.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

enum type: String {
    case pickup
    case store
}

class PopUpController: UIViewController {

    @IBOutlet var typeLabel: UILabel!
    @IBAction func didPressConfirmation(_ sender: Any) {
        
    }
    
    
    var popupType = type.pickup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch popupType {
        case .pickup : typeLabel.text = "픽업이 완료되었습니다."
        case .store : typeLabel.text = "보관이 완료되었습니다."
        }
    }

}
