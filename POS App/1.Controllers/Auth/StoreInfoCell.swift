//
//  StoreInfoCell.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit

class StoreInfoCell: UITableViewCell {

    
    var actionSuccess: ClosureAction?
    @IBOutlet var xacNhanBtn: UIButton!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var accoutNumberTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var storeNameTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI(){
        xacNhanBtn.layer.cornerRadius = myCornerRadius.corner10
    }
    @IBAction func XacNhanAction(_ sender: UIButton) {
        print("Xac nhan")
        //Lấy dữ liệu cache storeMain
        //cap nhat du lieu cua hang
        //Đẩy lên dv
        // quay ra trang Home
        actionSuccess?()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
