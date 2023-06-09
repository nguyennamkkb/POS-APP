//
//  CreateCalenderVC.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit
import DropDown
import ObjectMapper

class CreateCalenderVC: BaseVC, UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet var btnChot: UIButton!
    var actionOK: ClosureAction?
    @IBOutlet var khachHangLb: UILabel!
    @IBOutlet var nhanVienLb: UILabel!
    @IBOutlet var chonNVView: UIView!
    @IBOutlet var chonKHView: UIView!
    @IBOutlet var btnChonDichVu: UIButton!

    @IBOutlet var tableHeader: UIView!
    var listEmployee = [PEmployee]()
    var listCustomer = [PCustomer]()
    var employeeSelected: PEmployee = PEmployee()
    var customerSelected: PCustomer = PCustomer()
    var listServices = [PServices]()
    @IBOutlet var dateTimePicker: UIDatePicker!
    
    @IBOutlet var HeadTableView: UIView!
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var totalAmountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "DichVuCell")
        
        setupUI()
        getAllEployees()
        getAllCustomers()
        print("viewdidload")
    }
    func setupUI() {
        chonNVView.layer.cornerRadius = myCornerRadius.corner10
        chonKHView.layer.cornerRadius = myCornerRadius.corner10
        btnChonDichVu.layer.cornerRadius = myCornerRadius.corner10
        btnChot.layer.cornerRadius = myCornerRadius.corner10
        tableHeader.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DichVuCell", for: indexPath) as? DichVuCell else {return UITableViewCell()}
        cell.bindData(item: listServices[indexPath.row])
        return cell
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
//            print(self.listEmployee.itemAtIndex(index: index)?.toJSON() ?? "")
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
//            print(self.listCustomer.itemAtIndex(index: index)?.toJSON() ?? "")
        }
    }
    
    @IBAction func BtnSelectDateTime(_ sender: UIButton) {
//        print("BtnSelectDateTime")
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
        let vc = ChonDichVuVC()
        vc.bindData(listItem: listServices )
        vc.returnDataSelected = {
            [weak self] item in
            guard let self = self else {return}
            self.listServices = item
            if item.count > 0 { self.tableHeader.isHidden = false }
            else {self.tableHeader.isHidden = true}
            self.updateAmount()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.pushVC(controller: vc)
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
    func updateAmount(){
        totalAmountLbl.text = String(getTotalAmount()).currencyFormatting()
    }
    func getTotalAmount() -> Int {
        let filtered = listServices.filter { $0.status == 1 }
        var amount: Int = 0
        for item in filtered {
            if item.status == 1 {
                amount += item.price ?? 0
            }
        }
        return amount
    }
    
    @IBAction func btnAcceptPresses(_ sender: UIButton) {
        let book = PBookCalender()
        book.start = Int(NSDate().timeIntervalSince1970)
        book.store_id = Common.userMaster.id
        book.listService = listServices.toJSONString()
        book.amount = getTotalAmount()
        book.status = 0
        book.idEmployee = employeeSelected.id
        book.idCustomer = customerSelected.id

//        print(book.toJSON())
        createBook(item: book)
    }
    func createBook(item: PBookCalender){
//        print("PBookCalender \(item.toJSON())")
        ServiceManager.common.createBook(param: item){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOK?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
        
    }
}
