//
//  EmployeeDetailVC.swift
//  POS App
//
//  Created by namnl on 10/06/2023.
//

import UIKit

class EmployeeDetailVC: BaseVC {

    
    
    var deleteSuccess: ClosureAction?
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var workFrom: UILabel!
    @IBOutlet weak var workCount: UILabel!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    var employee = PEmployee()
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
        print(employee.birthday)
        print(employee.createAt)
        print("======")
        nameLbl.text = "Họ tên: \(employee.fullName ?? "")"
        birthdayLbl.text = "Ngày sinh: \(Common.convertTimestampToDate(timestampString: employee.birthday ?? "", dateFormat: "dd-MM-yyyy"))"
        addressLbl.text = "Địa chỉ: \(employee.address ?? "")"
        genderLbl.text = "\(employee.gender == 1 ? "Nam" : "Nữ")"
        workFrom.text = "Vào làm: \(Common.convertTimestampToDate(timestampString: employee.createAt ?? "", dateFormat: "dd-MM-yyyy"))"
    }
    func bindData(item: PEmployee){
        employee = item
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func btnEditPressed(_ sender: UIButton) {
        self.showMessageDeveloping()
    }
    
    @IBAction func btnDeletePressed(_ sender: UIButton) {
        employee.status = 0
        ServiceManager.common.updateEmployee(param: employee){
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
