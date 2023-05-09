//
//  HelloVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class HelloVC: BaseVC {

    @IBOutlet var btnLogin: UIButton!
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
    }

    @IBAction func createAccontPressed(_ sender: UIButton) {
        self.pushVC(controller: SignUpVC())
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        self.pushVC(controller: LoginVC())
    }
}
