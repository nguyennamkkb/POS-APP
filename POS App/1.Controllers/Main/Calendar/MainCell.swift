//
//  MainCell.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit

class MainCell: UITableViewCell {
    
    var actionDelete: ClosureAction?
    var actionEdit: ClosureAction?
    var actionSuccess: ClosureAction?
    var actionPay: ClosureAction?
    
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        deleteBtn.layer.cornerRadius = myCornerRadius.corner5
        editBtn.layer.cornerRadius = myCornerRadius.corner5
        okBtn.layer.cornerRadius = myCornerRadius.corner5
        payBtn.layer.cornerRadius = myCornerRadius.corner5
        itemView.layer.cornerRadius = myCornerRadius.corner5
    }
    
    func bindData(item: PBookCalender){
        trangThaiLb.text = "\((item.status == 0 ) ? "Đang thực hiện" : "Hoàn thành")"
        khachHangLb.text = "\(item.customer?.fullName ?? "")"
        nhanVienLb.text = "\(item.employee?.fullName ?? "")"
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(Int(item.start ?? "") ?? 1000)/1000)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        timeLb.text = dateFormatter.string(from: dateVar)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?()
    }
    @IBAction func editPressed(_ sender: Any) {
        actionEdit?()
    }
    
    @IBAction func successPressed(_ sender: Any) {
        actionSuccess?()
    }
    
    @IBAction func payPressed(_ sender: Any) {
        actionPay?()
    }
}
