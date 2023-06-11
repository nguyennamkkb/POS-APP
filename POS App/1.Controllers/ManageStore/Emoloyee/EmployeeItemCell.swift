//
//  EmployeeItemCell.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit

class EmployeeItemCell: UITableViewCell {

    var actionViewInfo: ClosureAction?
    @IBOutlet var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
