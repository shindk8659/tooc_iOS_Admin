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
    var reservationList: [ReserveResponseDtoList] = []
    var storageList: [StoreResponseDtoList] = []
    var reservationModel: ReservationModel?
    let networkManager = NetworkManager()

    var reservation = false
    var storage = false

    var reservationCode :String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(reservationCode)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.reservationListTableView.delegate = self
        self.reservationListTableView.dataSource = self
        network()
        }
    override func viewWillAppear(_ animated: Bool) {
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
            self?.reservationModel = list
//
//            if list?.reserveResponseDtoList?.count == 0 && list?.storeResponseDtoList?.count == 0 {
//                self?.reservation = false
//                self?.storage = false
//            } else if list?.reserveResponseDtoList?.count == 0 {
//                self?.storageList = (list?.storeResponseDtoList)!
//                self?.storage = true
//            } else if  list?.storeResponseDtoList?.count == 0{
//                self?.reservationList = (list?.reserveResponseDtoList)!
//                self?.reservation = true
//            }
            
            self?.reservationListTableView.reloadData()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section  == 0 {
            if reservationModel?.reserveResponseDtoList?.count == 0 {
                return 2
            }
            else {
                return gino(reservationModel?.reserveResponseDtoList?.count) + 1
            }
            
        }
        else {
            
            if reservationModel?.storeResponseDtoList?.count == 0 {
                return 2
            }
            else {
                return gino(reservationModel?.storeResponseDtoList?.count) + 1
            }
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            let reservationView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailinfoview") as! DetailInfoViewController
//            self.navigationController?.pushViewController(reservationView, animated: true)
//        }
//        else {
//            let storageView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "storageview") as! StorageDetailViewController
//            self.navigationController?.pushViewController(storageView, animated: true)
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        if indexPath.section == 0 {
            if reservationModel?.reserveResponseDtoList?.count != 0 {
                
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "reservationlistheadercell") as! ReservationListHeaderTableViewCell
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as!     ReservationTableViewCell
                    cell.userName.text = reservationModel?.reserveResponseDtoList?[indexPath.row - 1].userName
                    cell.userName.text = reservationModel?.reserveResponseDtoList?[indexPath.row-1].userName
                    if reservationModel?.reserveResponseDtoList?[indexPath.row-1].progressType == "Done" {
                        cell.paymentProgress.text = "결제완료"
                    } else {
                        cell.paymentProgress.text = "결제대기"
                    }
                    let stamp = (reservationModel?.reserveResponseDtoList?[indexPath.row-1].endTime)!/1000
                    let date = Date(timeIntervalSince1970: TimeInterval(stamp))
                    dateFormatter.dateFormat = "yyyy.MM.dd"
                    cell.date.text = dateFormatter.string(from: date)
                    dateFormatter.dateFormat = "HH:mm"
                    cell.time.text = dateFormatter.string(from: date)
                    cell.rate.text = "\(String(describing: (reservationModel?.reserveResponseDtoList?[indexPath.row-1].price)!))원"

                   
                    if indexPath.row == gino(reservationModel?.storeResponseDtoList?.count) + 1 {
                        cell.lineImgview.image = UIImage(named: "2LineGradationThird.png")
                        
                    }
                     return cell
                    
                }
            
            }
            else {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "reservationlistheadercell") as! ReservationListHeaderTableViewCell
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell") as!  StatusCell
                    return cell
                }
                
            }
            
        }
        else {
            
            if reservationModel?.storeResponseDtoList?.count != 0 {
                
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "storageListheadercell") as! StorageListHeaderTableViewCell
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as!     ReservationTableViewCell
                    cell.userName.text = reservationModel?.storeResponseDtoList?[indexPath.row - 1].userName
                    if reservationModel?.storeResponseDtoList?[indexPath.row - 1].progressType == "Done" {
                        cell.paymentProgress.text = "결제완료"
                    } else {
                        cell.paymentProgress.text = "결제대기"
                    }
                    let stamp = (reservationModel?.storeResponseDtoList?[indexPath.row - 1].endTime)!/1000
                    let date = Date(timeIntervalSince1970: TimeInterval(stamp))
                    dateFormatter.dateFormat = "yyyy.MM.dd"
                    cell.date.text = dateFormatter.string(from: date)
                    dateFormatter.dateFormat = "HH:mm"
                    cell.time.text = dateFormatter.string(from: date)
                    cell.rate.text = "\(String(describing: (reservationModel?.storeResponseDtoList?[indexPath.row - 1].price)!))원"

                    if indexPath.row == gino(reservationModel?.storeResponseDtoList?.count) + 1{
                        cell.lineImgview.image = UIImage(named: "2LineGradationThird.png")
                       
                    }
                    return cell
                }
                
            }
            else {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "reservationlistheadercell") as! ReservationListHeaderTableViewCell
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell") as!  StatusCell
                    return cell
                }
                
            }
            
        }
        
        
    }
    
}
        
        
        
        
        
        
        
        
        
        
        
        
        
//        if indexPath.row == 0 {
//            if indexPath.section == 0 {
//
//            }
//            else {
//
//            }
//        }
//        else {
//            let lastRowIndex = tableView.numberOfRows(inSection:indexPath.section)
//
//            if indexPath.row == lastRowIndex - 2 {
//                if indexPath.section == 0 {
//                    if reservation == true {
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as! ReservationTableViewCell
//                        cell.lineImgview.image = UIImage(named: "2LineGradationThird.png")
//                        return cell
//                    } else {
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell") as! StatusCell
//                        cell.lineImage.image = UIImage(named: "2LineGradationThird.png")
//                        return cell
//                    }
//                } else {
//                    if storage == true {
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as! ReservationTableViewCell
//                        cell.lineImgview.image = UIImage(named: "2LineGradationThird.png")
//                        return cell
//                    } else {
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell") as! StatusCell
//                        cell.lineImage.image = UIImage(named: "2LineGradationThird.png")
//                        cell.statusLabel.text = "보관목록이 존재하지 않습니다."
//                        return cell
//                    }
//                }
//            }
//
//            else if indexPath.row == lastRowIndex - 1 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "sectiongapcell")
//                return cell!
//            }
//            else {
//                let dateFormatter = DateFormatter()
//                dateFormatter.locale = Locale(identifier:"ko_KR")
//
//                if indexPath.section == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as! ReservationTableViewCell
//                    cell.userName.text = reservationList[indexPath.row].userName
//                    if reservationList[indexPath.row].progressType == "Done" {
//                    cell.paymentProgress.text = "결제완료"
//                    } else {
//                    cell.paymentProgress.text = "결제대기"
//                    }
//                    let stamp = reservationList[indexPath.row].endTime!/1000
//                    let date = Date(timeIntervalSince1970: TimeInterval(stamp))
//                    dateFormatter.dateFormat = "yyyy.MM.dd"
//                    cell.date.text = dateFormatter.string(from: date)
//                    dateFormatter.dateFormat = "HH:mm"
//                    cell.time.text = dateFormatter.string(from: date)
//                    cell.rate.text = "\(reservationList[indexPath.row].price)원"
//                return cell
//                } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "reservationcell") as! ReservationTableViewCell
//                    cell.userName.text = storageList[indexPath.row].userName
//                    if storageList[indexPath.row].progressType == "Done" {
//                        cell.paymentProgress.text = "결제완료"
//                    } else {
//                        cell.paymentProgress.text = "결제대기"
//                    }
//                    let stamp = storageList[indexPath.row].endTime!/1000
//                    let date = Date(timeIntervalSince1970: TimeInterval(stamp))
//                    dateFormatter.dateFormat = "yyyy.MM.dd"
//                    cell.date.text = dateFormatter.string(from: date)
//                    dateFormatter.dateFormat = "HH:mm"
//                    cell.time.text = dateFormatter.string(from: date)
//                    cell.rate.text = "\(storageList[indexPath.row].price)원"
//                return cell
//                }
//            }
//        }

