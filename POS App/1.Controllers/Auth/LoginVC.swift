//
//  LoginVC.swift
//  POS App
//
//  Created by namnl on 07/05/2023.
//

import UIKit

class LoginVC: BaseVC {
    var storeData = PStore()
    @IBOutlet var btnShowPassword: UIButton!
    var isShowPassword: Bool = false
    @IBOutlet var btnDangNhap: UIButton!
    
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func bindData(item:PStore){
        storeData = item
        phoneTF.text = item.phone
        passwordTF.text = item.password
    }
    @IBAction func backPressed(_ sender: UIButton) {
        self.onBackNav()
    }
    func setupUI(){
        btnDangNhap.layer.cornerRadius = myCornerRadius.corner10
//        loginOwnerView.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func loginOwnerPressed(_ sender: UIButton) {
        self.pushVC(controller: TabBarVC())
    }
    @IBAction func hideOrShowPassword(_ sender: UIButton) {
        isShowPassword = !isShowPassword
        if isShowPassword {
            btnShowPassword.setBackgroundImage(UIImage(named: "eys"), for: .normal)
            //code show
        }else{
            btnShowPassword.setBackgroundImage(UIImage(named: "eys.slash"), for: .normal)
            //code hide
        }
    }
    
}
