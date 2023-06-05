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
    func setupUI(){
        gender.layer.cornerRadius  = myCornerRadius.corner5
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
        gender.layer.cornerRadius = myCornerRadius.corner5
        
    }
    
    
    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        print("btnXacNhanPressed")
//        getDataForm()
    }
    func showAvatar(base64: String){
        print(base64)
        //        print(Common.anhChupAvatar)
        //       avatarCustomer = UIImageView(image: Utility().imageFromBase64String(base64String: imageBase64 ?? ""))
        
    }
    func getDataForm(){
        guard let name = nameTF.text else {return}
        guard let phone = phoneTF.text else {return}
        guard let address = addressFT.text else {return}
        guard let gender = gender.titleLabel?.text else {return}
        
        let customer = PCustomer(store_id: Common.userMaster.id ?? -1, fullName: name, phone: phone, address: address, birthday: String(timeSelect.date.timeIntervalSince1970), gender: gender == "Nam" ? 1: 0)
        actionOK?(customer)
    }
    
    
    @IBAction func selectGenderPressed(_ sender: UIButton) {
        dropDown.dataSource = ["Nam", "Nũ"]//4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal) //9
            self?.genderLb.text = item
        }
    }
    
}

