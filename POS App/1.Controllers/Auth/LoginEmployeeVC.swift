//
//  LoginEmployeeVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class LoginEmployeeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
