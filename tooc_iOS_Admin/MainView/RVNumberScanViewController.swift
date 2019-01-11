//
//  RVNumberScanViewController.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

protocol changeTabProtocol {
    func changeTabViewController(code: String)
}

class RVNumberScanViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var RVnumberTF: UITextField!
    
    @IBAction func didPressConfirmation(_ sender: UIButton) {
        
        if RVnumberTF.text?.isEmpty == true {
            showAlertMessage(titleStr: "", messageStr: "코드를 입력해주세요.")
        } else {
        let code = RVnumberTF.text
            self.dismiss(animated: true) {
                self.delegate.changeTabViewController(code: code!)
            }
        }
    }
    
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let networkManager = NetworkManager()
    var delegate: changeTabProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
    }

    func layoutSetup() {
        bgView.layer.cornerRadius = 8
        confirmBtn.layer.cornerRadius = 15
    }
    
}
