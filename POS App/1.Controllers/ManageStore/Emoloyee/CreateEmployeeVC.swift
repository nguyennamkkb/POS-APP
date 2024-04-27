//
//  CreateEmployeeVC.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import ObjectMapper

class CreateEmployeeVC: BaseVC {

    var actionOK: ClosureAction?
    var actionCapNhatOK: ClosureCustom<PEmployee>?
    var employee: PEmployee = PEmployee()
    var trangThaiSua: Int = 0
    @IBOutlet weak var lbTieuDe: UILabel!
    @IBOutlet weak var bXacNhan: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "CreateEmployeeCell")
        setupUI()
        
    }

    func setupUI(){
        bXacNhan.layer.cornerRadius = myCornerRadius.corner10
        if trangThaiSua == 1 {
            lbTieuDe.text = "Sửa nhân viên"
        }else {
            lbTieuDe.text = "Thêm nhân viên"
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindDataSua(e: PEmployee){
        employee = e
        trangThaiSua = 1
    }
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        
        print("employee", employee.toJSON())
        var trangThaiLoi: Int = 1
        if employee.fullName == nil || employee.fullName?.count == 0 {
            print("fullName")
            trangThaiLoi = 0
        }
        
        if   employee.phone == nil || employee.phone?.count ?? 0 < 9 {
            print("phone")
            trangThaiLoi = 0
        }
        if   employee.birthday == nil || employee.birthday?.count ?? 0 == 0{
            print("birthday")
            trangThaiLoi = 0
        }
         if  employee.address == nil || employee.address?.count ?? 0 == 0{
            print("address")
             trangThaiLoi = 0
        }
         if  employee.gender == nil{
            print("gender")
             trangThaiLoi = 0
        }
    
        if trangThaiLoi == 0 {
            hienThiLoiNhan(s: "Hãy điền đủ thông tin")
            return
        }
        employee.store_id =  Common.userMaster.id ?? -1
        
        if trangThaiSua == 1 {
            updateEmployee()
        }else {
            createEmployee()
        }
       
        
    }

    func createEmployee(){
        employee.sign()
        ServiceManager.common.createEmployee(param: employee){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.onBackNav()
                self.actionOK?()
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng")
            }
        }
        
    }
    func updateEmployee(){
        employee.sign()
        ServiceManager.common.updateEmployee(param: employee){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
      
                    self.actionCapNhatOK?(self.employee)
                    self.onBackNav()
                }
          
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng!")
            }
        }
    }
}
extension CreateEmployeeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEmployeeCell", for: indexPath) as? CreateEmployeeCell else {return UITableViewCell()}
        cell.bindData(item: employee)
        return cell
    }
    
    
}

