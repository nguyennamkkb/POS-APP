//
//  ManageStoreVC.swift
//  POS App
//
//  Created by namnl on 26/04/2023.
//

import UIKit

class ManageStoreVC: BaseVC {

    @IBOutlet var btnDichVuView: UIView!
    @IBOutlet var btnKhachHangView: UIView!
    @IBOutlet var btnNhanVienView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI(){
        btnKhachHangView.layer.cornerRadius = myCornerRadius.corner5
        btnDichVuView.layer.cornerRadius = myCornerRadius.corner5
        btnNhanVienView.layer.cornerRadius = myCornerRadius.corner5
        
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
    @IBAction func btnServicesPressed(_ sender: UIButton) {
        self.showMessageDeveloping()
    }
   

}
