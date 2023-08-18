//
//  EditStoreCell.swift
//  LN POS
//
//  Created by namnl on 07/08/2023.
//

import UIKit

class EditStoreCell: UITableViewCell {
    
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var storeNameTF: UITextField!
    @IBOutlet var storeAddressTF: UITextField!
    @IBOutlet var storeEmailTF: UITextField!
    @IBOutlet var storePassworkTF: UITextField!
    var store = PStore()
    var localUser = Common.userMaster
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupData()
        setupUI()
//        print(localUser.toJSON())
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupData(){
        storeNameTF.text =  localUser.storeName
        storeAddressTF.text = localUser.address
        storeEmailTF.text = localUser.email
        storePassworkTF.text = localUser.password
        storePassworkTF.isSecureTextEntry = true
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
    }
    
}
