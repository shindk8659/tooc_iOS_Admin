//
//  ConfirmationViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/3/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {
  
  
    @IBOutlet weak var detailconfirmationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailconfirmationTableView.delegate = self
        self.detailconfirmationTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
   
   
}
extension DetailInfoViewController : UITableViewDelegate {
    
}
extension DetailInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "detailinfocell") as! DetailInfoTableViewCell
            return cell
            
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailpricecell") as! DetailPriceTableViewCell
            return cell
            
        }
        else if indexPath.row == 2  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailphotocell") as! DetailPhotoTableViewCell
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailreservecell") as! DetailReserveTableViewCell
            return cell
            
        }
        
    }
    
    
    
}
