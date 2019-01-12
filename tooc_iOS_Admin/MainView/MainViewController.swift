//
//  ViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/2/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func qsScanButtonAction(_ sender: Any) {
        let qrscanView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "qrscanview") as! QRScanViewController
        qrscanView.delegate = self
       self.navigationController?.pushViewController(qrscanView, animated: true)
        
    }
    
    @IBAction func reservationCodeScanButtonAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RVNumberScanViewController") as! RVNumberScanViewController
        vc.delegate = self
        self.tabBarController?.present(vc, animated: true, completion: nil)
    }
    
    let networkManager = NetworkManager()
    let titleImageView = UIImageView.init(image: UIImage.init(named: "tooc"))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleImageView
        networkManager.getStoreIdx { [weak self](Idx, errormodel, error) in
            if Idx == nil && errormodel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
            }
                // 서버측 에러핸들러 구성후 바꿔야함
            else if Idx == nil && errormodel != nil && error == nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
            }
            else {
                let userDefaults = UserDefaults()
                userDefaults.set(Idx?.storeIdx, forKey: "storeIdx")
                userDefaults.synchronize()
            }
        }
    }
}

extension MainViewController: changeTabProtocol {
    func changeTabViewController(code: String) {
        
        networkManager.getReservationInfo(code: code) {[weak self] (info, errorModel, error) in
            if info == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
            }
            else if info == nil && errorModel != nil && error == nil {
                let msg = errorModel?.message ?? "통신오류"
                self?.showAlertMessage(titleStr:"", messageStr: msg)
            }
            else {
                print(info)
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
extension MainViewController : sendReservationCode
{
    func sendCode(code: String) {
    
        let reservationview = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "reservenavi")
        reservationview.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icReservationGrayTab"),tag: 1)
        reservationview.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let a = reservationview.children[0] as! ReservationViewController
        a.reservationCode = code
        self.tabBarController?.viewControllers![1]  = reservationview
        self.tabBarController?.selectedIndex = 1
    }
    
    
}

