//
//  CreateCalenderVC.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit
import DropDown
import ObjectMapper

class CreateCalenderVC: BaseVC {
    
    @IBOutlet var khachHangLb: UILabel!
    @IBOutlet var nhanVienLb: UILabel!
    @IBOutlet var chonNVView: UIView!
    @IBOutlet var chonKHView: UIView!
    @IBOutlet var btnChonDichVu: UIButton!
    @IBOutlet var nhanVienLB: UILabel!
    var listEmployee = [PEmployee]()
    var listCustomer = [PCustomer]()
    var employeeSelected: PEmployee = PEmployee()
    var customerSelected: PCustomer = PCustomer()
    @IBOutlet var dateTimePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getAllEployees()
        getAllCustomers()
    }
    func setupUI() {
        chonNVView.layer.cornerRadius = myCornerRadius.corner10
        chonKHView.layer.cornerRadius = myCornerRadius.corner10
        btnChonDichVu.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func btnSelectNVPressed(_ sender: UIButton) {
        var list =  [String]()
        let dropDown = DropDown()
        listEmployee.forEach{
            list.append($0.fullName ?? "")
        }
        dropDown.dataSource = list //4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let self = self else { return }
            self.nhanVienLb.text = item
            self.employeeSelected = self.listEmployee.itemAtIndex(index: index) ?? PEmployee()
            print(self.listEmployee.itemAtIndex(index: index)?.toJSON() ?? "")
        }
    }
    @IBAction func btnSelectKHPressed(_ sender: UIButton) {
        var list =  [String]()
        let dropDown = DropDown()
        listCustomer.forEach{
            list.append($0.fullName ?? "")
        }
        dropDown.dataSource = list //4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let self = self else { return }
            self.khachHangLb.text = item
            self.customerSelected = self.listCustomer.itemAtIndex(index: index) ?? PCustomer()
            print(self.listCustomer.itemAtIndex(index: index)?.toJSON() ?? "")
        }
    }
    
    @IBAction func BtnSelectDateTime(_ sender: UIButton) {
        print("BtnSelectDateTime")
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date.timeIntervalSince1970
        print(selectedDate)
    }
    
    @IBAction func themMoiKHPressed(_ sender: UIButton) {
        self.pushVC(controller: CreateCustomerVC())
    }
    
    @IBAction func btnChonDichVuPressed(_ sender: UIButton) {
    }
    
    func getAllEployees(){
        guard let id = Common.userMaster.id else {return}
        
        let param: String = "store_id=\(id)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        ServiceManager.common.getAllEmployees(param: "?\(param)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.listEmployee = Mapper<PEmployee>().mapArray(JSONObject: response!.data ) ?? [PEmployee]()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể lấy dữ liệu")
            }
        }
    }
    func getAllCustomers(){
        guard let id = Common.userMaster.id else {return}
        
        let param: String = "store_id=\(id)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        ServiceManager.common.getAllCustomers(param: "?\(param)"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.listCustomer = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể lấy dữ liệu")
            }
        }
    }
}
