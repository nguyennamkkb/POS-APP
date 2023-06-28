//
//  MActSuccessVC.swift
//  POS App
//
//  Created by namnl on 10/06/2023.
//

import UIKit

class MActSuccessVC: BaseVC {

    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var btnPay: UIButton!
    
    var actionOK: ClosureAction?
    
    var book: PBookCalender?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        btnXacNhan.layer.cornerRadius = myCornerRadius.corner5
        btnPay.layer.cornerRadius = myCornerRadius.corner5
    }
    
    func bindData(item: PBookCalender){
        book = item
    }
    func editBook(){
        self.showLoading()
        guard let param = book else {return}
        param.status = 2
        param.sign()
        ServiceManager.common.editBook(param: param){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOK?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể cập nhật")
            }
        }
    }
    @IBAction func btnXacNhanPressed(_ sender: UIButton) {
        editBook()
    }
    

}
