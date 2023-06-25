//
//  CustomerDetailVC.swift
//  POS App
//
//  Created by namnl on 25/06/2023.
//

import UIKit

class CustomerDetailVC: BaseVC {
    var deleteSuccess: ClosureAction?
    
    
    @IBOutlet weak var QRImage: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var workFrom: UILabel!
    @IBOutlet weak var workCount: UILabel!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    var customer = PCustomer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        setData()
    }
    
    func setupUI(){
//        btnDelete.layer.cornerRadius = myCornerRadius.corner5
//        btnEdit.layer.cornerRadius = myCornerRadius.corner5
        cardView.layer.cornerRadius = myCornerRadius.corner5
        QRImage.layer.cornerRadius = myCornerRadius.corner10
        
        
    }
    func setData(){
        nameLbl.text = "Họ tên: \(customer.fullName ?? "")"
        birthdayLbl.text = "Ngày sinh: \(Common.convertTimestampToDate(timestampString: customer.birthday ?? "", dateFormat: "dd-MM-yyyy"))"
        addressLbl.text = "Địa chỉ: \(customer.address ?? "")"
        genderLbl.text = "Giới tính: \(customer.gender == 1 ? "Nam" : "Nữ")"
        workFrom.text = "Vào làm: \(Common.convertTimestampToDate(timestampString: customer.createAt ?? "", dateFormat: "dd-MM-yyyy"))"
    }
    func bindData(item: PCustomer){
        customer = item
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnEditPressed(_ sender: UIButton) {
        self.showMessageDeveloping()
    }
    
    @IBAction func btnDeletePressed(_ sender: UIButton) {
        customer.status = 0
        ServiceManager.common.updateCustomer(param: customer){
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
