//
//  ReservationDetailViewController.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class ReservationDetailViewController: UITableViewController {
    
    @IBOutlet var bgImgView: UIImageView!
    @IBOutlet var detailView: UIView!
    @IBOutlet var storeBtn: UIButton!
    @IBOutlet var reservationCode: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var phoneNumb: UILabel!
    @IBOutlet var payment: UILabel!
    @IBOutlet var totalLuggage: UILabel!
    
    @IBOutlet var checkDate: UILabel!
    @IBOutlet var checkTime: UILabel!
    
    @IBOutlet var findDate: UILabel!
    @IBOutlet var findTime: UILabel!
    
    @IBOutlet var suitcaseRate: UILabel!
    @IBOutlet var luggageRate: UILabel!
    
    @IBOutlet var totalTime: UILabel!
    @IBOutlet var totalRate: UILabel!
    
    @IBOutlet var payCheck: UIImageView!
    @IBOutlet var totalRateOfPayment: UILabel!
    
    @IBOutlet var userLuggageImg: [UIImageView]!
    
    @IBAction func didPressTakeaPic(_ sender: UIButton) {
    }
    
    @IBAction func didPressAgreement(_ sender: UIButton) {
        if agreement == false {
            sender.setImage(UIImage(named: "bt_circle_check_small"), for: .normal)
            agreement = true
        } else {
            sender.setImage(UIImage(named: "btCircleEmpty"), for: .normal)
            agreement = false
        }
    }
    
    @IBAction func didPressStore(_ sender: UIButton) {
        if agreement == false {
            showAlertMessage(titleStr: "", messageStr: "동의하기 버튼을 체크해 주세요.")
        } else {
            networkManager.reserveAndPick(img: [], reserveIdx: reserveIdx) { [weak self] (result, errorModel, error) in
                if result == nil && errorModel == nil && error != nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
                }
                else if result == nil && errorModel != nil && error == nil {
                    let msg = errorModel?.message ?? "통신오류"
                    self?.showAlertMessage(titleStr:"", messageStr: msg)
                }
                else {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationViewController") as! ReservationViewController
                    vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icReservationColor"),tag: 1)
                    vc.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
                    self?.tabBarController?.viewControllers![1] = vc
                    self?.tabBarController?.selectedIndex = 1
                }
            }
        }
    }
    
    let networkManager = NetworkManager()
    var agreement = false
    var bagDtolList:[BagDtoList] = []
    var bagimgurl:[BagImgDtos] = []
    var startTime: Int = 0
    var endTime: Int = 0
    var overTime: Int = 0
    var payType: String = ""
    var reserveIdx: Int = 0
    var userName1: String = ""
    var userPhone1: String = ""
    var progressType: String = ""
    var stateType: String = ""
    var price: Int = 0
    var totalCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        update()
    }
    
    func layoutSetup() {
        bgImgView.layer.shadowColor = UIColor.black.cgColor
        bgImgView.layer.shadowRadius = 3
        bgImgView.layer.shadowOpacity = 0.5
        bgImgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        detailView.layer.cornerRadius = 20
        detailView.layer.shadowColor = UIColor.black.cgColor
        detailView.layer.shadowRadius = 10
        detailView.layer.shadowOpacity = 0.5
        detailView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        storeBtn.layer.cornerRadius = storeBtn.frame.width / 13
    }
    
    func update() {
        
        userName.text = userName1
        phoneNumb.text = userPhone1
        payment.text = payType
        
        let open = Date(timeIntervalSince1970: TimeInterval(startTime/1000))
        let close = Date(timeIntervalSince1970: TimeInterval(endTime/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yy년 M월 d일 E요일"
        checkDate.text = dateFormatter.string(from: open)
        findDate.text = dateFormatter.string(from: close)
        dateFormatter.dateFormat = "a h시 m분"
        checkTime.text = dateFormatter.string(from: open)
        findTime.text = dateFormatter.string(from: close)
        var count1: Int?
        var count2: Int?
        for bag in bagDtolList {
            switch bag.bagType {
            case "CARRIER":
                count1 = bag.bagCount ?? 0
                self.totalCount += count1!
            case "ETC":
                count2 = bag.bagCount ?? 0
                self.totalCount += count2!
            default: break
            }
            suitcaseRate.text = "\(count1 ?? 0)개: \(price/totalCount)원"
            luggageRate.text = "\(count2 ?? 0)개: \(price/totalCount)원"
        }
        
 
        let components = Calendar.current.dateComponents([.hour, .minute], from: open, to: close)
        
        if endTime/1000 - startTime/1000 >= 3600 {
        totalTime.text = "\(components.hour!)시간 \(components.minute!)분"
        } else {
        totalTime.text = "\(components.minute!)분"
        }
        
        totalRate.text = "\(price/totalCount)원 X \(totalCount)개"
        
        totalRateOfPayment.text = "\(price)원"
        
        if progressType == "DONE" {
            payCheck.image = UIImage(named: "reservePayRect")
        }
        
        totalLuggage.text = "총 \(totalCount)개"
        
    }

    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    

}
