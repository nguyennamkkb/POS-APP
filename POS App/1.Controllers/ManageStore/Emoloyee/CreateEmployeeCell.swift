//
//  CreateEmployeeCell.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import DropDown



class CreateEmployeeCell: UITableViewCell {
    
    var actionOK: ClosureCustom<PEmployee>?
    var employee: PEmployee = PEmployee()
    @IBOutlet weak var tfHoten: UITextField!
    @IBOutlet weak var tfSoDieThoai: UITextField!
    @IBOutlet weak var tfDiaChi: UITextField!
    
    
    @IBOutlet var dpSinhNhat: UIDatePicker!
    
    @IBOutlet weak var vXoa: UIView!
    @IBOutlet weak var vGio: UIView!
    @IBOutlet weak var vGioiTinhNam: UIView!
    @IBOutlet weak var vGioiTinhNu: UIView!
    @IBOutlet weak var vDiaChi: UIView!
    @IBOutlet weak var vDienThoai: UIView!
    @IBOutlet weak var vHoten: UIView!
    
//    let dateFormater = DateFormatter()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        resetGioiTinh()
        
    }
    func setupUI(){
        vXoa.layer.cornerRadius = myCornerRadius.corner10
        vGio.layer.cornerRadius = myCornerRadius.corner10
        vGioiTinhNam.layer.cornerRadius = myCornerRadius.corner10
        vGioiTinhNu.layer.cornerRadius = myCornerRadius.corner10
        vDiaChi.layer.cornerRadius = myCornerRadius.corner10
        vDienThoai.layer.cornerRadius = myCornerRadius.corner10
        vHoten.layer.cornerRadius = myCornerRadius.corner10
        
        
        vXoa.addBorder(color: myColor.SPA_FE!, width: 1)
        vGio.addBorder(color: myColor.SPA_FE!, width: 1)
        vDiaChi.addBorder(color: myColor.SPA_FE!, width: 1)
        vXoa.addBorder(color: myColor.SPA_FE!, width: 1)
        vDienThoai.addBorder(color: myColor.SPA_FE!, width: 1)
        vHoten.addBorder(color: myColor.SPA_FE!, width: 1)
        

        vXoa.isHidden = true
    }
    
    func setupData(){
        tfHoten.text = employee.fullName ?? ""
        tfSoDieThoai.text = employee.phone ?? ""
        tfDiaChi.text = employee.address ?? ""
        employee.gender = employee.gender ?? 0
        resetGioiTinh(employee.gender ?? 0)
        let timeDouble: Double =  Double(Common.getMilisecondNow())
        dpSinhNhat.date = Common.dateFromUnixTimestamp(milliseconds: Double(employee.birthday ?? String(timeDouble)) ?? timeDouble )

    }
    func bindData(item: PEmployee){
        print(item.toJSON())
        employee = item
        employee.birthday = String(Common.getMilisecondNow())
        
        setupData()
    }
    
    @IBAction func nhapDienThoai(_ sender: Any) {
        employee.phone = tfSoDieThoai.text ?? ""
    }
    @IBAction func nhapDiaChi(_ sender: Any) {
        employee.address = tfDiaChi.text ?? ""
    }
    
    
    @IBAction func chonNgayPressed(_ sender: Any) {
        employee.birthday = String(dpSinhNhat.date.millisecondsSince1970)
    }
    @IBAction func btnGtNuPressed(_ sender: Any) {
        employee.gender = 0
        resetGioiTinh(0)
    }
    @IBAction func btnGTNamPressed(_ sender: Any) {
        employee.gender = 1
        resetGioiTinh(1)
    }
    
    @IBAction func nhapHoTen(_ sender: Any) {
        employee.fullName = tfHoten.text ?? ""
    }
    

    func resetGioiTinh(_ gioiTinhHienTai: Int = 0){
        switch gioiTinhHienTai {
        case 0:
            vGioiTinhNu.alpha = 1
            vGioiTinhNu.addBorder(color: myColor.SPA_FE!, width: 1)
            vGioiTinhNu.backgroundColor = myColor.SPA_FF
            
            vGioiTinhNam.addBorder(color: myColor.SPA_FE!, width: 0)
            vGioiTinhNam.backgroundColor = myColor.SPA_FF
            vGioiTinhNam.alpha = 0.5
            
            break
        case 1:
            vGioiTinhNam.alpha = 1
            vGioiTinhNam.addBorder(color: myColor.SPA_FE!, width: 1)
            vGioiTinhNam.backgroundColor = myColor.SPA_FF
            
            vGioiTinhNu.addBorder(color: myColor.SPA_FE!, width: 0)
            vGioiTinhNu.backgroundColor = myColor.SPA_FF
            vGioiTinhNu.alpha = 0.5
            break
            
            
        default:
            vGioiTinhNu.alpha = 1
            vGioiTinhNu.addBorder(color: myColor.SPA_FE!, width: 1)
            vGioiTinhNu.backgroundColor = myColor.SPA_FF
            
            vGioiTinhNam.addBorder(color: myColor.SPA_FE!, width: 0)
            vGioiTinhNam.backgroundColor = myColor.SPA_FF
            vGioiTinhNam.alpha = 0.5
        }
        
    }
    
}
