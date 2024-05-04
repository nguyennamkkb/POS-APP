//
//  LichSuCell.swift
//  LN POS
//
//  Created by Mac mini on 04/05/2024.
//

import UIKit

class LichSuCell: UITableViewCell {

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
    func setupUI(){
        vItem.layer.cornerRadius = myCornerRadius.corner10
        vItem.addNDropShadow()
    }
    func bindData(e: PBookCalender){
        item = e
        lbThoiGian.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "\(Common.getMilisecondNow())")
        lbNhanVien.text = "\(item.employee?.fullName ?? "")"
        lbKhachHang.text = "\(item.customer?.fullName ?? "")"

    }

    
}
