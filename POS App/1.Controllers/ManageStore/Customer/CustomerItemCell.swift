//
//  CustomerItemCell.swift
//  POS App
//
//  Created by namnl on 04/06/2023.
//

import UIKit

class CustomerItemCell: UITableViewCell {

    
    @IBOutlet var itemView: UIView!
    var actionViewInfo: ClosureAction?
    @IBOutlet var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemView.layer.cornerRadius = myCornerRadius.corner5
        itemView.layer.borderWidth = 0.05
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnViewInfo(_ sender: UIButton) {
        actionViewInfo?()
    }
    func binđata(name: String){
        nameLbl.text = name
    }

}
