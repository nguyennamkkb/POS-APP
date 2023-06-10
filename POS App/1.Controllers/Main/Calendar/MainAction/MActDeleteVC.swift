//
//  MActDeleteVC.swift
//  POS App
//
//  Created by namnl on 09/06/2023.
//

import UIKit

class MActDeleteVC: BaseVC {
    
    
    var actionOK: ClosureAction?
    
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var amountLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    
    @IBOutlet var customerLbl: UILabel!
    
    @IBOutlet var sdsdd: UILabel!
    
    var book =  PBookCalender()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amountLbl.text = "Tổng tiền: \(String(describing: book.amount ?? 0))"
        self.timeLbl.text = "Thời gian: \(Common.getDateFormatFromMiliseonds(time: book.start ?? ""))"
        self.customerLbl.text = "Khách hàng: \(book.customer?.fullName ?? "")"
        setupUI()
    }
    
    func setupUI(){
        btnDelete.layer.cornerRadius = myCornerRadius.corner5
        btnCancel.layer.cornerRadius = myCornerRadius.corner5
    }
    func bindData(item: PBookCalender){
        book = item
    }
    
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        self.onBackNav()
    }
    
    @IBAction func btnDeletePressed(_ sender: UIButton) {
        guard let id = book.id else {return}
        deleteBook(id: id)
    }
    func deleteBook(id: Int){
        ServiceManager.common.deleteBook(param: id){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOK?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }
}
