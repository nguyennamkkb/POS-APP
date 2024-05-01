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
    
    let dropdown = DropdownVC()
    
    var trangThaiThemMoiorCapNhat: Int = 0 //0 themmoi, 1 capnhat
    var book: PBookCalender = PBookCalender()
    
    @IBOutlet weak var lbTongTien: UILabel!
    @IBOutlet weak var dpGioLam: UIDatePicker!
    @IBOutlet weak var lbChonKhachHang: UILabel!
    @IBOutlet weak var lbChonNhanVIen: UILabel!
    @IBOutlet weak var vNhanVien: UIView!
    
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var btnThemKhachHang: UIButton!
    @IBOutlet weak var btnChonDichVu: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var vKhachhang: UIView!
    @IBOutlet weak var vGioThucHien: UIView!
    var employeeSelected: PEmployee = PEmployee()
    var customerSelected: PCustomer = PCustomer()
    var dsNhanVien :[PEmployee] = [PEmployee]()
    var dsKhachHang :[PCustomer] = [PCustomer]()
    var dsDichVu :[PServices] = [PServices]()
    var dsDichVuChon :[PServices] = [PServices]()
    
    let thamSoTimKiemNhanVien = ParamSearch(store_id: Common.userMaster.id ?? -1, status: 1,keySearch: "")
    let thamSoTimKiemKhachHang = ParamSearch(store_id: Common.userMaster.id ?? -1, status: 1,keySearch: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "DichVuCell")
        setupUI()
        
        getAllServices()
        getAllEployees(){}
        getAllCustomers(){}
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
        vc.bindData(l: dsDichVu)
        vc.danhSachDaChon = {
            [weak self] l in
            guard let self =  self else {return}
            self.dsDichVuChon = l
            DispatchQueue.main.async {
                self.lbTongTien.text = "\(self.capNhatSoTien())".currencyFormatting()
                self.tableView.reloadData()
            }
        }
        self.pushVC(controller: vc)
    }
    @IBAction func btnThemKhachHangPressed(_ sender: Any) {
        let vc = CreateCustomerVC()
        self.pushVC(controller: vc)
    }

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
 
    override func viewDidAppear(_ animated: Bool) {

    }
    @IBAction func btnChonNhanVienPressed(_ sender: Any) {
        
        dropdown.bindDataNhanVien(e: dsNhanVien)
        dropdown.modalPresentationStyle = .overCurrentContext
        dropdown.modalTransitionStyle = .crossDissolve
        
        dropdown.daChon = {
            [weak self] e in
            guard let self = self else {return}
            if let object = e as? PEmployee {
                //                    print(object.toJSON())
                self.employeeSelected = object
                self.lbChonNhanVIen.text = object.fullName
            }
        }
        dropdown.timKiemNoiDung = {
            [weak self] tuKhoa in
            guard let self = self else {return}
            
            thamSoTimKiemNhanVien.keySearch = tuKhoa
            self.getAllEployees(){
                self.dropdown.bindDataNhanVien(e: self.dsNhanVien)
            }
            
        }
        dropdown.xemThem = {
            [weak self] tuKhoa in
            guard let self = self else {return}
            self.thamSoTimKiemNhanVien.page = (self.thamSoTimKiemNhanVien.page ?? 1) + 1
            thamSoTimKiemNhanVien.keySearch = tuKhoa
            self.getAllEployees(){
                self.dropdown.bindDataNhanVien(e: self.dsNhanVien)
            }
        }
        
        dropdown.actTaiLai = {
            [weak self]  in
            guard let self = self else {return}
            self.thamSoTimKiemNhanVien.page = 1
            thamSoTimKiemNhanVien.keySearch = ""
            self.getAllEployees(){
                self.dropdown.bindDataNhanVien(e: self.dsNhanVien)
            }

        }
        present(dropdown, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnChonKhachHangPressed(_ sender: Any) {
        dropdown.bindDataKhachHang(e: dsKhachHang)
        dropdown.modalPresentationStyle = .overCurrentContext
        dropdown.modalTransitionStyle = .crossDissolve
        if dsKhachHang.count > 0 {
            dropdown.daChon = {
                [weak self] e in
                guard let self = self else {return}
                if let object = e as? PCustomer {
                    //                    print(object.toJSON())
                    self.customerSelected = object
                    self.lbChonKhachHang.text = object.fullName
                }
            }
            dropdown.timKiemNoiDung = {
                [weak self] tuKhoa in
                guard let self = self else {return}
                thamSoTimKiemKhachHang.keySearch = tuKhoa
                self.getAllCustomers(){
                    self.dropdown.bindDataKhachHang(e: self.dsKhachHang)
                }
                
                
            }
            dropdown.xemThem = {
                [weak self] tuKhoa in
                guard let self = self else {return}
                thamSoTimKiemKhachHang.page = (self.thamSoTimKiemKhachHang.page ?? 1) + 1
                thamSoTimKiemKhachHang.keySearch = tuKhoa
                self.getAllCustomers(){
                    self.dropdown.bindDataKhachHang(e: self.dsKhachHang)
                }
            }
            dropdown.actTaiLai = {
                [weak self]  in
                guard let self = self else {return}
                self.thamSoTimKiemKhachHang.page = 1
                thamSoTimKiemKhachHang.keySearch = ""
                self.getAllCustomers(){
                    self.dropdown.bindDataKhachHang(e: self.dsKhachHang)
                }

            }
            
            present(dropdown, animated: true, completion: nil)
        }
    }

    
    func getAllEployees( completion: @escaping () -> Void){

        ServiceManager.common.getAllEmployees(param: "?\(Utility.getParamFromDirectory(item: thamSoTimKiemNhanVien.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.dsNhanVien = Mapper<PEmployee>().mapArray(JSONObject: response!.data ) ?? [PEmployee]()
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại mạng!")
            }
            completion()
        }
    }
    func timKiemAllCustomers(tuKhoa: String? = ""){
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(store_id: id, status: 1,keySearch: tuKhoa)
        ServiceManager.common.getAllCustomers(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.dsKhachHang = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại mạng!")
            }
        }
    }

    func getAllCustomers(completion: @escaping () -> Void) {

        ServiceManager.common.getAllCustomers(param: "?\(Utility.getParamFromDirectory(item: thamSoTimKiemKhachHang.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.dsKhachHang = Mapper<PCustomer>().mapArray(JSONObject: response!.data ) ?? [PCustomer]()
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại mạng!")
            }
            completion()
        }
    }
    func getAllServices(){
        guard let id = Common.userMaster.id else {return}

        let param = ParamSearch(store_id: id, status: 1)
        
        ServiceManager.common.getAllServices(param: "?\(Utility.getParamFromDirectory(item: param.toJSON())))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.dsDichVu = Mapper<PServices>().mapArray(JSONObject: response!.data ) ?? [PServices]()
     
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại mạng!")
            }
        }
    }
    
    //    func updateAmount(){
    //        totalAmountLbl.text = String(getTotalAmount()).currencyFormatting()
    //    }
        func capNhatSoTien() -> Int {
//            let filtered = dsDichVuChon.filter { $0.status == 2 }
            var amount: Int = 0
            for item in dsDichVuChon {
            
                if item.status == 2 {
                    amount += item.price ?? 0
                }
            }
            
            return amount
        }
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
        func createBook(){ // dat lich
    //        print("PBookCalender \(item.toJSON())")
            book.sign()
            self.showLoading()
            ServiceManager.common.createBook(param: book){
                (response) in
                self.hideLoading()
                if response?.data != nil, response?.statusCode == 200 {
                    self.showAlert(message: "Thành công!")
//                    self.actionOK?()
//                    self.onBackNav()
                } else if response?.statusCode == 0 {
                    self.showAlert(message: "Không thể thêm mới")
                }
            }
    
        }
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
        return dsDichVuChon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DichVuCell", for: indexPath) as? DichVuCell else {return UITableViewCell()}
        let item = dsDichVuChon.itemAtIndex(index: indexPath.row) ?? PServices()
        cell.bindData(e: item)
        return cell
        
    }
    
    
}
