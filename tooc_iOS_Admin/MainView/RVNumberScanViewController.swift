//
//  RVNumberScanViewController.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class RVNumberScanViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var confirmBtn: UIButton!
    @IBOutlet var RVnumberTF: UITextField!
    
    @IBAction func didPressConfirmation(_ sender: UIButton) {
        scanCode()
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
    }

    func layoutSetup() {
        bgView.layer.cornerRadius = 8
        confirmBtn.layer.cornerRadius = 15
    }
    
    func scanCode() {
        let code = RVnumberTF.text ?? ""
        networkManager.getReservationInfo(code: code) {[weak self] (reservationInfo, errorModel, error) in
            if reservationInfo == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
            }
            else if reservationInfo == nil && errorModel != nil && error == nil {
                let msg = errorModel?.message ?? "통신오류"
                self?.showAlertMessage(titleStr:"", messageStr: msg)
            }
            else {
                print(reservationInfo)
            }
        }
    }
    
}
