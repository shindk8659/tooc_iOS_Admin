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
    
    @IBOutlet var paymentProgress: UIButton!
    @IBOutlet var totalRateOfPayment: UILabel!
    
    @IBOutlet var userLuggageImg: [UIImageView]!
    
    @IBAction func didPressTakeaPic(_ sender: UIButton) {
    }
    
    @IBAction func didPressAgreement(_ sender: UIButton) {
    }
    
    @IBAction func didPressStore(_ sender: UIButton) {
    }
    
    var bagDtolList: [[String:Any]] = []
    
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

    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    

}
