//
//  EmployeeDetailVC.swift
//  POS App
//
//  Created by namnl on 10/06/2023.
//

import UIKit

class EmployeeDetailVC: BaseVC {

    
    
    
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        btnDelete.layer.cornerRadius = myCornerRadius.corner5
        btnEdit.layer.cornerRadius = myCornerRadius.corner5
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnEditPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnDeletePressed(_ sender: UIButton) {
    }
    
    

}
