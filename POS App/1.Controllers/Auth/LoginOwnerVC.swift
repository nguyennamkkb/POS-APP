//
//  LoginOwnerVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class LoginOwnerVC: BaseVC {

    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var emailView: UIView!
    @IBOutlet var whatappView: UIView!
    @IBOutlet var smsView: UIView!
    @IBOutlet var missedCallView: UIView!
    @IBOutlet var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI(){
        userTF.layer.cornerRadius = myCornerRadius.corner10
        passwordTF.layer.cornerRadius = myCornerRadius.corner10
        emailView.layer.cornerRadius = myCornerRadius.corner10
        whatappView.layer.cornerRadius = myCornerRadius.corner10
        smsView.layer.cornerRadius = myCornerRadius.corner10
        missedCallView.layer.cornerRadius = myCornerRadius.corner10
        btnLogin.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.onBackNav()
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
