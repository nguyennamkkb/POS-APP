//
//  MainCell.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit

class MainCell: UITableViewCell {
    
    var actionDelete: ClosureCustom<PBookCalender>?
    var actionEdit: ClosureCustom<PBookCalender>?
    var actionSuccess: ClosureCustom<PBookCalender>?
    var actionPay: ClosureAction?
    var actionRun: ClosureCustom<PBookCalender>?
    
    
    @IBOutlet var btnRun: UIButton!
    @IBOutlet var stackActions: UIStackView!
    @IBOutlet var itemView: UIView!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var payBtn: UIButton!
    @IBOutlet var timeLb: UILabel!
    @IBOutlet var trangThaiLb: UILabel!
    @IBOutlet var khachHangLb: UILabel!
    @IBOutlet var nhanVienLb: UILabel!
    var dateFormatter = DateFormatter()
    var book = PBookCalender()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        deleteBtn.layer.cornerRadius = myCornerRadius.corner5
        editBtn.layer.cornerRadius = myCornerRadius.corner5
        okBtn.layer.cornerRadius = myCornerRadius.corner5
        payBtn.layer.cornerRadius = myCornerRadius.corner5
        btnRun.layer.cornerRadius = myCornerRadius.corner5
        itemView.layer.cornerRadius = myCornerRadius.corner5
        
        
        deleteBtn.isHidden = true
        editBtn.isHidden = true
        okBtn.isHidden = true
        payBtn.isHidden = true
        btnRun.isHidden = true
    }
    
    func bindData(item: PBookCalender){
        book = item
        trangThaiLb.text = "\(Common.getStringStatus(status: item.status ??  0))"
        trangThaiLb.textColor = getColorByStatus(status: item.status ?? 0)
        khachHangLb.text = "\(item.customer?.fullName ?? "")"
        nhanVienLb.text = "\(item.employee?.fullName ?? "")"
        timeLb.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "")
        setupButton()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?(book)
    }
    @IBAction func editPressed(_ sender: Any) {
        actionEdit?(book)
    }
    
    @IBAction func successPressed(_ sender: Any) {
        actionSuccess?(book)
    }
    
    @IBAction func payPressed(_ sender: Any) {
        actionPay?()
    }
    @IBAction func btnRunPressed(_ sender: UIButton) {
        actionRun?(book)
    }
    
    
    func getColorByStatus(status: Int) -> UIColor {
        switch status {
        case 0:
            return UIColor.orange
        case 1:
            return UIColor.green
        case 2:
            return UIColor.red
        case 3:
            return UIColor.blue
            
        default:
            return UIColor.black
        }
    }
    func setupButton(){
        
        switch book.status {
        case 0:
            deleteBtn.isHidden = false
            editBtn.isHidden = false
            btnRun.isHidden = false
            
        case 1:
            deleteBtn.isHidden = false
            
        case 2:
            deleteBtn.isHidden = false
            editBtn.isHidden = false
            payBtn.isHidden = false
        case 3:
            deleteBtn.isHidden = false
            okBtn.isHidden = false
            
        default:
            return
        }
    }
    //    0: Chưa thực hiện //xoa, sua, run
    //    1: hoàn thành // xoa
    //    2: Chờ thanh toán // xoa, pay, edit
    //    3: Đang thực hiện // xoa, tich
}
