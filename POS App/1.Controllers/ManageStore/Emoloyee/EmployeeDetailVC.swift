//
//  EmployeeDetailVC.swift
//  POS App
//
//  Created by namnl on 10/06/2023.
//

import UIKit
import ObjectMapper

class EmployeeDetailVC: BaseVC {

    var itemData: PEmployee = PEmployee()
    var tableData: [PBookCalender] =  [PBookCalender]()
    var actXoa: ClosureAction?
    
    @IBOutlet weak var lbDiaChi: UILabel!
    @IBOutlet weak var lbSinhNhat: UILabel!
    @IBOutlet weak var lbHoTen: UILabel!
    @IBOutlet weak var lbDienThoai: UILabel!
    
    
    @IBOutlet weak var lbDoanhThu: UILabel!
    @IBOutlet weak var lbLuotKhach: UILabel!
    @IBOutlet weak var btnSua: UIButton!
    @IBOutlet weak var btnXoa: UIButton!
    @IBOutlet weak var imgGioiTinh: UIImageView!
    @IBOutlet weak var vSinhNhat: UIView!
    @IBOutlet weak var vDienThoai: UIView!
    @IBOutlet weak var vDiemSo: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "EmployeeServicesCell")
        setupUI()
        setupData()
        getBookNhanVien()
        laytongDoanhThu()

    }
    
    func setupUI(){
        vDiemSo.layer.cornerRadius = myCornerRadius.corner10
        vSinhNhat.layer.cornerRadius = myCornerRadius.corner10
        vDienThoai.layer.cornerRadius = myCornerRadius.corner10
        btnSua.layer.cornerRadius = myCornerRadius.corner10
        btnXoa.layer.cornerRadius = myCornerRadius.corner10
        
        vDiemSo.addNDropShadow()
        vSinhNhat.addNDropShadow()
        vDienThoai.addNDropShadow()
        vDienThoai.addBorder(color: myColor.SPA_FE!, width: 0.2)
        vSinhNhat.addBorder(color: myColor.SPA_FE!, width: 0.2)
        vDiemSo.addBorder(color: myColor.SPA_FE!, width: 0.2)
        
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindData(e: PEmployee){
        itemData = e
    }
    func setupData(){
        if itemData.gender == 0 {
            imgGioiTinh.image = UIImage(named: "ic_nu")
          
        }else {
            imgGioiTinh.image = UIImage(named: "ic_nam")
        }
        
        lbHoTen.text = "\(itemData.fullName ?? "")"
        lbDienThoai.text = "\(itemData.phone ?? "")"
        lbDiaChi.text = "\(itemData.address ?? "")"
        lbLuotKhach.text = "\(itemData.luotKhach ?? 0)"
//        print(itemData.birthday ?? "0")
        lbSinhNhat.text = "\(Common.layNgayTheoMilisecond(time: itemData.birthday ?? "0"))"
        
    }
    @IBAction func btnXoaPressed(_ sender: Any) {
        let act = XacNhanVC()
        act.bindData(s: "Đồng ý xoá khách hàng \(itemData.fullName ?? "")")
        act.modalPresentationStyle = .overCurrentContext
        act.modalTransitionStyle = .crossDissolve
        act.actDongY = {
            [weak self] in
            guard let self = self else {return}
            self.XoaNhanVien()
        }
        present(act, animated: false, completion: nil)
    }
    @IBAction func btnSuaPressed(_ sender: Any) {
        let vc = CreateEmployeeVC()
        vc.bindDataSua(e: itemData)
        vc.actionCapNhatOK = {
            [weak self] item in
            guard let self = self else {return}
       
            itemData = item
            self.setupData()
 
        }
        self.pushVC(controller: vc)
    
    }

    //laytongDoanhThu
    
    func laytongDoanhThu(){
        let param = PBookCalender()
        param.status = 1
        param.idEmployee = itemData.id
        param.store_id = itemData.store_id
        param.sign()
        ServiceManager.common.layDoanhThuNhanVien(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if let res = response, response?.statusCode == 200 {
                if let doanhthu = res.data {
         
                    self.lbDoanhThu.text = (doanhthu as? String)?.currencyFormatting()
                }

            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
    }
    //lay danh sach dich vu voi id nhan vien
    func getBookNhanVien(){
        let param = PBookCalender()
        param.status = 1
        param.idEmployee = itemData.id
        param.store_id = itemData.store_id
        param.sign()
        ServiceManager.common.getAllBookTheoNvHoacKH(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<PBookCalender>().mapArray(JSONObject: response!.data ) ?? [PBookCalender]()

                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showMessagError()
            }
        }
    }
    func XoaNhanVien(){
        itemData.status = 0
        itemData.sign()
        ServiceManager.common.updateEmployee(param: itemData){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {

                self.onBackNav()
                self.actXoa?()
            } else if response?.statusCode == 0 {
                self.hienThiThongBao(trangThai: 0, loiNhan: "Không thể xoá")
            }
        }
    }
}

extension EmployeeDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeServicesCell", for: indexPath) as? EmployeeServicesCell else {return UITableViewCell()}
        
        let item = tableData.itemAtIndex(index: indexPath.row) ?? PBookCalender()
        cell.bindData(e: item)
        cell.actChon = {
            [weak self] in
            guard let self = self else {return}
            let vc = DetailCalenderVC()
            vc.bindData(item: item)
            self.pushVC(controller: vc)
        }
        return cell
    }
    
    
}
