//
//  LichSuCell.swift
//  LN POS
//
//  Created by Mac mini on 04/05/2024.
//

import UIKit

class LichSuCell: UITableViewCell {
    var actXem: ClosureAction?
    
    @IBOutlet weak var vItem: UIView!
    @IBOutlet weak var lbKhachHang: UILabel!
    @IBOutlet weak var lbNhanVien: UILabel!
    @IBOutlet weak var lbTien: UILabel!
    @IBOutlet weak var lbThoiGian: UILabel!
    
    var item = PBookCalender()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    @IBAction func btnXemChiTietPressed(_ sender: Any) {
        actXem?()
    }
    func setupUI(){
        vItem.layer.cornerRadius = myCornerRadius.corner10
        vItem.addNDropShadow()
        vItem.addBorder(color: myColor.SPA_FE!, width: 1)
    }
    func bindData(e: PBookCalender){
        print("lichh su")
        item = e
        lbThoiGian.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "\(Common.getMilisecondNow())")
        lbNhanVien.text = "\(item.employee?.fullName ?? "")"
        lbKhachHang.text = "\(item.customer?.fullName ?? "")"
        lbTien.text =  "\(item.amount ?? 0)".currencyFormatting()

    }

    
}
