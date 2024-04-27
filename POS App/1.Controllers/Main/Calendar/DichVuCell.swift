//
//  DichVuCell.swift
//  POS App
//
//  Created by namnl on 09/06/2023.
//

import UIKit

class DichVuCell: UITableViewCell {

    @IBOutlet weak var vItem: UIView!
    @IBOutlet var amountLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vItem.layer.cornerRadius = myCornerRadius.corner10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func bindData(item: PServices){
        self.nameLbl.text = item.name ?? ""
        self.amountLbl.text = "\(item.price?.formatNumberInt(maxFraction: 0) ?? "0")đ"
    }
}
