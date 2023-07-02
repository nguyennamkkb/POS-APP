//
//  CreateEmployeeCell.swift
//  POS App
//
//  Created by namnl on 03/06/2023.
//

import UIKit
import DropDown



class CreateEmployeeCell: UITableViewCell {

    var actionOK: ClosureCustom<PEmployee>?
    var employee = PEmployee()
    @IBOutlet var fullNameTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var birthdayTime: UIDatePicker!
    
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var genderLb: UILabel!
    let dateFormater = DateFormatter()
    
    let dropDown = DropDown()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    func bindDataUpdate(item: PEmployee){
        employee =  item
        setupData()
    }
    func setupData(){
        genderLb.text = "\(employee.gender == 1 ? "Nam" : "Nữ")"
        phoneTF.text = "\(employee.phone ?? "")"
        addressTF.text = "\(employee.address ?? "")"
        fullNameTF.text = employee.fullName ?? ""
        if let date = dateFormater.date(from: employee.birthday ?? "") {
            birthdayTime.setDate(date, animated: true)
        }
        
    }
    func setupUI(){
        genderBtn.layer.cornerRadius = myCornerRadius.corner5
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
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
        let item = PEmployee(store_id: Common.userMaster.id ?? -1, fullName: fullName, phone: phone, address: address, birthday: String(birthdayTime.date.millisecondsSince1970), gender: gender == "nam" ? 1 : 0)
        item.id = employee.id
        actionOK?(item)

    }
}
 
