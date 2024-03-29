//
//  ServiceItemCell.swift
//  POS App
//
//  Created by namnl on 14/06/2023.
//

import UIKit

class ServiceItemCell: UITableViewCell {

    var actionViewInfo: ClosureAction?
    
    
    @IBOutlet var itemView: UIView!
    @IBOutlet var amountLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    var services = PServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func setupUI() {
        itemView.layer.cornerRadius = myCornerRadius.corner5
        itemView.layer.borderWidth = 0.05
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func bindData(item: PServices){
        services = item
        amountLbl.text = "\(services.price ?? 0)".currencyFormatting()
        nameLbl.text = services.name ?? ""
    }
    
    @IBAction func btnViewInfo(_ sender: UIButton) {
        actionViewInfo?()
    }
    
}
