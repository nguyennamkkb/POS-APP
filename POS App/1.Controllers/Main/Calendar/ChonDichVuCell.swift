//
//  ChonDichVuCell.swift
//  POS App
//
//  Created by namnl on 06/06/2023.
//

import UIKit

class ChonDichVuCell: UITableViewCell {
    
    @IBOutlet var priceLbl: UILabel!
    var Checked: ((_ item: Int,_ item: Int ) -> Void)?
    @IBOutlet var checkImage: UIImageView! //circle.dotted dot.circle.fill
    @IBOutlet var dichVuLbl: UILabel!
    var index: Int = 0
    var select: Bool = false
    var itemState = PServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func bindData(item: PServices, index: Int){
        let price: String = String(item.price ?? 0)
        dichVuLbl.text = item.name ?? ""
        self.index = index
        self.itemState = item
        priceLbl.text = "Giá: \(price.currencyFormatting())"
        setChecked(status: (item.status == 1))
    }
    @IBAction func SelectPressed(_ sender: UIButton) {
        select = !(itemState.status == 1)
        if select {
            Checked?(1,index)
        }
        else  {
            Checked?(0,index)
        }
//        setChecked(status: select)
    }
    func setChecked (status: Bool) {
        if status {
            checkImage.image = UIImage(systemName: "dot.circle.fill")
        }
        else  {
            checkImage.image = UIImage(systemName: "circle.dotted")
        }
    }
    
}
