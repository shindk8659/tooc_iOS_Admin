//
//  LoginViewController.swift
//  tooc_iOS_Admin
//
//  Created by seunghwan Lee on 11/01/2019.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        if emailTextField.text == "" || passwordTextField.text ==  "" {
            if emailTextField.text == ""{
                self.showAlertMessage(titleStr:"", messageStr: "이메일을 입력해주세요.")
                
            } else{
                self.showAlertMessage(titleStr:"", messageStr: "비밀번호를 입력해주세요.")
            }
        }
        else {
            networkManager.login(email: gsno(emailTextField.text), password: gsno(passwordTextField.text)) { [weak self](login,errorModel,error) in
                
                // 로그인 네트워크 처리
                if login == nil && errorModel == nil && error != nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                }
                else if login == nil && errorModel != nil && error == nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "이메일과 비밀번호를 확인해주세요.")
                }
                else {
                    self?.userDefaults.set(self?.emailTextField.text, forKey: "email")
                    self?.userDefaults.set(self?.passwordTextField.text, forKey: "pass")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    self?.emailTextField.text = ""
                    self?.passwordTextField.text = ""
                    let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
                    self?.present(mainView, animated: true, completion: nil)
                    //pci2676@gmail.com qwer1234
                }
            }
        }
        
    }
    
    let networkManager = NetworkManager()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.userDefaults.bool(forKey: "isLogin") == true {
            let email = self.userDefaults.string(forKey: "email")
            let password = self.userDefaults.string(forKey: "pass")
            
            networkManager.login(email: email! , password: password!) { [weak self](login,errorModel,error) in
                if login == nil && errorModel == nil && error != nil {
                    self?.showAlertMessage(titleStr:"", messageStr: "네트워크 오류입니다.")
                } else {
                    self?.userDefaults.set(email, forKey: "email")
                    self?.userDefaults.set(password, forKey: "pass")
                    self?.userDefaults.set(true, forKey: "isLogin")
                    self?.userDefaults.synchronize()
                    let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
                    self?.present(mainView, animated: true, completion: nil)
                }
            }
        }

    }
    
}
