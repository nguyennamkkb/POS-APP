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
    
    let dropDown = DropDown()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func selectGenderPressed(_ sender: UIButton) {
        dropDown.dataSource = ["Nam", "Nũ"]//4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
//            sender.setTitle(item, for: .normal) //9
            self?.genderLb.text = item
        }
    }
    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        guard let fullName = fullNameTF.text else {return}
        guard let phone = phoneTF.text else {return}
        guard let address = addressTF.text else {return}
        guard let gender = genderLb.text else {return}
        let employee = PEmployee(store_id: Common.userMaster.id ?? -1, fullName: fullName, phone: phone, address: address, birthday: String(birthdayTime.date.millisecondsSince1970), gender: gender == "nam" ? 1 : 0)
        returnEmployee?(employee)

    }
}
