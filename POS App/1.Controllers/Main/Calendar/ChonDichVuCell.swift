//
//  ChonDichVuCell.swift
//  POS App
//
//  Created by namnl on 06/06/2023.
//

import UIKit

class ChonDichVuCell: UITableViewCell {
    
    @IBOutlet weak var vItem: UIView!
    @IBOutlet var priceLbl: UILabel!
    var Checked: ((_ item: Int,_ item: Int ) -> Void)?
    var daChon: ClosureCustom<PServices>?
    var boChon: ClosureCustom<PServices>?
    @IBOutlet var checkImage: UIImageView! //circle.dotted dot.circle.fill
    @IBOutlet var dichVuLbl: UILabel!
    var index: Int = 0
    var select: Bool = false
    var item = PServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vItem.layer.cornerRadius = myCornerRadius.corner10
        vItem.addBorder(color: myColor.SPA_FE!, width: 0.5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func bindData(item: PServices, index: Int){
        let price: String = String(item.price ?? 0)
        dichVuLbl.text = item.name ?? ""
        self.index = index
        self.item = item
        priceLbl.text = "\(price.currencyFormatting())"
        setChecked(status: (item.status == 2))
    }
    @IBAction func SelectPressed(_ sender: UIButton) {
        
        select = !(item.status == 2)
//        print("chon \(select)")
        if select {
//            Checked?(2,index)
            daChon?(item)
        }
        else  {
//            Checked?(1,index)
            boChon?(item)
        }
        setChecked(status: select)
    }
    func setChecked (status: Bool) {
//        print(status)
        if status  {
//            checkImage.tintColor =  UIColor.green
            checkImage.image = UIImage(named: "ic_thanhcong")
        }
        else  {
            checkImage.tintColor =  myColor.SPA_AE
            checkImage.image = UIImage(systemName: "circle")
        }
    }
    
}
