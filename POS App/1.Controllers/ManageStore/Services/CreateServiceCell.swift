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
    
    @IBOutlet var noteTF: UITextView!
    
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    @IBOutlet var pointTF: UITextField!
    
    var services = PServices()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupData()
    }

    func bindDataUpdate(item: PServices){
        services =  item
        print(services.toJSON())
        setupData()
    }
    func setupData(){
        nameTF.text = services.name ?? ""
        priceTF.text = "\(services.price ?? 0)"
        pointTF.text = "\(services.point ?? 0)"
        noteTF.text = services.note ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
        nameView.layer.cornerRadius = myCornerRadius.corner5
        priceView.layer.cornerRadius = myCornerRadius.corner5
        pointView.layer.cornerRadius = myCornerRadius.corner5
        noteTF.layer.cornerRadius = myCornerRadius.corner5
    }
    
    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        guard let name = nameTF.text else {return}
        guard let price = priceTF.text else {return}
        guard let point = pointTF.text else {return}
        let note = noteTF.text ?? ""
        services.name = name
        services.price = Int(price)
        services.point = Int(point)
        services.note = note
        dataCreate?(services)
    }
}
