//
//  DropdownCell.swift
//  LN POS
//
//  Created by namnl on 28/04/2024.
//

import UIKit

class DropdownCell: UITableViewCell {

    @IBOutlet weak var imgTrangThai: UIImageView!
    @IBOutlet weak var lbDienThoai: UILabel!
    @IBOutlet weak var lbTen: UILabel!

    var actChonKhachHang: ClosureCustom<PCustomer>?
    var employee: PEmployee = PEmployee()
    
    var nTrangThai: Int = 0
    var loaiDuLieu: Int = 0
    var item: AnyObject?
    
    var actChonNhanVIen: ClosureCustom<PEmployee>?
    var customer: PCustomer = PCustomer()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    func bindData (e: AnyObject, loai: Int){
        
        loaiDuLieu = loai
        if loai == 0 {
            if let object = e as? PEmployee {
                employee = object
                lbTen.text = object.fullName ?? ""
                lbDienThoai.text = object.phone ?? ""
                nTrangThai = object.status ?? 0
     
            }
        }else {
            if let object = e as? PCustomer {
                customer = object
                lbTen.text = object.fullName ?? ""
                lbDienThoai.text = object.phone ?? ""
                nTrangThai = object.status ?? 0
            }
        }
        datAnh()
    }
    func datAnh(){
        //print(nTrangThai)
        if nTrangThai == 2 {
            // print("ic_thanhcong")

            imgTrangThai.image = UIImage(named: "ic_thanhcong")
        }else {
            // print("circle")
            imgTrangThai.image = UIImage(systemName: "circle")
        }
    }
    @IBAction func btnChonPressed(_ sender: Any) {
        if loaiDuLieu == 0 {
            employee.status = 2
            nTrangThai = 2
            actChonNhanVIen?(employee)
        }else {
            customer.status = 2
            nTrangThai = 2
            actChonKhachHang?(customer)
        }
        datAnh()
    }
//    func changeStatus(loai: Int){
//        if tableData.count <= 1 {
//            return
//        }
//        for i in 0...tableData.count-1 {
//            tableData[i].status = 0
//            if listSelected.count > 0 {
//                for j in 0...listSelected.count-1 {
//                    if tableData[i].id == listSelected[j].id {
//                        tableData[i].status = 1
//                    }
//                }
//            }
//        }
//        
//        if loaiDuLieu == 0 {
//            employee.status = 2
//            actChonNhanVIen?(employee)
//        }else {
//            customer.status = 2
//            actChonKhachHang?(customer)
//        }
//
//    }
}
