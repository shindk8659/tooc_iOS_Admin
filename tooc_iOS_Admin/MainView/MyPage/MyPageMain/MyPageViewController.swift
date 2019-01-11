//
//  MyPageViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/12/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    let networkManger = NetworkManager()
    var myPageModel :MyPageMainModel?
    @IBOutlet weak var myPageTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var historyCountLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var reserveSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    func getMypageData(){
        networkManger.getMyPage { [weak self](mypage, errorModel, error) in
            if mypage == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
            }
            else if mypage == nil && errorModel != nil && error == nil {
                print(errorModel)
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.2")
            }
            else {
                self?.myPageModel = mypage!
                self?.nameLabel.text = (mypage?.ownerName)! + "님,"
                self?.profileImgView.imageFromUrl((mypage?.ownerImgUrl))
                self?.historyCountLabel.text = String((mypage?.serviceCount)!)
                self?.reviewCountLabel.text = String((mypage?.reviewCount)!)
                if (mypage?.onOff)! == 1 {
                    self?.onOffLabel.text = "On"
                    self?.reserveSwitch.setOn(true, animated: true)
                }
                else {
                    self?.onOffLabel.text = "Off"
                    self?.reserveSwitch.setOn(false, animated: true)
                }
                self?.myPageTableView.reloadData()
            }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getMypageData()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
       
    }
    func setStoreTime(openTime: Int?, closeTime: Int?) -> String{
        if openTime != nil && closeTime != nil {
            
            // 개장시간과 폐장시간을 timeStemp 로 받아 Date객체로 변환
            let openTimestamp = gino(openTime)/1000
            let closeTemestamp = gino(closeTime)/1000
            let openDate = Date(timeIntervalSince1970: Double(gino(openTimestamp)))
            let closeDate = Date(timeIntervalSince1970: Double(gino(closeTemestamp)))
            
            // Date객체에서 가져올 포맷과 시간대를 정하고 String 으로 꺼내서 반환 함
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
            let open = dateFormatter.string(from: openDate)
            let close = dateFormatter.string(from: closeDate)
            let wholeTime = "매일 \(open) ~ \(close)"
            return wholeTime
        }
        else {
            return ""
        }
        
        
    }
    
    @IBAction func goToStoreReviewAction(_ sender: Any) {
        let reviewVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adminreview") as! AdminReviewViewController
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    @IBAction func switchAction(_ sender: Any) {
        networkManger.reserveSwitch { [weak self] (result,errorModel , error) in
            
            if result == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
            }
            else if result == nil && errorModel != nil && error == nil {
                print(errorModel)
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.2")
            }
            else {
           self?.getMypageData()
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyPageViewController: UITableViewDelegate
{
    
}
extension MyPageViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mystorecell") as! MyPageStoreTableViewCell
        cell.storeNameLabel.text = gsno(myPageModel?.storeName)
        cell.addressLabel.text = gsno(myPageModel?.address)
        cell.oldAddressLabel.text = gsno(myPageModel?.addressNumber)
        cell.storeWebsiteLabel.text = gsno(myPageModel?.storeUrl)
        cell.storePhoneLabel.text = gsno(myPageModel?.storeCall)
        cell.storeTimeLabel.text =  self.setStoreTime(openTime: gino(myPageModel?.openTime), closeTime: gino(myPageModel?.closeTime))
        // 영업중 영업종료 이미지 시간에 따른 변환
        let open = Date(timeIntervalSince1970: TimeInterval(gino(myPageModel?.openTime)/1000))
        let close = Date(timeIntervalSince1970: TimeInterval(gino(myPageModel?.closeTime)/1000))
        if Date(timeIntervalSinceNow: 0).isDateAvailable(openTime: open, closeTime: close) {
            cell.workingImg.image = UIImage(named: "ic_working")
        } else {
            cell.workingImg.image = UIImage(named: "ic_end")
        }
        return cell
    }
    
    
}
