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
        networkManager.getReservationInfo(code: code) {[weak self] (info, errorModel, error) in
            if info == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
            }
            else if info == nil && errorModel != nil && error == nil {
                let msg = errorModel?.message ?? "통신오류"
                print(errorModel)
                self?.showAlertMessage(titleStr:"", messageStr: msg)
            }
            else {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationDetailViewController") as! ReservationDetailViewController
                
                vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ic_reservation_gray_tab"),tag: 1)
                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
                
                vc.bagDtolList = (info?.bagDtoList)!
                vc.bagimgurl = (info?.bagImgDtos)!
                vc.endTime = ((info?.endTime!)!)
                vc.payType = (info?.payType)!
                vc.price = (info?.price)!
                vc.progressType = (info?.progressType)!
                vc.reserveIdx = (info?.reserveIdx)!
                vc.startTime = (info?.startTime)!
                vc.userName1 = (info?.userName)!
                vc.userPhone1 = (info?.userPhone)!
                self?.tabBarController?.viewControllers![1] = vc
                self?.tabBarController?.selectedIndex = 1
            }
        }
    }
    
}
