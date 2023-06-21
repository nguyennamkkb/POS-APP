//
//  StoreInfoCell.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit
import DropDown

class StoreInfoCell: UITableViewCell {
    
    var storeData = PStore()
    var actionSuccess: ClosureCustom<PStore>?
    let dropDown = DropDown()
    @IBOutlet var xacNhanBtn: UIButton!
    @IBOutlet var emailTF: UITextField!
//    @IBOutlet var accoutNumberTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var storeNameTF: UITextField!
//    @IBOutlet var bankCodeDRop: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI(){
        xacNhanBtn.layer.cornerRadius = myCornerRadius.corner10
//        bankCodeDRop.contentEdgeInsets = UIEdgeInsets(top:0,left:0,bottom:0,right:5)
        
        //setup dropdown
       
        
    }
    @IBAction func selectBankPressed(_ sender: UIButton) {
        dropDown.dataSource = ["ACB", "VCB", "AGR"]//4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal) //9
        }
    }
    func bindData(item: PStore){
        storeData = item
    }

    @IBAction func XacNhanAction(_ sender: UIButton) {
        guard let name = storeNameTF.text else {return}
        guard let address = addressTF.text else {return}
        guard let phone = storeData.phone else {return}
        guard let password = storeData.password else {return}
    
//        guard let bankCode = bankCodeDRop.titleLabel?.text else {return}
//        guard let accoutNumber = accoutNumberTF.text else {return}
        let store = PStore(storeName: name, phone: phone, address: address, email: emailTF.text ?? "", password: password)
        actionSuccess?(store)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
