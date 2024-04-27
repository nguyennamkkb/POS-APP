//
//  ForgetPasswordVC.swift
//  LN POS
//
//  Created by Mac mini on 23/04/2024.
//

import UIKit

class ForgetPasswordVC: BaseVC {

    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var btnGuiEmail: UIButton!
    @IBOutlet weak var vForm: UIView!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfOTP: UITextField!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vPass: UIView!
    @IBOutlet weak var vOTP: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    func setupUI(){
        btnGuiEmail.layer.cornerRadius = myCornerRadius.corner10
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        vForm.layer.cornerRadius = myCornerRadius.corner20
        vEmail.layer.cornerRadius = myCornerRadius.corner10
        vOTP.layer.cornerRadius = myCornerRadius.corner10
        vPass.layer.cornerRadius = myCornerRadius.corner10
        vEmail.addBorder(color: myColor.SPA_FE!, width: 1)
        vOTP.addBorder(color: myColor.SPA_FE!, width: 1)
        vPass.addBorder(color: myColor.SPA_FE!, width: 1)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
}
