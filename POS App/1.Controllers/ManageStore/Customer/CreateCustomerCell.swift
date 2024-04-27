//
//  CreateCustomerCell.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit
import ObjectMapper
import DropDown
import AVFoundation
import MobileCoreServices
class CreateCustomerCell: UITableViewCell {
    
    var actionOK: ClosureCustom<PEmployee>?
    var customer: PCustomer = PCustomer()
    
    
    
    
    @IBOutlet weak var tfHoTen: UITextField!
    @IBOutlet weak var tfDiaChi: UITextField!
    @IBOutlet weak var tfDienThoai: UITextField!
    
    
    @IBOutlet weak var dpSinhNhat: UIDatePicker!

    @IBOutlet weak var vGio: UIView!
    @IBOutlet weak var vGTNam: UIView!
    @IBOutlet weak var vGTNu: UIView!
    @IBOutlet weak var vDiaChi: UIView!
    @IBOutlet weak var vDienThoai: UIView!
    @IBOutlet weak var vHoTen: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        resetGioiTinh()
    }
    func bindData(item: PCustomer){
        print(item.toJSON())
        customer = item
        customer.birthday = String(Common.getMilisecondNow())
        
        setupData()
    }
    func setupUI(){
        vGio.layer.cornerRadius = myCornerRadius.corner10
        vGTNam.layer.cornerRadius = myCornerRadius.corner10
        vGTNu.layer.cornerRadius = myCornerRadius.corner10
        vDiaChi.layer.cornerRadius = myCornerRadius.corner10
        vDienThoai.layer.cornerRadius = myCornerRadius.corner10
        vHoTen.layer.cornerRadius = myCornerRadius.corner10
        
        
        vGio.addBorder(color: myColor.SPA_FE!, width: 1)
        vDiaChi.addBorder(color: myColor.SPA_FE!, width: 1)
        vDienThoai.addBorder(color: myColor.SPA_FE!, width: 1)
        vHoTen.addBorder(color: myColor.SPA_FE!, width: 1)
    }
    
    func setupData(){
        tfHoTen.text = customer.fullName ?? ""
        tfDienThoai.text = customer.phone ?? ""
        tfDiaChi.text = customer.address ?? ""
        customer.gender = customer.gender ?? 0
        resetGioiTinh(customer.gender ?? 0)
        let timeDouble: Double =  Double(Common.getMilisecondNow())
        dpSinhNhat.date = Common.dateFromUnixTimestamp(milliseconds: Double(customer.birthday ?? String(timeDouble)) ?? timeDouble )
    }
    @IBAction func btnGtNuPressed(_ sender: Any) {
        customer.gender = 0
        resetGioiTinh(0)
    }
    @IBAction func btnGTNamPressed(_ sender: Any) {
        customer.gender = 1
        resetGioiTinh(1)
    }
    
    @IBAction func nhapDiaChi(_ sender: Any) {
        customer.address = tfDiaChi.text
    }
    
    @IBAction func nhapDienThoai(_ sender: Any) {
        customer.phone = tfDienThoai.text
    }
    @IBAction func nhapHoTen(_ sender: Any) {
        customer.fullName = tfHoTen.text
    }
    
    func resetGioiTinh(_ gioiTinhHienTai: Int = 0){
        switch gioiTinhHienTai {
        case 0:
            vGTNu.alpha = 1
            vGTNu.addBorder(color: myColor.SPA_FE!, width: 1)
            vGTNu.backgroundColor = myColor.SPA_FF
            
            vGTNam.addBorder(color: myColor.SPA_FE!, width: 0)
            vGTNam.backgroundColor = myColor.SPA_FF
            vGTNam.alpha = 0.5
            
            break
        case 1:
            vGTNam.alpha = 1
            vGTNam.addBorder(color: myColor.SPA_FE!, width: 1)
            vGTNam.backgroundColor = myColor.SPA_FF
            
            vGTNu.addBorder(color: myColor.SPA_FE!, width: 0)
            vGTNu.backgroundColor = myColor.SPA_FF
            vGTNu.alpha = 0.5
            break
            
            
        default:
            vGTNu.alpha = 1
            vGTNu.addBorder(color: myColor.SPA_FE!, width: 1)
            vGTNu.backgroundColor = myColor.SPA_FF
            
            vGTNam.addBorder(color: myColor.SPA_FE!, width: 0)
            vGTNam.backgroundColor = myColor.SPA_FF
            vGTNam.alpha = 0.5
        }
        
    }
    @IBAction func chonSinhNhat(_ sender: Any) {
        customer.birthday = String(dpSinhNhat.date.millisecondsSince1970)
    }
    //    @IBAction func chonSinhNhat(_ sender: Any) {
//
//    }
    
//    @IBOutlet var btnXacNhan: UIButton!
//    var actionChupAnh: ClosureAction?
//    var actionOK: ClosureCustom<PCustomer>?
//    let dropDown = DropDown()
//    var customer = PCustomer()
//    let dateFormater = DateFormatter()
//    @IBOutlet var gender: UIButton!
//    @IBOutlet var timeSelect: UIDatePicker!
//    @IBOutlet var addressFT: UITextField!
//    @IBOutlet var phoneTF: UITextField!
//    @IBOutlet var nameTF: UITextField!
//    @IBOutlet var genderLb: UILabel!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        setupUI()
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
//    func bindDataUpdate(item: PCustomer){
//        customer =  item
//        setupData()
//    }
//    func setupData(){
//        genderLb.text = "\(customer.gender == 1 ? "Nam" : "Nữ")"
//        phoneTF.text = "\(customer.phone ?? "")"
//        addressFT.text = "\(customer.address ?? "")"
//        nameTF.text = customer.fullName ?? ""
//        if let date = dateFormater.date(from: customer.birthday ?? "") {
//            timeSelect.setDate(date, animated: true)
//        }
//        
//    }
//    func setupUI(){
//        gender.layer.cornerRadius  = myCornerRadius.corner5
//        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
//        gender.layer.cornerRadius = myCornerRadius.corner5
//        genderLb.text = "Nữ"
//    }
//    
//    
//    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
//        getDataForm()
//    }
//    func getDataForm(){
//        guard let name = nameTF.text, name != "" else {return}
//        guard let phone = phoneTF.text, phone != "" else {return}
//        guard let address = addressFT.text, address != "" else {return}
//        guard let gender = genderLb.text, gender != "" else {return}
//        
//        let item = PCustomer(store_id: Common.userMaster.id ?? -1, fullName: name, phone: phone, address: address, birthday: String(timeSelect.date.millisecondsSince1970), gender: gender == "Nam" ? 1: 0)
//        item.id = customer.id ?? 0
//        actionOK?(item)
////        print("getDataForm ok")
//    }
//    
//    
//    @IBAction func selectGenderPressed(_ sender: UIButton) {
//        dropDown.dataSource = ["Nam", "Nữ"]//4
//        dropDown.anchorView = sender //5
//        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
//        dropDown.show() //7
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
//            guard let _ = self else { return }
////            sender.setTitle(item, for: .normal) //9
//            self?.genderLb.text = item
//        }
//    }
//    
}

