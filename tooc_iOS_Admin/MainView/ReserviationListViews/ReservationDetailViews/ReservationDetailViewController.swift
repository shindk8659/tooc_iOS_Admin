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
    }
    
    @IBAction func didPressStore(_ sender: UIButton) {
    }
    
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
        totalLuggage.text = "총 \(totalCount)개"
        
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
        
        let timeInterval = open.timeIntervalSince(close)
        let date = Date(timeIntervalSince1970: timeInterval)
        dateFormatter.dateFormat = "총 h시간 m분"
        totalTime.text = dateFormatter.string(from: date)
        totalRate.text = "\(price)원 X \(totalCount)개"
        
        totalRateOfPayment.text = "\(price*totalCount)원"
        
        if progressType == "DONE" {
            payCheck.image = UIImage(named: "reservePayRect")
        }
        

        
        
        
        
        
        
        
        
        
        
        for bag in bagDtolList {
            switch bag.bagType {
            case "CARRIER":
                let count = bag.bagCount ?? 0
                self.totalCount += count
                suitcaseRate.text = "\(count)개: \(price)원"
            case "ETC":
                let count = bag.bagCount ?? 0
                self.totalCount += count
                luggageRate.text = "\(count)개: \(price)원"
            default: break
            }
        }
        
        
        
        
    }

    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    

}
