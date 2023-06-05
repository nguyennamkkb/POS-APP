//
//  ManageStoreVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class ManageStoreVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.wrapRoot(vc: TabBarVC())
    }
    
    
    @IBAction func btnEmployeePressed(_ sender: UIButton) {
        self.pushVC(controller: EmployeeVC())
    }
    @IBAction func btnCustomerPressed(_ sender: UIButton) {
        self.pushVC(controller: CustomerVC())
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
