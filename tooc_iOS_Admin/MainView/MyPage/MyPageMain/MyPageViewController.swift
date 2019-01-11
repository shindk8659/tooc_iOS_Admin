//
//  MyPageViewController.swift
//  tooc_iOS_Admin
//
//  Created by 신동규 on 1/12/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var myPageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        // Do any additional setup after loading the view.
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
        return cell
    }
    
    
}
