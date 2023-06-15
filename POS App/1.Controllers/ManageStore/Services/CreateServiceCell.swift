//
//  CreateServiceCell.swift
//  POS App
//
//  Created by namnl on 15/06/2023.
//

import UIKit

class CreateServiceCell: UITableViewCell {

    var dataCreate: ClosureCustom<PServices>?
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var nameView: UIView!
    @IBOutlet var priceView: UIView!
    @IBOutlet var pointView: UIView!
    @IBOutlet var noteView: UIView!
    
    
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    @IBOutlet var pointTF: UITextField!
    @IBOutlet var noteTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
        nameView.layer.cornerRadius = myCornerRadius.corner5
        priceView.layer.cornerRadius = myCornerRadius.corner5
        pointView.layer.cornerRadius = myCornerRadius.corner5
        noteView.layer.cornerRadius = myCornerRadius.corner5
    }
    
    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        guard let name = nameTF.text else {return}
        guard let price = priceTF.text else {return}
        guard let point = pointTF.text else {return}
        let note = noteTF.text ?? ""
        let services = PServices(name: name, price: Int(price) ?? 0, point: Int(point) ?? 0, note: note)
        dataCreate?(services)
    }
}
