//
//  ItemServicesCell.swift
//  POS App
//
//  Created by namnl on 12/07/2023.
//

import UIKit

class ItemServicesCell: UITableViewCell {

    
    
    @IBOutlet var price: UILabel!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(name: String, price: Int){
        self.name.text = name
        self.price.text = "\(String(price).currencyFormatting())"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
}
