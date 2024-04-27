//
//  ServiceItemCell.swift
//  POS App
//
//  Created by namnl on 14/06/2023.
//

import UIKit

class ServiceItemCell: UITableViewCell {

    @IBOutlet weak var lbDiem: UILabel!
    var actChonDichVu: ClosureAction?
    @IBOutlet weak var lbGia: UILabel!
    @IBOutlet weak var lbTenDichVu: UILabel!
    @IBOutlet weak var vItem: UIView!
    
    var services: PServices = PServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI(){
        vItem.layer.cornerRadius = myCornerRadius.corner10
    }
    
    func bindData(e: PServices){
        services = e
        lbGia.text = "\(services.price ?? 0)".currencyFormatting()
        lbTenDichVu.text = services.name ?? ""
        lbDiem.text = "\(services.point ?? 0)"
    }
    @IBAction func chonDichVuPressed(_ sender: Any) {
        actChonDichVu?()
    }
   
    
}
