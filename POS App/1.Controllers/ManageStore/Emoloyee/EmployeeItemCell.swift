//
//  EmployeeItemCell.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit

class EmployeeItemCell: UITableViewCell {

    @IBOutlet weak var lbTongLuotKhach: UILabel!
    @IBOutlet weak var lbDienThoai: UILabel!
    @IBOutlet weak var lbTenNhanVien: UILabel!
    var itemData: PEmployee = PEmployee()
    @IBOutlet var itemView: UIView!
    var actChonNhanVien: ClosureAction?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemView.layer.cornerRadius = myCornerRadius.corner10
        
//        itemView.layer.shadowColor = UIColor(hex: "#00000020")?.cgColor
//        itemView.layer.shadowOpacity = 0.2
//        itemView.layer.shadowOffset = .zero
////        itemView.layer.shadowOffset = CGSize(width: 10, height: 1)
//        itemView.layer.shadowRadius = 20
//        itemView.layer.shadowPath = UIBezierPath(rect: itemView.bounds).cgPath
        itemView.addNDropShadow()



    }
    @IBAction func btnChonPressed(_ sender: Any) {
        actChonNhanVien?()
    }
    func bindData(e:PEmployee){
        itemData = e
        setupData()
    }
    func setupData(){
        lbTongLuotKhach.text = "\(itemData.luotKhach ?? 0)"
        lbDienThoai.text = "\(itemData.phone ?? "")"
        lbTenNhanVien.text = "\(itemData.fullName ?? "")"
    }



}
