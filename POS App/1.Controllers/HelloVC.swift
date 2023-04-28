//
//  HelloVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class HelloVC: UIViewController {

    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnCreateAccount: UIButton!
    @IBOutlet var mockPOSLbl: UILabel!
    @IBOutlet var iconPOS: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    func setupUI(){
        mockPOSLbl.layer.shadowColor = UIColor.black.cgColor
        mockPOSLbl.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        mockPOSLbl.layer.shadowRadius = 2
        iconPOS.layer.cornerRadius = myCornerRadius.corner5
        btnLogin.layer.cornerRadius = myCornerRadius.corner10
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = myColor.blue?.cgColor
        btnCreateAccount.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }
}
