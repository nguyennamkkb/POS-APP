//
//  CreateCustomerVC.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit

class CreateCustomerVC: BaseVC{
    
    var actionOk: ClosureAction?
    var actionCapNhatOK: ClosureCustom<PCustomer>?
    var customer: PCustomer = PCustomer()
    var trangThaiSua: Int = 0
    @IBOutlet weak var lbTieuDe: UILabel!
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "CreateCustomerCell")

        setupUI()
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    func bindDataSua(e: PCustomer){
        customer = e
        trangThaiSua = 1
    }
    
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        
        if trangThaiSua == 1 {
            lbTieuDe.text = "Sửa khách hàng"
        }else {
            lbTieuDe.text = "Thêm khách hàng"
        }
    }
    
    @IBAction func btnThemMoiPressed(_ sender: Any) {
        print(customer.toJSON())
        
        var trangThaiLoi: Int = 1
        if customer.fullName == nil || customer.fullName?.count == 0 {
            print("fullName")
            trangThaiLoi = 0
        }
        
        if   customer.phone == nil || customer.phone?.count ?? 0 < 9 {
            print("phone")
            trangThaiLoi = 0
        }
        if   customer.birthday == nil || customer.birthday?.count ?? 0 == 0{
            print("birthday")
            trangThaiLoi = 0
        }
         if  customer.address == nil || customer.address?.count ?? 0 == 0{
            print("address")
             trangThaiLoi = 0
        }
         if  customer.gender == nil{
            print("gender")
             trangThaiLoi = 0
        }
    
        if trangThaiLoi == 0 {
            hienThiLoiNhan(s: "Hãy điền đủ thông tin")
            return
        }
        customer.store_id =  Common.userMaster.id ?? -1
        
        if trangThaiSua == 1 {
            updateCustomer()
        }else {
            createCustomer()
        }
    }

    func createCustomer(){
        customer.sign()
        self.showLoading()
        ServiceManager.common.createCustomer(param: customer){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.onBackNav()
                self.actionOk?()
            } else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng")
            }
        }
        
    }
    func updateCustomer(){
        customer.sign()
        ServiceManager.common.updateCustomer(param: customer){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.hienThiThongBao(trangThai: 1, loiNhan: "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                    self.onBackNav()
                    self.actionCapNhatOK?(self.customer)
                }
            } else {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Hãy kiẻm tra thông tin nhập hoặc mạng")
            }
        }
    }
}

extension CreateCustomerVC:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCustomerCell", for: indexPath) as? CreateCustomerCell else {return UITableViewCell()}
        cell.bindData(item: customer)
        return cell
    }
    
    
}
