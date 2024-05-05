//
//  EmployeeServicesCell.swift
//  LN POS
//
//  Created by Mac mini on 24/04/2024.
//

import UIKit

class EmployeeServicesCell: UITableViewCell {

    
    @IBOutlet weak var lbId: UILabel!
    var actChon: ClosureAction?
    @IBOutlet weak var lbThoiGian: UILabel!
    @IBOutlet weak var lbDoanhThu: UILabel!
    @IBOutlet weak var lbTenKhachHang: UILabel!
    @IBOutlet weak var vItem: UIView!
    var item: PBookCalender = PBookCalender()
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.corner10
        vItem.addBorder(color: myColor.SPA_FE!, width: 0.2)
        vItem.addNDropShadow()
    }

    func bindData(e: PBookCalender){
        item = e
        lbThoiGian.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "\(Common.getMilisecondNow())")
        lbTenKhachHang.text = "\(item.customer?.fullName ?? "")"
        lbDoanhThu.text =  "\(item.amount ?? 0)".currencyFormatting()
        lbId.text = "(#\(item.id ?? -1))"
        
    }
    @IBAction func btnChonPressed(_ sender: Any) {
        actChon?()
    }
    
}
