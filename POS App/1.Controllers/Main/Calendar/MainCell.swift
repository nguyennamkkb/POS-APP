//
//  MainCell.swift
//  POS App
//
//  Created by namnl on 16/05/2023.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet weak var lbTrangThai: UILabel!
    @IBOutlet weak var lbKhachHang: UILabel!
    @IBOutlet weak var lbNhanVien: UILabel!
    @IBOutlet weak var lbThoiGian: UILabel!
    @IBOutlet weak var vItem: UIView!
    @IBOutlet weak var vStatusBar: UIView!
    @IBOutlet weak var bntActionMore: UIButton!
    var item: PBookCalender = PBookCalender()
    
    var actThaoTac: ClosureAction?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        bntActionMore.layer.cornerRadius = myCornerRadius.corner10
        bntActionMore.addBorder(color: myColor.SPA_FE!, width: 0.5)
        vItem.layer.cornerRadius = myCornerRadius.corner10
        vItem.addNDropShadow()
        vStatusBar.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        vItem.addBorder(color: myColor.SPA_FE!, width: 0.5)
    }
    func bindData(e: PBookCalender){
        item = e
        lbThoiGian.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "\(Common.getMilisecondNow())")
        lbNhanVien.text = "\(item.employee?.fullName ?? "")"
        lbKhachHang.text = "\(item.customer?.fullName ?? "")"
        vStatusBar.backgroundColor = getColorByStatus(status: item.status ?? 0)
        datTrangThai(status: item.status ?? 0)
    }
    @IBAction func btnThaoTac(_ sender: Any) {
        actThaoTac?()
    }
    
//    func datMauTrangThai(){
//        switch item.status {
//        case 0:
//            vStatusBar.backgroundColor = UIColor(hex: "#FFC362")
//            break
//        case 0:
//            vStatusBar.backgroundColor = UIColor(hex: "#FFC362")
//            break
//        default:ellipsis
//            <#code#>
//        }ellipsis
    func getColorByStatus(status: Int) -> UIColor {
        switch status {
        case 0:
            return UIColor(hex: "#FFC362") ?? UIColor.orange
        case 1:
            return UIColor(hex: "#ABD99A") ?? UIColor.green
        case 2:
            return UIColor(hex: "#9C89FF") ?? UIColor.red
        case 3:
            return UIColor(hex: "#6FD1FF") ?? UIColor.blue
            
        default:
            return UIColor.orange
        }
    }
    
    func datTrangThai(status: Int) {
        switch status {
        case 0:
            lbTrangThai.text = "Đang chờ"
            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            
        case 1:

            lbTrangThai.text = "Hoàn thành"
            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            break
        case 2:
    
            lbTrangThai.text = "Tính tiền"
            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            break
        case 3:
        
            lbTrangThai.text = "Đang thực hiện"
            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
            break
            
        default:
            lbTrangThai.text = "Đang chờ"
            lbTrangThai.textColor = getColorByStatus(status: item.status ?? 0)
        }
    }
    
    
//    var actionDelete: ClosureCustom<PBookCalender>?
//    var actionEdit: ClosureCustom<PBookCalender>?
//    var actionSuccess: ClosureCustom<PBookCalender>?
//    var actionPay: ClosureCustom<PBookCalender>?
//    var actionRun: ClosureCustom<PBookCalender>?
//    var actionDetail: ClosureCustom<PBookCalender>?
//    
//    
//    @IBOutlet var btnViewDetail: UIButton!
//    @IBOutlet var btnRun: UIButton!
//    @IBOutlet var stackActions: UIStackView!
//    @IBOutlet var itemView: UIView!
//    @IBOutlet var deleteBtn: UIButton!
//    @IBOutlet var editBtn: UIButton!
//    @IBOutlet var okBtn: UIButton!
//    @IBOutlet var payBtn: UIButton!
//    @IBOutlet var timeLb: UILabel!
//    @IBOutlet var trangThaiLb: UILabel!
//    @IBOutlet var khachHangLb: UILabel!
//    @IBOutlet var nhanVienLb: UILabel!
//    
//    
//    var dateFormatter = DateFormatter()
//    var book = PBookCalender()
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupUI()
//    }
//    func setupUI(){
//        deleteBtn.layer.cornerRadius = myCornerRadius.corner5
//        editBtn.layer.cornerRadius = myCornerRadius.corner5
//        okBtn.layer.cornerRadius = myCornerRadius.corner5
//        payBtn.layer.cornerRadius = myCornerRadius.corner5
//        btnRun.layer.cornerRadius = myCornerRadius.corner5
//        itemView.layer.cornerRadius = myCornerRadius.corner5
//        
//        
//        deleteBtn.isHidden = true
//        editBtn.isHidden = true
//        okBtn.isHidden = true
//        payBtn.isHidden = true
//        btnRun.isHidden = true
//        
////        itemView.layer.shadowColor = UIColor.gray.cgColor
////        itemView.layer.shadowOffset = CGSize(width: 1, height: 1)
////        itemView.layer.shadowOpacity = 0.3
//    }
//    
//    func bindData(item: PBookCalender){
//        book = item
//        trangThaiLb.text = "\(Common.getStringStatus(status: item.status ??  0))"
//        trangThaiLb.textColor = getColorByStatus(status: item.status ?? 0)
//        khachHangLb.text = "\(item.customer?.fullName ?? "")"
//        nhanVienLb.text = "\(item.employee?.fullName ?? "")"
//        timeLb.text = Common.getDateFormatFromMiliseonds(time: item.start ?? "")
//        
//        itemView.layer.borderWidth = 1.1
//        itemView.layer.borderColor = getColorByStatus(status: item.status ?? 0).cgColor
//        setupButton()
//        
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    
//    @IBAction func deletePressed(_ sender: Any) {
//        actionDelete?(book)
//    }
//    @IBAction func editPressed(_ sender: Any) {
//        actionEdit?(book)
//    }
//    
//    @IBAction func successPressed(_ sender: Any) {
//        actionSuccess?(book)
//    }
//    
//    @IBAction func payPressed(_ sender: Any) {
//        actionPay?(book)
//    }
//    @IBAction func btnRunPressed(_ sender: UIButton) {
//        actionRun?(book)
//    }
//    
//    @IBAction func btnDetailPressed(_ sender: UIButton) {
//        actionDetail?(book)
//    }

//    func setupButton(){
//        deleteBtn.isHidden = true
//        editBtn.isHidden = true
//        okBtn.isHidden = true
//        payBtn.isHidden = true
//        btnRun.isHidden = true
//        
//        switch book.status {
//        case 0:
//            deleteBtn.isHidden = false
//            editBtn.isHidden = false
//            btnRun.isHidden = false
////        case 1:
////            deleteBtn.isHidden = false
////
//        case 2:
//            deleteBtn.isHidden = false
//            editBtn.isHidden = false
//            payBtn.isHidden = false
//        case 3:
//            deleteBtn.isHidden = false
//            okBtn.isHidden = false
//            
//        default:
//            return
//        }
//    }
//    //    0: Chưa thực hiện //xoa, sua, run
//    //    1: hoàn thành // xoa
//    //    2: Chờ thanh toán // xoa, pay, edit
//    //    3: Đang thực hiện // xoa, tich
//    
//    @IBAction func btnViewDetaiPressed(_ sender: UIButton) {
//        
//    }
//    
}
