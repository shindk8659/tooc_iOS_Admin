//
//  ReservationViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/3/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {

    @IBOutlet weak var reservationListTableView: UITableView!
    
    var numberOfSection = 0
    var reservationList = [[String:Any]]()
    var storageList = [[String:Any]]()
    let networkManager = NetworkManager()
    var reservationCode :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(reservationCode)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.reservationListTableView.delegate = self
        self.reservationListTableView.dataSource = self
        network()
        }

func network() {
    networkManager.inquireList { [weak self](list, errorModel, error) in
        if list == nil && errorModel == nil && error != nil {
            self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
        }
        else if list == nil && errorModel != nil && error == nil {
            self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
        }
        else {
            if list?.reserveResponseDtoList?.count == 0 && list?.storeResponseDtoList?.count == 0 {
                self?.numberOfSection = 0
                self?.showAlertMessage(titleStr: "", messageStr: "예약 및 보관 내역이 없습니다.")
            } else if list?.reserveResponseDtoList?.count == 0 {
                self?.numberOfSection = 1
                for storage in (list?.storeResponseDtoList)! {
//                    self?.storageList.append((storage as? [String:Any])!)
                }
            } else {
                self?.numberOfSection = 1
                for reservation in (list?.reserveResponseDtoList)! {
//                    self?.storageList.append((reservation as? [String:Any])!)
                }
            }
        }
    }
}
}

extension ReservationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ReservationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let reservationView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailinfoview") as! DetailInfoViewController
            self.navigationController?.pushViewController(reservationView, animated: true)
        }
        else {
            let storageView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "storageview") as! StorageDetailViewController
            self.navigationController?.pushViewController(storageView, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationlistheadercell") as! ReservationListHeaderTableViewCell
                return cell
                
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "storageListheadercell") as! StorageListHeaderTableViewCell
                return cell
                
            }
            
            
        }
        else {
            let lastRowIndex = tableView.numberOfRows(inSection:indexPath.section)
            
            if indexPath.row == lastRowIndex - 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as! ReservationTableViewCell
                cell.lineImgview.image = UIImage(named: "2LineGradationThird.png")
                return cell
            }
            else if indexPath.row == lastRowIndex - 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "sectiongapcell")
                return cell!
                
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as! ReservationTableViewCell
                return cell
            }
        }
    }
}
