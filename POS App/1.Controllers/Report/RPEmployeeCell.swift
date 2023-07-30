//
//  RPEmployeeCell.swift
//  POS App
//
//  Created by namnl on 27/07/2023.
//

import UIKit

class RPEmployeeCell: UITableViewCell {

    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var employeeLbl: UILabel!
    var data = ListEmplEach()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(item: ListEmplEach){
        data = item
        employeeLbl.text = data.name ?? ""
        moneyLbl.text = "Doanh thu: \(String(data.totalMoney ?? 0).currencyFormatting()) đ - Lượt khách: \(data.tolalBook ?? 0)"
    }
    
}