//
//  StorageDetailViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/3/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class StorageDetailViewController: UIViewController {

    @IBOutlet weak var storageDtailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.storageDtailTableView.delegate = self
        self.storageDtailTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

 

}
extension StorageDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storageinfocell") as! StorageInfoTableViewCell
            return cell
            
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storagepricecell") as! StoragePriceTableViewCell
            return cell
            
        }
        else if indexPath.row == 2  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storagephotocell") as! StoragePhotoTableViewCell
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storagepickupcell") as! StoragePickupTableViewCell
            return cell
            
        }
        
    }
    
    
}
extension StorageDetailViewController: UITableViewDelegate {
    
}
