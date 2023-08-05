//
//  MainFilterVC.swift
//  POS App
//
//  Created by namnl on 02/07/2023.
//

import UIKit
import DropDown
import ObjectMapper


class MainFilterVC: BaseVC {

    
    var actionFilter: ClosureCustom<ParamSearchBook>?
    
    
    @IBOutlet var chonVNView: UIView!
    @IBOutlet var chonKHView: UIView!
    @IBOutlet var chonSTTView: UIView!
    
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnGetAll: UIButton!
    @IBOutlet var trangThaiLbl: UILabel!
    @IBOutlet var khachHangLbl: UILabel!
    @IBOutlet var nhanVienLb: UILabel!

    @IBOutlet var btnSelectKH: UIButton!
    @IBOutlet var btnSelectNV: UIButton!
    
    @IBOutlet var timeFrom: UIDatePicker!
    @IBOutlet var timeTo: UIDatePicker!
    
    
    var listEmployee = [PEmployee]()
    var employeeSelected: PEmployee = PEmployee()
    
    var listCustomer = [PCustomer]()
    var customerSelected: PCustomer = PCustomer()
    var statusSelected: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEployees()
        getAllCustomers()
        
        setupUI()
    }
    func setupUI() {
        btnSearch.layer.cornerRadius = myCornerRadius.corner5
        btnGetAll.layer.cornerRadius = myCornerRadius.corner5
        chonVNView.layer.cornerRadius = myCornerRadius.corner5
        chonKHView.layer.cornerRadius = myCornerRadius.corner5
        chonSTTView.layer.cornerRadius = myCornerRadius.corner5
    }
    @IBAction func btnSelectNVPressed(_ sender: UIButton) {
        var list =  [String]()
        if listEmployee.count == 0 {
            self.showAlert(message: "Không có dữ liệu!")
            return
        }
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
//            print(self.listEmployee.itemAtIndex(index: index)?.toJSON() ?? "")
        }
    }
    
    @IBAction func btnSelectKHPressed(_ sender: UIButton) {
        var list =  [String]()
        if listCustomer.count == 0 {
            self.showAlert(message: "Không có dữ liệu!")
            return
        }
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
            self.khachHangLbl.text = item
            self.customerSelected = self.listCustomer.itemAtIndex(index: index) ?? PCustomer()
        }
    }

    @IBAction func btnSelectSTTPressed(_ sender: UIButton) {
        let list =  ["Tất cả","Chưa thực hiện","Hoàn thành","Chờ thanh toán","Đang thực hiện"]
        let dropDown = DropDown()
        dropDown.dataSource = list //4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let self = self else { return }
            self.trangThaiLbl.text = item
            self.statusSelected = index
        }
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {
        let param = ParamSearchBook(store_id: Common.userMaster.id ?? 0)
        if statusSelected != -1 && statusSelected > 0  {
            param.status = statusSelected - 1
        }
        if customerSelected.id != nil {
            param.idCustomer = customerSelected.id
        }
        if employeeSelected.id != nil {
            param.idEmployee = employeeSelected.id
        }
        param.from = Int64(timeFrom.date.millisecondsSince1970)
        param.to = Int64(timeTo.date.millisecondsSince1970)
        actionFilter?(param)
        dismissVC(animated: true)
    }
    
    func getAllEployees(){
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(store_id: id, status: 1)
        ServiceManager.common.getAllEmployees(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
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
        let param = ParamSearch(store_id: id, status: 1)
        ServiceManager.common.getAllCustomers(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.listCustomer = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
                
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể lấy dữ liệu")
            }
        }
    }
    
    @IBAction func getAllPressed(_ sender: UIButton) {
        let param = ParamSearchBook(store_id: Common.userMaster.id ?? 0)
        actionFilter?(param)
        dismissVC(animated: true)
    }
    
    
}
