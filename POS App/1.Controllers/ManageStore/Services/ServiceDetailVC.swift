//
//  ServiceDetailVC.swift
//  POS App
//
//  Created by namnl on 14/06/2023.
//

import UIKit

class ServiceDetailVC: BaseVC {
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var nodelbl: UILabel!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    var deleteSuccess: ClosureAction?
    var services = PServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
    }
    func setupUI(){
        btnDelete.layer.cornerRadius = myCornerRadius.corner5
        btnEdit.layer.cornerRadius = myCornerRadius.corner5
        
        
    }
    func setData(){
        nodelbl.text = "\(services.note ?? "")"
        nameLbl.text = "DV: \(services.name ?? "")"
        priceLbl.text = "Giá: " + "\(services.price ?? 0)".currencyFormatting()
    }

    func bindData(item: PServices){
        services = item
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnEditPressed(_ sender: UIButton) {
        self.showMessageDeveloping()
    }
    
    @IBAction func btnDeletePressed(_ sender: UIButton) {
        services.status = 0
        ServiceManager.common.updateServices(param: services){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Đã xoá!")
                self.deleteSuccess?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }
}
