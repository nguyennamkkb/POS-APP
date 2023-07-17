//
//  CreateCustomerCell.swift
//  POS App
//
//  Created by namnl on 21/05/2023.
//

import UIKit
import ObjectMapper
import DropDown
import AVFoundation
import MobileCoreServices
class CreateCustomerCell: UITableViewCell {
    
    
    @IBOutlet var btnXacNhan: UIButton!
    var actionChupAnh: ClosureAction?
    var actionOK: ClosureCustom<PCustomer>?
    let dropDown = DropDown()
    var customer = PCustomer()
    let dateFormater = DateFormatter()
    @IBOutlet var gender: UIButton!
    @IBOutlet var timeSelect: UIDatePicker!
    @IBOutlet var addressFT: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var genderLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func bindDataUpdate(item: PCustomer){
        customer =  item
        setupData()
    }
    func setupData(){
        genderLb.text = "\(customer.gender == 1 ? "Nam" : "Nữ")"
        phoneTF.text = "\(customer.phone ?? "")"
        addressFT.text = "\(customer.address ?? "")"
        nameTF.text = customer.fullName ?? ""
        if let date = dateFormater.date(from: customer.birthday ?? "") {
            timeSelect.setDate(date, animated: true)
        }
        
    }
    func setupUI(){
        gender.layer.cornerRadius  = myCornerRadius.corner5
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
        gender.layer.cornerRadius = myCornerRadius.corner5
        genderLb.text = "Nữ"
    }
    
    
    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        getDataForm()
    }
    func getDataForm(){
        guard let name = nameTF.text, name != "" else {return}
        guard let phone = phoneTF.text, phone != "" else {return}
        guard let address = addressFT.text, address != "" else {return}
        guard let gender = genderLb.text, gender != "" else {return}
        
        let item = PCustomer(store_id: Common.userMaster.id ?? -1, fullName: name, phone: phone, address: address, birthday: String(timeSelect.date.millisecondsSince1970), gender: gender == "Nam" ? 1: 0)
        item.id = customer.id ?? 0
        actionOK?(item)
//        print("getDataForm ok")
    }
    
    
    @IBAction func selectGenderPressed(_ sender: UIButton) {
        dropDown.dataSource = ["Nam", "Nữ"]//4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
//            sender.setTitle(item, for: .normal) //9
            self?.genderLb.text = item
        }
    }
    
}

