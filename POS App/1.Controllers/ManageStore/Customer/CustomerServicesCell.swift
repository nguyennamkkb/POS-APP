//
//  CustomerServicesCell.swift
//  POS App
//
//  Created by namnl on 29/06/2023.
//

import UIKit
import ObjectMapper

class CustomerServicesCell: UITableViewCell {

    
    var actChon: ClosureAction?
    @IBOutlet weak var lbDiem: UILabel!
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var lbGio: UILabel!
    @IBOutlet weak var lbTenNhanVien: UILabel!
    @IBOutlet weak var lbHoaDon: UILabel!
    @IBOutlet weak var vItem: UIView!
    var item: PBookCalender = PBookCalender()

    override func awakeFromNib() {
        
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.corner10
        vItem.addNDropShadow()
        vItem.addBorder(color: myColor.SPA_FE!, width: 0.2)

    }
    func bindData(e: PBookCalender){
        item = e
        lbGio.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "\(Common.getMilisecondNow())")
        lbTenNhanVien.text = "\(item.employee?.fullName ?? "")"
        lbHoaDon.text =  "\(item.amount ?? 0)".currencyFormatting()
        lbId.text = "(#\(item.id ?? -1))"
        
        lbDiem.text = "\(layDienDichVu(l:item.listService ?? ""))"
        
    }
    func layDienDichVu(l: String) -> Int{
        let listItem = Mapper<PServices>().mapArray(JSONString: l ) ?? [PServices]()
        var tongDiem: Int = 0
        for e in listItem {
            tongDiem += e.point ?? 0
        }
        return tongDiem
    }
    @IBAction func btnChonPressed(_ sender: Any) {
        actChon?()
    }
}
