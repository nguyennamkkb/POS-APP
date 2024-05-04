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
    @IBOutlet var tfDienThoai: UITextField!
    @IBOutlet var storePassworkTF: UITextField!
    var store = PStore()
    
    
    var actXacNhan: ClosureCustom<PStore>?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupData()
        setupUI()
        

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupData(){
        store = Common.userMaster
        print("storeName \(store.storeName ?? "")")
        storeNameTF.text =  store.storeName ?? ""
        storeAddressTF.text = store.address ?? ""
        tfDienThoai.text = store.phone ?? ""

    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func btnXacNhanPressed(_ sender: Any) {
        let store = PStore()
        guard let tenCuaHang = storeNameTF.text else {return}
        guard let diaChi = storeAddressTF.text else {return}
        guard let dienThoai = tfDienThoai.text else {return}
        store.storeName = tenCuaHang
        store.address = diaChi
        store.phone = dienThoai
      
        actXacNhan?(store)
    }
    
}
