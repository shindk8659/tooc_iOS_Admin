//
//  AdminReviewViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/11/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class AdminReviewViewController: UIViewController {
    
    let networkManager = NetworkManager()
    var storeReviewModel :StoreReviewModel?

    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reviewTableView.delegate = self
        self.reviewTableView.dataSource = self

        networkManager.getStoreReview { [weak self](reviews, errorModel, error) in
            
            if reviews == nil && errorModel == nil && error != nil {
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.1")
            }
            else if reviews == nil && errorModel != nil && error == nil {
                print(errorModel)
                self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.2")
            }
            else {
                self?.storeReviewModel = reviews
                self?.reviewCount.text = "후기 \((reviews?.storeGradeReview?.count)!)개" 
                self?.reviewTableView.reloadData()
                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    func makeReviewTime(time:Int?) ->String{
        let timeStamp = gino(time)/1000
        let date = Date(timeIntervalSince1970: Double(gino(timeStamp)))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9") //Set timezone that you want
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "MMM d일 HH:mm"
        //Specify your format that you want
        let open = dateFormatter.string(from: date)
        return open
    }
    

   

}
extension AdminReviewViewController : UITableViewDelegate
{
    
}
extension AdminReviewViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gino(storeReviewModel?.storeGradeReview?.count) + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewheader") as! ReviewHeaderTableViewCell
            cell.reviewCount.text = String(gino(storeReviewModel?.storeGradeReview?.count))
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adminreviewcell") as! ReviewContentsTableViewCell
            cell.gradeLabel.text = String(gino(storeReviewModel?.reviewUserImgResponseDtos?[indexPath.row - 1].like)) + "점"
            cell.nameLabel.text = gsno(storeReviewModel?.reviewUserImgResponseDtos?[indexPath.row-1].userName)
            cell.profileImgView?.imageFromUrl(gsno(storeReviewModel?.reviewUserImgResponseDtos?[indexPath.row-1].userImgUrl))
            cell.reviewContents.text = gsno(storeReviewModel?.reviewUserImgResponseDtos?[indexPath.row-1].content)
            cell.postTimeLabel.text = self.makeReviewTime(time: gino(storeReviewModel?.reviewUserImgResponseDtos?[indexPath.row-1].createdAt))

            return cell
            
        }
        
        
    }
    
    
}
