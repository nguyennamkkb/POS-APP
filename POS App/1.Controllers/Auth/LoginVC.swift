//
//  LoginVC.swift
//  POS App
//
//  Created by namnl on 07/05/2023.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var loginEmployeeView: UIView!
    @IBOutlet weak var loginOwnerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func backPressed(_ sender: UIButton) {
        self.onBackNav()
    }
    func setupUI(){
        loginEmployeeView.layer.cornerRadius = myCornerRadius.corner10
        loginOwnerView.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func loginOwnerPressed(_ sender: UIButton) {
        self.pushVC(controller: LoginOwnerVC())
    }
    
    @IBAction func loginEmployeePressed(_ sender: UIButton) {
        self.pushVC(controller: LoginEmployeeVC())
    }
    

}
