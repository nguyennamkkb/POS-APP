//
//  LoginVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class LoginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        
    }

    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.onBackNav()
    }
    
}
