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
    var actThemThanhCong: ClosureAction?
    var actCapNhatThanhCong: ClosureAction?
    
    var trangThaiThemMoiorCapNhat: Int = 0 //0 themmoi, 1 capnhat
    var book: PBookCalender = PBookCalender()
    var trangThaiThemMoioCapNhat: Int = 0 //0 thmmoi, 1 cap nhat
    
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
        setupData()
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
    func bindDataSua(e: PBookCalender){
        trangThaiThemMoioCapNhat = 1
        book = e
        employeeSelected = e.employee ?? PEmployee()
        customerSelected = e.customer ?? PCustomer()
        dsDichVuChon = Mapper<PServices>().mapArray(JSONString: book.listService ?? "" ) ?? [PServices]()
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

    func setupData(){
        lbChonKhachHang.text = book.customer?.fullName ?? "Chọn khách hàng"
        lbChonNhanVIen.text = book.employee?.fullName ?? "Chọn nhân viên"
//        employeeSelected = book.employee ?? PEmployee()
//        customerSelected = itemBookUpdate.customer  ?? PCustomer()
        dsDichVuChon = Mapper<PServices>().mapArray(JSONString: book.listService ?? "" ) ?? [PServices]()
//        print("timeInterval update\(itemBookUpdate.start ?? "0")")

        self.lbTongTien.text = "\(self.capNhatSoTien())".currencyFormatting()
        dpGioLam.date = Common.dateFromUnixTimestamp(milliseconds: Double( book.start ?? "\(Common.getMilisecondNow())") ?? Double(Common.getMilisecondNow())    )

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
                
                if !self.dsDichVuChon.isEmpty {
                    for (index, dichVu) in self.dsDichVu.enumerated() {
                        if self.dsDichVuChon.firstIndex(where: { $0.id == dichVu.id }) != nil {
                            self.dsDichVu[index].status = 2
                            
                        }
                    }
                }
                
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
        @IBAction func btnAcceptPresses(_ sender: UIButton) {
            
            let thoiGian: String = String(dpGioLam.date.millisecondsSince1970)
            
            if dsDichVuChon.count == 0 {
                print("dsDichVuChon.count == 0")
            }
            book.amount = capNhatSoTien()
            if book.amount == 0 || book.amount == nil {
                print("book.amount == 0")
            }
            if employeeSelected.id == nil {
                print("employeeSelected nill")
            }
            if customerSelected.id == nil {
                print("customerSelected nill")
            }
            book.listService = dsDichVuChon.toJSONString()
            book.amount = capNhatSoTien()
         
            book.idEmployee = employeeSelected.id
            book.idCustomer = customerSelected.id
            book.store_id = Common.userMaster.id
            book.start = thoiGian
            book.employee = nil
            book.customer = nil
            book.sign()
            
//            print(book.toJSON())
//            print(customerSelected.id)
            
            if trangThaiThemMoioCapNhat == 0 {
                book.status = 0
                createBook()
            }else{
                updateBook()
            }

    
        }
        func createBook(){ // dat lich
    //        print("PBookCalender \(item.toJSON())")
            book.sign()
            self.showLoading()
            ServiceManager.common.createBook(param: book){
                (response) in
                self.hideLoading()
                if response?.data != nil, response?.statusCode == 200 {
                    self.hienThiThongBao(trangThai: 1, loiNhan: "Thêm mới thành công")
       
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.actThemThanhCong?()
                        self.onBackNav()
                    }
                } else if response?.statusCode == 0 {
                    self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại thông tin nhập")
                }
            }
    
        }
        func updateBook(){
    //        print("PBookCalender \(item.toJSON())")
            book.sign()
            self.showLoading()
            ServiceManager.common.editBook(param: book){
                (response) in
                self.hideLoading()
                if response?.data != nil, response?.statusCode == 200 {
      
                    
                    self.hienThiThongBao(trangThai: 1, loiNhan: "Cập nhật thành công")
       
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.actCapNhatThanhCong?()
                        self.onBackNav()
                    }
                } else if response?.statusCode == 0 {
                    self.hienThiThongBao(trangThai: 0, loiNhan: "Kiểm tra lại thông tin nhập")
                }
            }
    
        }
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
