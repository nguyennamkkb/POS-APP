//
//  BookHeaderCell.swift
//  POS App
//
//  Created by namnl on 16/06/2023.
//

import UIKit

class BookHeaderCell: UITableViewCell {

    
    
    @IBOutlet var NhanVien: UILabel!
    @IBOutlet var khachHang: UILabel!
    @IBOutlet var ngayThucHien: UILabel!
    @IBOutlet var idDatCho: UILabel!
    @IBOutlet var shopPhone: UILabel!
    @IBOutlet var shopAddress: UILabel!
    @IBOutlet var shopname: UILabel!
    var book = PBookCalender()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(item: PBookCalender){
        book = item
        NhanVien.text = "Nhân viên: \(book.employee?.fullName ?? "")"
        khachHang.text = "Khách hàng: \(book.customer?.fullName ?? "")"
        ngayThucHien.text = "Ngày: \(Common.convertTimestampToDate(timestampString: book.updateAt ?? "", dateFormat: "dd/MM/yyyy"))"
        idDatCho.text = "Số HĐ: #\(book.id ?? 0)"
        shopAddress.text = Common.userMaster.address
        shopPhone.text = Common.userMaster.phone
        shopname.text = Common.userMaster.storeName
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
