//
//  DropdownVC.swift
//  LN POS
//
//  Created by namnl on 28/04/2024.
//

import UIKit

class DropdownVC: BaseVC {
    
    @IBOutlet weak var lbTieuDe: UILabel!
    @IBOutlet weak var vTimKiem: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnXacNhan: UIButton!
    @IBOutlet weak var vDropdown: UIView!
    
    var dsNhanVien: [PEmployee] = [PEmployee]()
    var dsKhachHang: [PCustomer] = [PCustomer]()
    var khachHang: PCustomer = PCustomer()
    var nhanVien: PEmployee = PEmployee()

    var loaiDuLieu: Int = 0 //0: nhanvien, 1: khach hang
    var daChon: ClosureCustom<AnyObject>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.showLoading()
    }
    func setupUI(){
        DispatchQueue.main.async { [self] in
        vDropdown.layer.cornerRadius = myCornerRadius.corner10
        vTimKiem.layer.cornerRadius = myCornerRadius.corner10
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
        vTimKiem.addBorder(color: myColor.SPA_FE!, width: 1)
        btnXacNhan.addBorder(color: myColor.SPA_FE!, width: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "DropdownCell")
        
        if loaiDuLieu == 0 {
            lbTieuDe.text = "Chọn nhân viên"
        }else {
            lbTieuDe.text = "Chọn Khách hàng"

        }
        
        
            self.tableView.reloadData()
        }
        self.hideLoading()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
    }
    func bindDataNhanVien(e: [PEmployee]){
        dsNhanVien = e
        loaiDuLieu = 0
        setupUI()
    }
    func bindDataKhachHang(e: [PCustomer]){
        dsKhachHang = e
        loaiDuLieu = 1
        setupUI()
    }
    @IBAction func btnThoatPressed(_ sender: Any) {
        
        dismiss(animated: true)
    }
    func changeStatus(loai: Int){
        

        if loaiDuLieu == 0 {
            if dsNhanVien.count <= 1 {
                return
            }
            for i in 0...dsNhanVien.count-1 {
                dsNhanVien[i].status = 1
            }
        }else {
            if dsKhachHang.count <= 1 {
                return
            }
            for i in 0...dsKhachHang.count-1 {
                dsKhachHang[i].status = 1
                
            }
        }

    }
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        if loaiDuLieu == 0 {
            daChon?(nhanVien)
        
        }else {
            daChon?(khachHang)
        }
        dismiss(animated: true)
    }
}
extension DropdownVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch loaiDuLieu {
        case 0:
            return dsNhanVien.count
        case 1:
            return dsKhachHang.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath) as? DropdownCell else {return UITableViewCell()}
        
        
        if loaiDuLieu == 0 {
            let index  = indexPath.row
            let item = dsNhanVien.itemAtIndex(index: index) ?? PEmployee()
            cell.bindData(e: item,loai: 0)
            
            cell.actChonNhanVIen = {
                [weak self] e in
                guard let self = self else {return}
                self.changeStatus(loai: 0)
                self.dsNhanVien[index].status = 2
                nhanVien = e
                daChon?(nhanVien)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else {
            let index  = indexPath.row
            let item = dsKhachHang.itemAtIndex(index: index) ?? PCustomer()
            cell.bindData(e: item, loai: 1)
            cell.actChonKhachHang = {
                [weak self] e in
             
                guard let self = self else {return}
                self.changeStatus(loai: 1)
                self.dsKhachHang[index].status = 2
                khachHang = e
                daChon?(khachHang)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
        
        return cell
    }
    
    
    
}
