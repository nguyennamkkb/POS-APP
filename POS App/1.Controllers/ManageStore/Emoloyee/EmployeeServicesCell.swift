//
//  EmployeeServicesCell.swift
//  LN POS
//
//  Created by Mac mini on 24/04/2024.
//

import UIKit

class EmployeeServicesCell: UITableViewCell {

    @IBOutlet weak var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = myCornerRadius.corner10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
