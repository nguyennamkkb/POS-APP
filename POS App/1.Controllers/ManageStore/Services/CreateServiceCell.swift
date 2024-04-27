//
//  CreateServiceCell.swift
//  POS App
//
//  Created by namnl on 15/06/2023.
//

import UIKit

class CreateServiceCell: UITableViewCell {

    
    @IBOutlet weak var tfDiem: UITextField!
    @IBOutlet weak var tfGiaDichVu: UITextField!
    @IBOutlet weak var tfTenDichVu: UITextField!
    
    @IBOutlet weak var vTenDichV: UIView!
    @IBOutlet weak var vGiaDichVu: UIView!
    @IBOutlet weak var vDiemDichVu: UIView!

    var services: PServices = PServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        vDiemDichVu.layer.cornerRadius = myCornerRadius.corner10
        vGiaDichVu.layer.cornerRadius = myCornerRadius.corner10
        vTenDichV.layer.cornerRadius = myCornerRadius.corner10
        
        vTenDichV.addBorder(color: myColor.SPA_FE!, width: 1)
        vGiaDichVu.addBorder(color: myColor.SPA_FE!, width: 1)
        vDiemDichVu.addBorder(color: myColor.SPA_FE!, width: 1)
    }
    
    func setupData(){
        tfTenDichVu.text = services.name ?? ""
        tfGiaDichVu.text = "\(services.price ?? 0)"
        tfDiem.text = "\(services.point ?? 0)"
        
        services.price = services.price ?? 0
        services.point = services.point ?? 0
    }
    func bindData(e:PServices){
        services = e
        setupData()
    }
    @IBAction func nhapTenDichVu(_ sender: Any) {
        services.name = tfTenDichVu.text ?? ""

        
    }
    @IBAction func nhapGiaDichVu(_ sender: Any) {
        services.price = Int(tfGiaDichVu.text ?? "0") ?? 0
        
        guard let diem = Int(tfGiaDichVu.text ?? "0") else {
            return
        }
        tfDiem.text = "\(diem / 10000)"
        services.point = diem / 10000
    }
    @IBAction func nhapDieDichVu(_ sender: Any) {
        services.point = Int(tfDiem.text ?? "0") ?? 0
    }
    
    
//    var dataCreate: ClosureCustom<PServices>?
//    @IBOutlet var btnXacNhan: UIButton!
//    @IBOutlet var nameView: UIView!
//    @IBOutlet var priceView: UIView!
//    @IBOutlet var pointView: UIView!
//    @IBOutlet var noteView: UIView!
//    
//    @IBOutlet var noteTF: UITextView!
//    
//    
//    @IBOutlet var nameTF: UITextField!
//    @IBOutlet var priceTF: UITextField!
//    @IBOutlet var pointTF: UITextField!
//    
//    var services = PServices()
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupUI()
//    }
//
//    func bindDataUpdate(item: PServices){
//        services =  item
//        setupData()
//    }
//    func setupData(){
//        nameTF.text = services.name ?? ""
//        priceTF.text = "\(services.price ?? 0)"
//        pointTF.text = "\(services.point ?? 0)"
//        noteTF.text = services.note ?? ""
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    func setupUI(){
//        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
//        nameView.layer.cornerRadius = myCornerRadius.corner5
//        priceView.layer.cornerRadius = myCornerRadius.corner5
//        pointView.layer.cornerRadius = myCornerRadius.corner5
//        noteTF.layer.cornerRadius = myCornerRadius.corner5
//    }
//    
//    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
//        guard let name = nameTF.text else {return}
//        guard let price = priceTF.text else {return}
//        guard let point = pointTF.text else {return}
//        let note = noteTF.text ?? ""
//        services.store_id = Common.userMaster.id
//        services.name = name
//        services.price = Int(price)
//        services.point = Int(point)
//        services.note = note
//        dataCreate?(services)
//    }
}
