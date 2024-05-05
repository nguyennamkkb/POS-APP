//
//  CustomerItemCell.swift
//  POS App
//
//  Created by namnl on 04/06/2023.
//

import UIKit

class CustomerItemCell: UITableViewCell {

    @IBOutlet weak var lbDiemSo: UILabel!
    var customer: PCustomer = PCustomer()
    @IBOutlet weak var lbDienThoai: UILabel!
    @IBOutlet weak var lbHoTen: UILabel!
    @IBOutlet var itemView: UIView!
    var actChonKhachHang: ClosureAction?

    override func awakeFromNib() {
        super.awakeFromNib()

        itemView.layer.cornerRadius = myCornerRadius.corner10
        itemView.addNDropShadow()
    }
    @IBAction func btnChonPressed(_ sender: Any) {
        print("Chon khach hang")
        actChonKhachHang?()
    }
    func bindData(e: PCustomer){
        customer = e
        setupData()
    }
    func setupData(){
        lbDienThoai.text = customer.phone ?? ""
        lbHoTen.text = customer.fullName ?? ""
        lbDiemSo.text = "\(customer.loyalty ?? 0)"
    }
//    @IBOutlet var itemView: UIView!
//    var actionViewInfo: ClosureAction?
//    @IBOutlet var nameLbl: UILabel!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        itemView.layer.cornerRadius = myCornerRadius.corner5
//        itemView.layer.borderWidth = 0.05
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//    @IBAction func btnViewInfo(_ sender: UIButton) {
//        actionViewInfo?()
//    }
//    func binđata(name: String){
//        nameLbl.text = name
//    }

}
