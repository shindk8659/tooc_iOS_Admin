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
       self.navigationController?.pushViewController(qrscanView, animated: true)
        
    }
    
    @IBAction func reservationCodeScanButtonAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RVNumberScanViewController") as! RVNumberScanViewController
        self.present(vc, animated: true, completion: nil)
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

