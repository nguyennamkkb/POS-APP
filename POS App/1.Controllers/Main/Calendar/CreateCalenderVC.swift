//
//  CreateCalenderVC.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit
import DropDown
import ObjectMapper

class CreateCalenderVC: BaseVC{

    @IBOutlet weak var vNhanVien: UIView!
    
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var btnThemKhachHang: UIButton!
    @IBOutlet weak var btnChonDichVu: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var vKhachhang: UIView!
    @IBOutlet weak var vGioThucHien: UIView!

    
    override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            self.tableView.registerCell(nibName: "DichVuCell")
            setupUI()
//            getAllEployees()
//            getAllCustomers()
//            setupData()
        }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        btnChonDichVu.layer.cornerRadius = myCornerRadius.corner10
        vKhachhang.layer.cornerRadius = myCornerRadius.corner10
        vGioThucHien.layer.cornerRadius = myCornerRadius.corner10
        vNhanVien.layer.cornerRadius = myCornerRadius.corner10
        btnThemKhachHang.layer.cornerRadius = myCornerRadius.corner10
        
        btnThemKhachHang.addBorder(color: myColor.SPA_FB!, width: 1)
        btnChonDichVu.addBorder(color: myColor.SPA_FB!, width: 1)
        vGioThucHien.addBorder(color: myColor.SPA_FB!, width: 0.2)
        vKhachhang.addBorder(color: myColor.SPA_FB!, width: 0.2)
        vNhanVien.addBorder(color: myColor.SPA_FB!, width: 0.2)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func chonDichVuPressed(_ sender: Any) {
        let vc = ChonDichVuVC()
        self.pushVC(controller: vc)
    }
    

    //    var actionOK: ClosureAction?
//    @IBOutlet var khachHangLb: UILabel!
//    @IBOutlet var nhanVienLb: UILabel!
//    @IBOutlet var chonNVView: UIView!
//    @IBOutlet var chonKHView: UIView!
//    @IBOutlet var btnChonDichVu: UIButton!
//
//    @IBOutlet var tableHeader: UIView!
//    var listEmployee = [PEmployee]()
//    var listCustomer = [PCustomer]()
//    var employeeSelected: PEmployee = PEmployee()
//    var customerSelected: PCustomer = PCustomer()
//    var listServices = [PServices]()
//    @IBOutlet var dateTimePicker: UIDatePicker!
//    
//    @IBOutlet var tableView: UITableView!
//    @IBOutlet var totalAmountLbl: UILabel!
//    
//    var statusCreateOrUpdate = 0 //0: create, 1 update
//    var itemBookUpdate = PBookCalender()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        self.tableView.registerCell(nibName: "DichVuCell")
//        setupUI()
//        getAllEployees()
//        getAllCustomers()
//        setupData()
//    }
//    func setupUI() {
//        chonNVView.layer.cornerRadius = myCornerRadius.corner10
//        chonKHView.layer.cornerRadius = myCornerRadius.corner10
//        btnChonDichVu.layer.cornerRadius = myCornerRadius.corner10
//        btnChot.layer.cornerRadius = myCornerRadius.corner10
//        
//        
//    }
//    
//    func bindData(item: PBookCalender){
//        itemBookUpdate = item
//        statusCreateOrUpdate = 1
//        
//    }
//    func setupData(){
//        khachHangLb.text = itemBookUpdate.customer?.fullName ?? "Chọn khách hàng"
//        nhanVienLb.text = itemBookUpdate.employee?.fullName ?? "Chọn nhân viên"
//        employeeSelected = itemBookUpdate.employee ?? PEmployee()
//        customerSelected = itemBookUpdate.customer  ?? PCustomer()
//        listServices = Mapper<PServices>().mapArray(JSONString: itemBookUpdate.listService ?? "" ) ?? [PServices]()
////        print("timeInterval update\(itemBookUpdate.start ?? "0")")
//        
//        updateAmount()
//        if statusCreateOrUpdate == 1 {
//            tableHeader.isHidden = false
//            dateTimePicker.date = Common.dateFromUnixTimestamp(milliseconds: Double( itemBookUpdate.start ?? "0") ?? 0    )
//        }else{
//            tableHeader.isHidden = true
//        }
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listServices.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DichVuCell", for: indexPath) as? DichVuCell else {return UITableViewCell()}
//        cell.bindData(item: listServices[indexPath.row])
//        return cell
//    }
//    
//    @IBAction func backPressed(_ sender: Any) {
//        self.onBackNav()
//    }
//    @IBAction func btnSelectNVPressed(_ sender: UIButton) {
//        var list =  [String]()
//        if listEmployee.count == 0 {
//            self.showAlert(message: "Không có dữ liệu!")
//            return
//        }
//        let dropDown = DropDown()
//        listEmployee.forEach{
//            list.append($0.fullName ?? "")
//        }
//        dropDown.dataSource = list //4
//        dropDown.anchorView = sender //5
//        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
//        dropDown.show() //7
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
//            guard let self = self else { return }
//            self.nhanVienLb.text = item
//            self.employeeSelected = self.listEmployee.itemAtIndex(index: index) ?? PEmployee()
////            print(self.listEmployee.itemAtIndex(index: index)?.toJSON() ?? "")
//        }
//    }
//    @IBAction func btnSelectKHPressed(_ sender: UIButton) {
//        var list =  [String]()
//        if listCustomer.count == 0 {
//            self.showAlert(message: "Không có dữ liệu!")
//            return
//        }
//        let dropDown = DropDown()
//        listCustomer.forEach{
//            list.append($0.fullName ?? "")
//        }
//        dropDown.dataSource = list //4
//        dropDown.anchorView = sender //5
//        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
//        dropDown.show() //7
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
//            guard let self = self else { return }
//            self.khachHangLb.text = item
//            self.customerSelected = self.listCustomer.itemAtIndex(index: index) ?? PCustomer()
//        }
//    }
//    
//    @IBAction func themMoiKHPressed(_ sender: UIButton) {
//        self.pushVC(controller: CreateCustomerVC())
//    }
//    
//    @IBAction func btnChonDichVuPressed(_ sender: UIButton) {
//        let vc = ChonDichVuVC()
//        vc.bindData(listItem: listServices )
//        vc.returnDataSelected = {
//            [weak self] item in
//            guard let self = self else {return}
//            self.listServices = item
//            if item.count > 0 { self.tableHeader.isHidden = false }
//            else {self.tableHeader.isHidden = true}
//            self.updateAmount()
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        self.pushVC(controller: vc)
//    }
//    
//    func getAllEployees(){
//        guard let id = Common.userMaster.id else {return}
//        let param = ParamSearch(store_id: id, status: 1)
//        ServiceManager.common.getAllEmployees(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
//            (response) in
//            if response?.data != nil, response?.statusCode == 200 {
//                self.listEmployee = Mapper<PEmployee>().mapArray(JSONObject: response!.data ) ?? [PEmployee]()
//            } else if response?.statusCode == 0 {
//                self.showAlert(message: "Không thể lấy dữ liệu")
//            }
//        }
//    }
//    func getAllCustomers(){
//        guard let id = Common.userMaster.id else {return}
//        let param = ParamSearch(store_id: id, status: 1)
//        ServiceManager.common.getAllCustomers(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
//            (response) in
//            if response?.data != nil, response?.statusCode == 200 {
//                self.listCustomer = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
//                
//            } else if response?.statusCode == 0 {
//                self.showAlert(message: "Không thể lấy dữ liệu")
//            }
//        }
//    }
//    func updateAmount(){
//        totalAmountLbl.text = String(getTotalAmount()).currencyFormatting()
//    }
//    func getTotalAmount() -> Int {
//        let filtered = listServices.filter { $0.status == 1 }
//        var amount: Int = 0
//        for item in filtered {
//            if item.status == 1 {
//                amount += item.price ?? 0
//            }
//        }
//        return amount
//    }
//    
//    @IBAction func btnAcceptPresses(_ sender: UIButton) {
//        let book = PBookCalender()
//        book.start = String(dateTimePicker.date.millisecondsSince1970)
//        book.store_id = Common.userMaster.id
//        book.listService = listServices.toJSONString()
//        book.amount = getTotalAmount()
//        book.status = 0
//        book.idEmployee = employeeSelected.id
//        book.idCustomer = customerSelected.id
//        book.sign()
//        if statusCreateOrUpdate == 0 {
//            createBook(item: book)
//        }else{
//            updateBook(item: book)
//        }
//       
//    }
//    func createBook(item: PBookCalender){
////        print("PBookCalender \(item.toJSON())")
//        self.showLoading()
//        ServiceManager.common.createBook(param: item){
//            (response) in
//            self.hideLoading()
//            if response?.data != nil, response?.statusCode == 200 {
//                self.showAlert(message: "Thành công!")
//                self.actionOK?()
//                self.onBackNav()
//            } else if response?.statusCode == 0 {
//                self.showAlert(message: "Không thể thêm mới")
//            }
//        }
//        
//    }
//    func updateBook(item: PBookCalender){
////        print("PBookCalender \(item.toJSON())")
//        item.id = itemBookUpdate.id ?? 0
//        self.showLoading()
//        ServiceManager.common.editBook(param: item){
//            (response) in
//            self.hideLoading()
//            if response?.data != nil, response?.statusCode == 200 {
//                self.showAlert(message: "Thành công!")
//                self.actionOK?()
//                self.onBackNav()
//            } else if response?.statusCode == 0 {
//                self.showAlert(message: "Không thể thêm mới")
//            }
//        }
//        
//    }
}

extension CreateCalenderVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DichVuCell", for: indexPath) as? DichVuCell else {return UITableViewCell()}
    return cell

    }
    
    
}
