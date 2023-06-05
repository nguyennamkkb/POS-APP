//
//  CreateEmployeeCell.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import DropDown



class CreateEmployeeCell: UITableViewCell {

    var returnEmployee: ClosureCustom<PEmployee>?
    @IBOutlet var fullNameTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var birthdayTime: UIDatePicker!
    
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var genderLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func birthdayPicked(_ sender: Any) {
        print(birthdayTime.date.millisecondsSince1970)
    }
    

    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        guard let fullName = fullNameTF.text else {return}
        guard let phone = phoneTF.text else {return}
        guard let address = addressTF.text else {return}
        guard let gender = genderLb.text else {return}
        let employee = PEmployee(store_id: Common.userMaster.id ?? -1, fullName: fullName, phone: phone, address: address, birthday: String(birthdayTime.date.millisecondsSince1970), gender: gender == "nam" ? 1 : 0)
//        returnEmployee?(employee)
        print(employee.toJSON())
    }
}
